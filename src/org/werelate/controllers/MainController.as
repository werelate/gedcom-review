package org.werelate.controllers
{
	import com.gskinner.StringUtils;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
import mx.controls.DataGrid;
import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
import mx.printing.FlexPrintJob;
import mx.printing.FlexPrintJobScaleType;
import mx.printing.PrintDataGrid;
import mx.resources.ResourceManager;
	import mx.rpc.events.ResultEvent;
	import mx.utils.URLUtil;
	
	import org.swizframework.controller.AbstractController;
import org.werelate.comps.WarningsPrint;
import org.werelate.model.Model;
	import org.werelate.model.ModelUtils;
	import org.werelate.services.SharedObjectService;
	import org.werelate.services.WeRelateService;
	import org.werelate.shared.PleaseWait;
	import org.werelate.shared.Utils;
	
	[ResourceBundle("messages")]
	public class MainController extends AbstractController
	{
		public static const MARK_UNREAD:String = "Mark unread";
		public static const MAKE_ROOT:String = "Set as root";
		public static const FETCH_GEDCOM:String = "View GEDCOM";
		public static const FETCH_WERELATE:String = "View matched";
		public static const EXCLUDE:String = "Exclude";
		public static const UNLINK:String = "Unlink matched";
		public static const FIND_ADD:String = "Find/add matching";
		public static const FIND_REFS:String = "What references this";

		private static const RESULT_NOMATCH:int = 0;
		private static const RESULT_MATCH:int = 1;
		private static const RESULT_MERGE:int = 2;
		
		[Autowire(bean="server")]
		public var server:String;
		[Autowire]
		public var model : Model;
		[Autowire]
		public var mu : ModelUtils;
		[Autowire]
		public var ml : ModelLoader;
		[Autowire]
		public var mac : MatchAllController;
		[Autowire]
		public var wr : WeRelateService;
		[Autowire]
		public var so : SharedObjectService;
		[Autowire]
		public var ie : IncludeExclude;
		[Autowire]
		public var tac : TipAlertController;
		[Autowire]
		public var uc : UnlinkController;
		[Autowire]
		public var wc : WLHController;
		
		[Embed(source="/images/warning.png")]
		private var WarningIcon:Class;
		
		[Embed(source="/images/info.png")]
		private var InfoIcon:Class;
		
		[Embed(source="/images/question.png")]
		private var QuestionIcon:Class;

//		private var excludeData:XML;
		private var sentData:XML;
		private var matchResult:int;
		private var _pleaseWait:PleaseWait = null;
		private var _loader:URLLoader = null;

		private static const log:ILogger = Log.getLogger("org.werelate.controllers.MainController");

		//
		// init
		//
		
		public function init():void {
			model.gedcomId = Application.application.parameters.gedcomId;
			
			if (ExternalInterface.available) {
			   try {
			       ExternalInterface.addCallback("loadGedcomId", loadGedcomId);
			       ExternalInterface.addCallback("matchFound", matchFound);
			       ExternalInterface.addCallback("matchesFound", matchesFound);
			       ExternalInterface.addCallback("browserUrlChange", browserUrlChange);
			       ExternalInterface.addCallback("pageUpdated", pageUpdated);
                ExternalInterface.addCallback("getWarnings", getWarnings);
			   } catch (error:SecurityError) {
			       throw new Error("A SecurityError occurred: " + error.message + "\n");
			   } catch (error:Error) {
			       throw new Error("An Error occurred: " + error.message + "\n");
			   }
			}
			else {
				throw new Error("ExternalInterface not available\n");
			}
			
			// connect to browser manager
//			browserManager = BrowserManager.getInstance();
//			browserManager.addEventListener(BrowserChangeEvent.BROWSER_URL_CHANGE, browserUrlChange);
//			browserManager.init(null, "Review GEDCOM");

			// read gedcom from werelate into model, apply data overrides, and update counts
			_pleaseWait = Utils.showPleaseWait(null, DisplayObject(Application.application), 
										"bytes read - opening GEDCOM");
			_pleaseWait.total = 0;
			_pleaseWait.countSuffix = 'k';
			_loader = wr.readGedcom(model.gedcomId, readGedcom_progress, readGedcom_result, readGedcom_fault);
//			var chain:CommandChain = new CommandChain(CommandChain.SERIES);
//			chain.addCommand(createCommand(wr.readGedcom, [model.gedcomId], readGedcom_result, wr.service_fault))
//				  .addCommand(createCommand(wr.readGedcomData, [model.gedcomId], readGedcomData_result, wr.service_fault));
//			chain.completeHandler = gedcomLoaded;
//			chain.proceed();
		}
		
		private function readGedcom_progress(event:ProgressEvent):void {
//			_pleaseWait.total = event.bytesTotal;
			_pleaseWait.count = event.bytesLoaded / 1024;
		}
		
		private function readGedcom_fault(event:Event):void {
			readGedcom_cleanup();
			Alert.show(event.toString(), "Unable to complete request", 
							Alert.OK, null, null, WarningIcon);
		}
		
		private function readGedcom_cleanup():void {
			Utils.hidePleaseWait(); 
			_pleaseWait = null; 
			_loader = null;
		}

		private function readGedcom_result(event:Event):void {
			var gedcom:XML = new XML(_loader.data);
			if (gedcom != null && (gedcom.@status == undefined || gedcom.@status == 0)) {
				ml.loadGedcom(gedcom);
				executeServiceCall(wr.readGedcomData(model.gedcomId), readGedcomData_result, readGedcom_fault);
			}
			else {
				readGedcom_cleanup();
				wr.statusError(gedcom);
			}
		}
		
		private function readGedcomData_result(event:ResultEvent):void {
			readGedcom_cleanup();
			var data:XML = event.result as XML;
			if (data != null && (data.@status == undefined || data.@status == 0)) {
				ml.loadGedcomData(data);
				ml.modelLoaded();
			}
			// don't tell them about errors they likely already received			
			else if (data == null || 
						(data.@status != WeRelateService.STATUS_NOT_SIGNED_IN &&
						 data.@status != WeRelateService.STATUS_NOT_AUTHORIZED &&
						 data.@status != WeRelateService.STATUS_NOT_FOUND)) { 
				wr.statusError(data);
			}
		}
		
		//
		// exclude, living, read
		//
		
		public function toggleExclude(data:XML):void {
			log.info("toggleExclude");
//			if (data.@exclude == 'true' && ie.isOnExcludeBorder(data)) {
//				// ask about including relatives
//				this.excludeData = data;
//				Alert.show("Also include relatives now reachable from root?",
//							   "Include relatives too?", 
//							   Alert.YES | Alert.NO,
//							   null,
//							   toggleExcludeHandler,
//							   QuestionIcon);
//			}
//			else {
				ml.setExclude(data, data.@exclude == 'true' ? 'false' : 'true'); //data.@exclude != 'true');
//			}
		}
		
//		private function toggleExcludeHandler(event:CloseEvent):void
//		{
//			ml.setExclude(this.excludeData, 'false', event.detail == Alert.YES);
//			this.excludeData = null;
//		} 
		
		public function toggleLiving(data:XML):void {
			ml.setLiving(data, data.@living == 'true' ? 'false' : 'true');
         if (data.@living == 'true' && data.@exclude != 'true') {
            toggleExclude(data);
         }
		}
		
		public function markRead(data:XML, component:int):Boolean {
			var itemChanged:Boolean = false;
			if ((component == ModelUtils.PLACES || component == ModelUtils.SOURCES) && data.@read != 'true') {
				ml.setRead(data, 'true');
				itemChanged = true;
			}
			else if (component == ModelUtils.WARNINGS && data.@warningRead != 'true') {
				ml.setWarningRead(data, 'true');
				itemChanged = true;
			}
			else if (component == ModelUtils.MATCHES && data.@matchRead != 'true') {
				ml.setMatchRead(data, 'true');
				itemChanged = true;
			}
			else if (component == ModelUtils.UPDATES && data.@updateRead != 'true') {
				ml.setUpdateRead(data, 'true');
				itemChanged = true;
			}
			if (itemChanged) {
				so.readItem(model.gedcomId, component, data.@id);
			}
			return itemChanged;
		}
		
		public function markUnread(data:XML, component:int):Boolean {
			var itemChanged:Boolean = false;
			if ((component == ModelUtils.PLACES || component == ModelUtils.SOURCES) && data.@read == 'true') {
				ml.setRead(data, 'false');
				itemChanged = true;
			}
			else if (component == ModelUtils.WARNINGS && data.@warningRead == 'true') {
				ml.setWarningRead(data, 'false');
				itemChanged = true;
			}
			else if (component == ModelUtils.MATCHES && data.@matchRead == 'true') {
				ml.setMatchRead(data, 'false');
				itemChanged = true;
			}
			else if (component == ModelUtils.UPDATES && data.@updateRead == 'true') {
				ml.setUpdateRead(data, 'false');
				itemChanged = true;
			}
			if (itemChanged) {
				so.unreadItem(model.gedcomId, component, data.@id);
			}
			return itemChanged;
		}
		
		//
		// buttons
		//
		
		public function readyToImport():void {
			var warning:String = '';
			
			// check for pre-1500 birthdate or marriage
			var page:XML;
			var date:String;
			var found:Boolean = false;
			if (!found) {
				for each (page in model.people) {
					date = page.@stdDate.toString();
					if (page.@exclude != 'true' && date.length > 0 && int(date.substr(0,4)) <= 1500) {
						found = true;
						break;
					}
				}
			}
			if (!found) {
				for each (page in model.families) {
					date = page.@stdDate.toString();
					if (page.@exclude != 'true' && date.length > 0 && int(date.substr(0,4)) <= 1500) {
						found = true;
						break;
					}
				}
			}
			if (found) {
				warning += "medieval people";
			}
			
			// check for absence of sources or notes
			found = false;
			var temp:XML;
			for each (page in model.people) {
				if (page.@exclude != 'true') {
					for each (temp in page.source_citation) found = true;
					for each (temp in page.note) found = true;
				}
				if (found) break;
			}
			for each (page in model.families) {
				if (page.@exclude != 'true') {
					for each (temp in page.source_citation) found = true;
					for each (temp in page.note) found = true;
				}
				if (found) break;
			}
			if (!found) {
				if (warning.length > 0) warning += '; ';
				warning += "no sources/notes";
			}
			 
			updateGedcomStatus(ModelUtils.STATUS_PHASE3, warning);
		}

		public function returnToReview():void {
			updateGedcomStatus(ModelUtils.STATUS_PHASE2);
		}

      public function putOnHold():void {
         updateGedcomStatus(ModelUtils.STATUS_HOLD);
      }
		
		public function visitUserTalk():void {
			loadPageTitle('User talk:' + model.userName); 
		}		
		
		public function returnToWeRelate():void {
			ExternalInterface.call("loadParentContent", "https://"+server);
		}
		
		public function removeGedcom():void {
			Alert.show("Are you sure you want to remove your GEDCOM from import? " + 
							"If you remove your GEDCOM, the work you have done to prepare your GEDCOM for import will be lost.",
						 "Are you sure?", Alert.YES | Alert.NO, null, removeGedcomHandler, QuestionIcon);
		}
		private function removeGedcomHandler(event:CloseEvent):void
		{
			if (event.detail == Alert.YES) {
				updateGedcomStatus(ModelUtils.STATUS_DELETE);
			}
		} 

		private function updateGedcomStatus(status:int, warning:String = ''):void {
			executeServiceCall(wr.updateGedcomStatus(model.gedcomId, status, warning), updateGedcomStatus_result, wr.service_fault);
		}
		public function updateGedcomStatus_result(event:ResultEvent):void {
			var result:XML = event.result as XML;
			if (result == null || (result.@status != undefined && result.@status != 0)) {
				wr.statusError(result);
			}
			else {
				ml.setStatus(result.@gedcomStatus);

				var msg:String;
				var parms:Array = null;
				if (result.@gedcomStatus == ModelUtils.STATUS_DELETE) {
					msg = 'statusdelete';
				}
				else if (result.@gedcomStatus == ModelUtils.STATUS_WAITING) {
					msg = 'statuswaiting';
				}
				else if (result.@gedcomStatus == ModelUtils.STATUS_ANALYZING) {
					msg = 'statusanalyzing';
				}
				else if (result.@gedcomStatus == ModelUtils.STATUS_PHASE2) {
					msg = 'statusphase2';
				}
				else if (result.@gedcomStatus == ModelUtils.STATUS_PHASE3) {
					msg = 'statusphase3';
				}
				else if (result.@gedcomStatus == ModelUtils.STATUS_ADMIN_REVIEW) {
					msg = 'adminReview';
				}
            else if (result.@gedcomStatus == ModelUtils.STATUS_HOLD) {
               msg = 'statushold';
            }
				else {
					msg = 'statusother';
					parms = [result.@gedcomStatus.toString()];
				}
				Alert.show(ResourceManager.getInstance().getString('messages', msg, parms),
								"GEDCOM updated", Alert.OK, null, updateGedcomStatusHandler, InfoIcon);
			}
		}
		private function updateGedcomStatusHandler(event:CloseEvent):void
		{
			returnToWeRelate();
		}
		
		public function updateStats():void {
			ml.updateCounts();
		}
		 
		//
		// menu actions
		// 
		
		public function makeRoot(data:XML):void {
			ml.updatePrimary(data);
		}
		
		// remove beginning and trailing , spaces
		private function trimPlace(s:String):String {
			return s.replace(/^[ ,]+|[ ,]+$/g, '');
		}
		
		private function getPlaceNameLocatedIn(data:XML):Array {
			var place:String = trimPlace(data.@text);
			var locatedIn:String = '';
			var pos:int = place.indexOf(',');
			if (pos > 0) {
				locatedIn = trimPlace(place.substr(pos+1));
				place = trimPlace(place.substr(0, pos));
			}
			var fields:Array = new Array(2);
			fields[0] = place;
			fields[1] = locatedIn;
			return fields;
		}
		
		private function notUpdatable():void {
				Alert.show("This GEDCOM has been marked \"Ready to import\".  Pages can no longer be matched or merged until after the import is complete.",
								"Unable to complete request", Alert.OK, null, null, InfoIcon);
		}
		
		public function findAddItem(data:XML, component:int):void {
			if (!model.isUpdatable) {
				notUpdatable();
			}
			else {
				this.sentData = data;
				log.info("findAddItem id={0} ns={1}", data.@id, data.@ns); 
				if (data.@ns == ModelUtils.NS_FAMILY || data.@ns == ModelUtils.NS_PERSON) {
					var findAddData:XML = mu.prepareFindAddData(data);
					executeServiceCall(wr.sendPageData(findAddData), findAddItem_result, wr.service_fault);
				}
				else if (data.@ns == ModelUtils.NS_MYSOURCE || data.@ns == ModelUtils.NS_PLACE) {
					var parms:Object = new Object();
					parms.namespace = data.@ns.toString();
					if (data.@ns == ModelUtils.NS_MYSOURCE) {
						parms.namespace = ModelUtils.NS_SOURCE;
						parms.st = data.title[0] != null ? data.title[0].toString() : '';
						parms.a = data.author[0] != null ? data.author[0].toString() : '';
	//					parms.p = data.author[0] != null ? data.author[0].toString() : '';
					}
					else if (data.@ns == ModelUtils.NS_PLACE) {
						log.info("findAddItem place");
						var fields:Array = getPlaceNameLocatedIn(data);
						parms.pn = fields[0];
						parms.li = fields[1];
					}
					parms.target = 'gedcom';
					parms.gedcomtab = component;
					parms.gedcomkey = data.@id.toString();
					loadPageTitle("Special:AddPage", parms);
					tac.showTip(model.gedcomId, data.@ns == ModelUtils.NS_MYSOURCE ? TipAlertController.FIND_ADD_SOURCE
																										: TipAlertController.FIND_ADD_PLACE);
				}
			}
		}
		public function findAddItem_result(event:ResultEvent):void {
			var result:XML = event.result as XML;
			if (result != null && (result.@status == undefined || result.@status == 0)) {
				var parms:Object = new Object();
				parms.ns = ModelUtils.NAMESPACES[this.sentData.@ns.toString()];
				parms.match='on';					
				parms.pagetitle = mu.getGedcomPageTitle(this.sentData);
				parms.gedcomtab = mu.getDefaultComponent(this.sentData.@ns);
				parms.gedcomkey = this.sentData.@id.toString();
				loadPageTitle("Special:Search", parms);
			}
			else {
				wr.statusError(result);				
			}
		}
		
		public function findRefs(data:XML): void {
			wc.show(data);
		}
		
		public function mergeItem(data:XML):void {
			if (!model.isUpdatable) {
				notUpdatable();
			}
			else {
				this.sentData = data;
				log.info("mergeItem id={0} ns={1}", data.@id, data.@ns); 
				var findAddData:XML = mu.prepareFindAddData(data);
				executeServiceCall(wr.sendPageData(findAddData), mergeItem_result, wr.service_fault);
			}
		}
		public function addMerge(ref:XML, lhs:String, rhs:String, parms:Object):Boolean {
			var person:XML = model.personMap[ref.@id];
			if (person && person.@match.toString().length > 0) {
				parms[lhs] = mu.getGedcomPageTitle(person);
				parms[rhs] = person.@match.toString();
				return true;
			}
			return false;
		}
		public function mergeItem_result(event:ResultEvent):void {
			var result:XML = event.result as XML;
			if (result != null && (result.@status == undefined || result.@status == 0)) {
				var parms:Object = new Object();
				parms.gedcom = 'true';
				parms.formAction = 'Merge';
				parms.ns = ModelUtils.NAMESPACES[this.sentData.@ns.toString()];
				parms.maxpages = 2;
				parms.m_0 = mu.getGedcomPageTitle(this.sentData);
				parms.m_1 = this.sentData.@match.toString();
				if (this.sentData.@ns == ModelUtils.NS_FAMILY) {
					var node:XML;
					var match:Object;
					for each (node in this.sentData.husband) {
						addMerge(node, 'mh_0', 'mh_1', parms);
					}
					for each (node in this.sentData.wife) {
						addMerge(node, 'mw_0', 'mw_1', parms);
					}
					var numChildren:int = 0;
					for each (node in this.sentData.child) {
						if (addMerge(node, 'mc_0_'+numChildren, 'mc_1_'+numChildren, parms)) {
							parms['mcr_0_'+numChildren] = numChildren+1;
							parms['mcr_1_'+numChildren] = numChildren+1;
							numChildren++;
						}
					}
					parms.maxchildren = numChildren; 
				}
				parms.gedcomtab = ModelUtils.MATCHES;
				parms.gedcomkey = this.sentData.@id.toString();
				loadPageTitle("Special:Merge", parms);
				if (!uc.isVisible()) {
					tac.showTip(model.gedcomId, TipAlertController.MERGE);
				}
			}
			else {
				wr.statusError(result);				
			}
		}
		
		public function compareItem(data:XML):void {
			if (!model.isUpdatable) {
				notUpdatable();
			}
			else {
				this.sentData = data;
				log.info("compareItem id={0} ns={1}", data.@id, data.@ns); 
				var compareData:XML = mu.prepareFindAddData(data);
				executeServiceCall(wr.sendPageData(compareData), compareItem_result, wr.service_fault);
			}
		}
		public function compareItem_result(event:ResultEvent):void {
			var result:XML = event.result as XML;
			if (result != null && (result.@status == undefined || result.@status == 0)) {
				var parms:Object = new Object();
				parms.ns = ModelUtils.NAMESPACES[this.sentData.@ns.toString()];
				parms.compare=mu.getGedcomPageTitle(this.sentData)+'|'+this.sentData.@matches.toString();
				parms.gedcomtab = ModelUtils.MATCHES;
				parms.gedcomkey = this.sentData.@id.toString();
				loadPageTitle("Special:Compare", parms);
				tac.showTip(model.gedcomId, TipAlertController.MATCH);
			}
			else {
				wr.statusError(result);				
			}
		}
		
		public function fetchGedcomItem(data:XML):void {
			loadPageData(data);			
		}
		
		public function fetchWeRelateItem(data:XML):void {
			var ns:int = int(data.@ns);
			if (ns == ModelUtils.NS_MYSOURCE) ns = ModelUtils.NS_SOURCE;
			loadPageTitle(ModelUtils.NAMESPACES[ns]+':'+data.@match.toString());
		}
		
		public function unlinkItem(data:XML):void {
			if (data.@ns == ModelUtils.NS_PERSON) {
				ml.setMatch(data, '');
			}
			else {
				uc.show(data);
			}
		}
		
  		public function fetchItem(data:XML, component:int):void {
			log.info("fetchItem");
  			if (data != null) {
				if (component == ModelUtils.PEOPLE || component == ModelUtils.FAMILIES ) {
               fetchGedcomItem(data);
            } else if (component == ModelUtils.SOURCES) {
               if (!model.isMatchable) {
                  loadPageTitle(ModelUtils.NOT_MATCHABLE_PAGE);
               }
               else if (data.@match.toString().length > 0) {
                  fetchWeRelateItem(data);
               }
               else {
                  fetchGedcomItem(data);
               }
            } else if (component == ModelUtils.WARNINGS) {
					fetchGedcomItem(mu.getWarningPersonFamily(data));
				}
				else if (component == ModelUtils.PLACES) {
               if (!model.isMatchable) {
                  loadPageTitle(ModelUtils.NOT_MATCHABLE_PAGE);
               }
					else if (data.@match.toString().length > 0) {
						fetchWeRelateItem(data);
					}
					else {
						findAddItem(data, component);
//						log.info("search place");
//						var parms:Object = new Object();
//						parms.ns = ModelUtils.NAMESPACES[data.@ns.toString()};
//						var fields:Array = getPlaceNameLocatedIn(data);
//						parms.pn = fields[0];
//						parms.li = fields[1];
//						parms.target = 'gedcom';
//						loadPageTitle("Special:Search", parms);
					}
				}
				else { // MATCHES
               if (!model.isMatchable) {
                  loadPageTitle(ModelUtils.NOT_MATCHABLE_PAGE);
               }
					else if (data.@match.toString().length > 0) {
						if (model.isMergeable && data.@merged != 'true') {
							mergeItem(data);							
						}
						else {
							fetchWeRelateItem(data);
						}
					}
					else if (data.@matches.toString().length > 0) {
						compareItem(data);
					}
					else { // should never happen
						findAddItem(data, component);
					}
				}
  			}
         else if (model.status == ModelUtils.STATUS_HOLD && component == 1) {
              visitUserTalk();
           }
  			else {
  				// can't pass in parms with # anchor 
  				//var parms:Object = new Object();
				//parms.gedcomtab = component;
				//parms.gedcomkey = '';
				loadPageTitle(ModelUtils.HELPPAGES[component]);
  			}
		}
		
		public function fetchMatchedItem():void {
			if (this.sentData) {
				if (this.matchResult == RESULT_MERGE) {
					// don't do anything
				}
				else if (this.matchResult == RESULT_MATCH) {
					fetchItem(this.sentData, ModelUtils.MATCHES);
				}
				else { // RESULT_NOMATCH
					fetchGedcomItem(this.sentData);
				}
			}
		}
		
		public function windowResize():void {
		}
		
		//
		// callback functions
		//
		
		[Mediate(event="mainController:loadGedcomId", properties="id")]		
		public function loadGedcomId(id:String):void {
			var dataComponent:Object = mu.getDataComponent(id);
			if (dataComponent != null) {
				// set selected tab and item
				Utils.dispatchDynamicEvent("gedcom:setSelectedItem", 
									{data:dataComponent.data, component:dataComponent.component});
				// select item
				selectedItemUpdated(dataComponent.data, dataComponent.component);
				fetchItem(dataComponent.data, dataComponent.component);
			}				
		}
		
		public function matchFound(title:String):void {
			log.info("matchFound title={0}", title);
			ml.setMatch(this.sentData, title);
		}
		
		public function matchesFound(matchesString:String, merged:Boolean, all:Boolean):void {
			log.info("matchesFound matches={0} merged={1}", matchesString, merged);
			var matchesString:String = StringUtils.trim(matchesString);
			if (matchesString.length > 0) {
				this.matchResult = merged ? RESULT_MERGE : RESULT_MATCH;
				var matches:Array = matchesString.split("\n");
				var datas:Array = new Array();
				var titles:Array = new Array();
				for each (var match:String in matches) {
					var success:Boolean = false;
					var fields:Array = match.split('|', 2);
					if (fields.length == 2) { 
						var title:String = fields[0];
						var dataComponent:Object = mu.getDataComponent(fields[1]);
						if (title && dataComponent) {
							var data:XML = dataComponent.data as XML;
							datas.push(data);
							titles.push(title);
							success = true;
						}
					}
					if (!success) {
						Alert.show("Invalid match: please contact dallan@werelate.org", "Unable to process match");
					}
				}
				if (datas.length > 0) {
					ml.setMatches(datas, titles, true, merged, all ? matchRelatedMatches : addRelatedMatches);
				}
			}
			else { // got a nomatch
				ml.setMatch(this.sentData, '');  // clear potential matches
				this.matchResult = RESULT_NOMATCH;
				fetchMatchedItem(); 
			}
		}
		private function addRelatedMatches(matchedFamilies:Array, matchedTitles:Array):void {
			fetchMatchedItem();
			 
			if (matchedFamilies.length > 0) {
				ml.setPotentialMatches(matchedFamilies, matchedTitles);
			}
		}
		private function matchRelatedMatches(matchedFamilies:Array, matchedTitles:Array):void {
			fetchMatchedItem();
			
			for (var i:int = 0; i < matchedTitles.length; i++) {
				mac.addFamilyMatch(matchedFamilies[i] as XML, matchedTitles[i] as String);
			}
			mac.startMatching();
		}
		
		private function getQueryParms(url:String):Object {
			var title:String = null;
			var o:Object = null;
			var pos:int = url.indexOf('?');
			if (pos >= 0) {
				o = URLUtil.stringToObject(url.substr(pos+1), '&');
				if (o != null && (o.gedcomtab == undefined || o.gedcomkey == undefined)) {
					if (o.title != undefined) title = o.title; // try to get gedcom tab and key from title below
					o = null;
				}
			}
			else {
				pos = url.indexOf('/wiki/');
				if (pos >= 0) {
					title = url.substr(pos+6);
				}
			}
			// try to get gedcom tab and key from title
			if (title != null) {
				var id:String = mu.getGedcomKey(title);
				if (id != null) {
					o = new Object();
					o.gedcomkey = id;
					var dataComponent:Object = mu.getDataComponent(id);
					o.gedcomtab = dataComponent.component;
				}
				else {
					// look for help page matches
					for (var i:String in ModelUtils.HELPPAGES) {
						if (title == ModelUtils.HELPPAGES[i]) {
							o = new Object();
							o.gedcomkey = '';
							o.gedcomtab = i;
							break;
						}
					}
				}
			}
			return o;
		}
		
		private function browserUrlChange(url:String):void {
			log.info("broswerUrlChange url={0}", url);
			var o:Object = getQueryParms(url);
			if (o != null) {
				log.info("broswerUrlChange tab={0} key={1}", o.gedcomtab, o.gedcomkey);
				var data:XML = null; 
				if (o.gedcomkey.length > 0) {
					var dataComponent:Object = mu.getDataComponent(o.gedcomkey);
					if (dataComponent != null) data = dataComponent.data;
				}
				// set selected tab and item
				Utils.dispatchDynamicEvent("gedcom:setSelectedItem", 
										{data: data, component: o.gedcomtab});
				// do we need to reload the page?
				if (url.indexOf('Special:GedcomPage') >= 0 && !o.action) {
					fetchItem(data, o.gedcomtab);
				}
			}
		}

		private function pageUpdated(id:String):void {
			log.info("pageUpdated {0}", id);
			executeServiceCall(wr.readGedcomPageData(model.gedcomId, id), pageUpdated_result, wr.service_fault);
		}
      private function isNonLiving(s:String):Boolean {
         return (s != null && s.length > 0 && s.toLowerCase() != 'living' && s.toLowerCase() != 'private');
      }
		private function pageUpdated_result(event:ResultEvent):void {
			var result:XML = event.result as XML;
			if (result != null && (result.@status == undefined || result.@status == 0)) {
				var dataComponent:Object = mu.getDataComponent(result.@key);
				if (dataComponent != null && result.text().length() > 0) {
					// get old mysource refs
					var oldMySources:ArrayCollection = mu.getMySourceCitationIds(dataComponent.data);
					// update
					ml.updateData(dataComponent.data, result.text()[0]);
               // did the update make the person non-living?
               var deathDate:String = dataComponent.data.event_fact.(@type=='Death').@date;
               var deathPlace:String = dataComponent.data.event_fact.(@type=='Death').@place;
               var burialDate:String = dataComponent.data.event_fact.(@type=='Burial').@date;
               var burialPlace:String = dataComponent.data.event_fact.(@type=='Burial').@place;
               if (dataComponent.data.@living == 'true' &&
                       (isNonLiving(deathDate) || isNonLiving(deathPlace) || isNonLiving(burialDate) || isNonLiving(burialPlace))) {
                  ml.setLiving(dataComponent.data, 'false');
               }

					dataComponent.data.@edited = 'true';
					// get new mysource refs
					var newMySources:ArrayCollection = mu.getMySourceCitationIds(dataComponent.data);
					updateMySourceInclusion(oldMySources, newMySources);
				}
			}
			else {
				wr.statusError(result);
			}
		}
		private function updateMySourceInclusion(oldMySources:ArrayCollection, newMySources:ArrayCollection):void {
			// for each added mysource ref, make sure it's included
			var id:String;
			var ms:XML;
			for each (id in newMySources) {
				if (!oldMySources.contains(id)) {
					ms = model.sourceMap[id];
					if (ms != null && ms.@exclude == 'true') {
						// include ms
						ml.setExclude(ms, 'false');
					}
				}
			}
			// for each removed mysource ref, exclude it if no other refs
			for each (id in oldMySources) {
				if (!newMySources.contains(id)) {
					ms = model.sourceMap[id];
					if (ms != null && ms.@exclude != 'true' && mu.getReferences(ms).length == 0) {
						// exclude ms
						ml.setExclude(ms, 'true');
					}
				}
			}
		}
		
		//
		// support functions
		//
				
		public function selectedItemUpdated(data:XML, component:int):void {
			
			// mark item read
			if (data != null) {
				markRead(data, component);
			}
			
			// save browser state
//			var o:Object = {id: data ? data.@id.toString() : '', tab: component};
//			var s:String = URLUtil.objectToString(o);
//			log.info("selectedItemUpdated fragment={0}", s);
//         browserManager.setFragment(s);
  		}
  
		public function selectContextMenu(cm:ContextMenu, data:XML, component:int):void {
			log.info("selectContextMenu");
			for each (var cmItem:ContextMenuItem in cm.customItems) {
				if (data == null) {
					cmItem.enabled = false;
				}
				else if (cmItem.caption == MARK_UNREAD) {
					if (component == ModelUtils.SOURCES || component == ModelUtils.PLACES) {
						cmItem.enabled = (data.@read == 'true');
					}
					else if (component == ModelUtils.WARNINGS) {
						cmItem.enabled = (data.@warningRead == 'true');
					}
					else if (component == ModelUtils.MATCHES) {
						cmItem.enabled = (data.@matchRead == 'true');
					}
					else if (component == ModelUtils.UPDATES) {
						cmItem.enabled = (data.@updateRead == 'true');
					}
				}
				else if (cmItem.caption == MAKE_ROOT) {
					cmItem.enabled = model.isUpdatable;
				}
				else if (cmItem.caption.indexOf(FETCH_GEDCOM) == 0) {
					cmItem.enabled = (component != ModelUtils.PLACES);
				}
				else if (cmItem.caption.indexOf(FETCH_WERELATE) == 0) {
					cmItem.enabled = (data.@match.toString().length > 0);
				}
				else if (cmItem.caption.indexOf(EXCLUDE) == 0) {
					cmItem.enabled = (data != model.primaryPerson && model.isUpdatable && data.@exclude != 'true');
				}
				else if (cmItem.caption.indexOf(UNLINK) == 0) {
					cmItem.enabled = (data.@match.toString().length > 0 && model.isUpdatable);
				}
				else if (cmItem.caption.indexOf(FIND_ADD) == 0) {
					cmItem.enabled = (model.isUpdatable && model.isMatchable);
				}
			} 
		}

		public function loadPageTitle(pageTitle:String, parms:Object = null, newWindow:Boolean=false):void {
			var url:String = "https://" + server;
			if (parms) {
				url += "/w/index.php?title="+Utils.encodeWikiURIComponent(pageTitle)+'&'+URLUtil.objectToString(parms, '&');
			}
			else {
				url += "/wiki/" + Utils.encodeWikiURIComponent(pageTitle);
			} 
			log.info("loadPageTitle url={0}", url);
			if (newWindow) {
				ExternalInterface.call("loadContentNewWindow", url);
			}
			else {
				ExternalInterface.call("loadContent", url);
			}
		}
		
		public function loadPageData(data:XML):void {
			var clone:XML = mu.preparePageData(data); // DON'T set find/add to true; if you do you won't be able to edit
			// send data to WeRelate
			log.info("loadPageData "+clone.toXMLString());
			this.sentData = data;
			executeServiceCall(wr.sendPageData(clone), sendPageData_result, wr.service_fault);
		}
		
		private function sendPageData_result(event:ResultEvent):void {
			var result:XML = event.result as XML;
			if (result != null && (result.@status == undefined || result.@status == 0)) {
				var parms:Object = new Object();
				parms.gedcomtab = mu.getDefaultComponent(this.sentData.@ns);
				parms.gedcomkey = this.sentData.@id.toString();
				parms.gedcomid = model.gedcomId;
            // only admins can edit pages that aren't mergeable
				if (model.isUpdatable && (model.isMergeable || model.isAdmin)) {
					parms.editable = 'true';
				}
            //parms.cacheBuster=Math.floor(Math.random() * 65536).toString();
				loadPageTitle('Special:GedcomPage', parms);
			}
			else {
				wr.statusError(result);
			}
		}

      public function printWarnings(app:Application, warnings:DataGrid):void {
         var printJob:FlexPrintJob = new FlexPrintJob();
         if (printJob.start()) {
            // Create a FormPrintView control as a child of the application.
            var thePrintView:WarningsPrint = new WarningsPrint();
            app.addChild(thePrintView);

            // Set the print view properties.
            thePrintView.width=printJob.pageWidth;
            thePrintView.height=printJob.pageHeight;

            // Set the data provider of the FormPrintView component's DataGrid to be the data provider of the displayed DataGrid.
            thePrintView.myDataGrid.dataProvider = warnings.dataProvider;

            while (true) {
               printJob.addObject(thePrintView);
               if (!thePrintView.myDataGrid.validNextPage) {
                  break;
               }
               thePrintView.pageNumber++;
               thePrintView.myDataGrid.nextPage();
            }

            // All pages are queued; remove the FormPrintView control to free memory.
            app.removeChild(thePrintView);

            // Send the job to the printer.
            printJob.send();
         }
      }

      private function getWarnings():String {
         var tbl:String = '<table><tr><th>Person/Family</th><th>Description</th><th>Level</th></tr>';
         for each (var warning:XML in model.warnings) {
            tbl += '<tr><td>'+Utils.escapeXML(mu.getPersonFamilyName(mu.getWarningPersonFamily(warning)))+
                    '</td><td>'+Utils.escapeXML(warning.@warning)+
                    '</td><td>'+Utils.escapeXML(mu.getWarningLevelDesc(warning))+'</td></tr>';
         }
         tbl += '</table>';
         return tbl;
      }

	}
}