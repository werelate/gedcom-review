package org.werelate.controllers
{
	import com.gskinner.StringUtils;

import flash.external.ExternalInterface;

import mx.controls.Alert;
import mx.effects.IEffect;
import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	import org.werelate.model.Model;
	import org.werelate.model.ModelUtils;
	import org.werelate.services.SharedObjectService;
	import org.werelate.services.WeRelateService;
	import org.werelate.shared.Utils;
	
	[ResourceBundle("messages")]
	public class ModelLoader extends AbstractController
	{
		[Autowire]
		public var model : Model;
		[Autowire]
		public var mu : ModelUtils;
		[Autowire]
		public var so : SharedObjectService;
		[Autowire]
		public var wr : WeRelateService;
		[Autowire]
		public var ie : IncludeExclude;

		[Embed(source="/images/info.png")]
		private var InfoIcon:Class;

		[Embed(source="/images/warning.png")]
		private var WarningIcon:Class;
		
		private static const log:ILogger = Log.getLogger("org.werelate.controllers.ModelLoader");
		
		private static const NOMATCH:String = '#nomatch#';
		
		public static const UPDATE_DISTANCES_INIT:int = 0;
		public static const UPDATE_DISTANCES_EXCLUDE:int = 1;
		public static const UPDATE_DISTANCES_INCLUDE:int = 2;
      public static const ALLOWED_WARNINGS:int = 5;
      public static const WARNING_LOWER_THRESHOLD:Number = 2.0;
      public static const WARNING_UPPER_THRESHOLD:Number = 4.0;
		
		private static const NAME_MATCH_THRESHOLD:Number = 60;

		private var saveKeys: Array;
		
		//
		// support functions
		//

		private function itemUpdated(data:XML):void {
			var ns:int = data.@ns;
         if (data.@warningLevel != undefined) { // we're updating a warning
            model.warnings.itemUpdated(data);
         }
			else if (ns == ModelUtils.NS_PERSON || ns == ModelUtils.NS_FAMILY) {
            if (ns == ModelUtils.NS_PERSON) {
               model.people.itemUpdated(data);
            }
            else if (ns == ModelUtils.NS_FAMILY) {
               model.families.itemUpdated(data);
               if (data.@exclude != 'true' && (data.@match.toString().length > 0 || data.@matches.toString().length > 0)) {
                  model.addUpdateMatch(data);
               }
               else {
                  model.removeMatch(data);
               }
            }
            if (data.@warning.toString().length > 0 && data.@exclude != 'true') {
               model.addUpdateWarnings(data);
            }
            else {
               model.removeWarnings(data);
            }
			}
			else if (ns == ModelUtils.NS_PLACE) {
				model.places.itemUpdated(data);
			}
			else if (ns == ModelUtils.NS_MYSOURCE) {
				model.sources.itemUpdated(data);
			}
		}
		
		private function refreshViews():void {
			model.people.refresh();
			model.families.refresh();
			log.info("warnings count={0}", model.warnings.length);
			model.warnings.refresh();
			model.places.refresh();
			model.sources.refresh();
			log.info("matches count={0}", model.matches.length);
			model.matches.refresh();
			model.updates.refresh();
		}
		
		private function getTrueFalse(tf:int):String {
			if (tf > 0) {
				return 'true';
			}
			else if (tf < 0) {
				return 'false';
			}
			return '';
		}
		
		private function getPositiveNegative(tf:String):String {
			if (tf == 'true') {
				return '1';
			}
			else if (tf == 'false') {
				return '-1';
			}
			return '0';
		}
		
		private function saveFlag(attr:String, value:String, keys:Object):void {
			executeServiceCall(wr.updateGedcomFlag(model.gedcomId, attr, value, keys), saveFlag_result, wr.service_fault);
		}
		public function saveFlag_result(event:ResultEvent):void {
			log.info("saveFlag_result {0}", event.result);
			var result:XML = event.result as XML;
			if (result == null || (result.@status != undefined && result.@status != 0)) {
				wr.statusError(result);
			}
		}
		
		private function saveExclude(tf:String, ids:Object):void {
			saveFlag('exclude', getPositiveNegative(tf), ids);
		}
		
		private function saveLiving(tf:String, ids:Object):void {
			saveFlag('living', getPositiveNegative(tf), ids);
		}
		
		private function saveMerged(tf:String, ids:Object):void {
			saveFlag('merged', getPositiveNegative(tf), ids);
		}
		
		// gets potential matches back and saves them
		private function saveMatches(prefixedTitles:Array, merged:Array, keys:Array, handleRelatedMatches:Function):void {
			executeServiceCall(wr.saveMatches(model.gedcomId, prefixedTitles, merged, keys), 
										saveMatches_result, wr.service_fault, [handleRelatedMatches]);
		}
		public function saveMatches_result(event:ResultEvent, handleRelatedMatches:Function):void {
			log.info("saveMatches_result {0}", event.result);
			var result:XML = event.result as XML;
			var matchedTitles:Array = new Array();
			var matchedFamilies:Array = new Array();
			if (result == null || (result.@status != undefined && result.@status != 0)) {
				wr.statusError(result);
			}
			else {
				// process match results
				for each (var match:XML in result.match) {
					var id:String = match.@id;
					var dataComponent:Object = mu.getDataComponent(id);
					if (dataComponent && dataComponent.component == ModelUtils.PEOPLE) {
						mu.matchRelatedFamilies(dataComponent.data as XML, match, NAME_MATCH_THRESHOLD,
														matchedFamilies, matchedTitles);
					}
				}
            if (handleRelatedMatches != null) {
               handleRelatedMatches(matchedFamilies, matchedTitles);
            }
         }
		}
		
		private function savePotentialMatches(titles:Array, keys:Array):void {
			executeServiceCall(wr.savePotentialMatches(model.gedcomId, titles, keys), savePotentialMatches_result, wr.service_fault);
		}
		public function savePotentialMatches_result(event:ResultEvent):void {
			log.info("savePotentialMatches_result {0}", event.result);
			var result:XML = event.result as XML;
			if (result == null || (result.@status != undefined && result.@status != 0)) {
				wr.statusError(result);
			}
		}
		
		// 
		// update functions
		//

		private function saveIncludeExclude(exclude:String, updatedItems:Array):void {
			var saveKeys:Array = new Array();
			for each (var item:XML in updatedItems) {
				itemUpdated(item);
				saveKeys.push(item.@id);
			}
			if (saveKeys.length > 0) {
				saveExclude(exclude, saveKeys);
			}
		}
		
		public function updatePrimary(data:XML):void {
			log.info("updatePrimary");
			model.primaryPerson = data;
			data.@exclude = 'true'; // force inclusion of root's ancestors by marking root excluded to start
			var includedItems:Array = new Array();
			//ie.includeSelfAndAncestors(data, includedItems);
         ie.includeItem(data, includedItems);
			ie.updateRootDistances();
			refreshViews();
			executeServiceCall(wr.updatePrimaryPage(model.gedcomId, data.@id), makeRoot_result, wr.service_fault);
			saveIncludeExclude('false', includedItems);
		}
		public function makeRoot_result(event:ResultEvent):void {
			log.info("makeRoot_result {0}", event.result);
			var result:XML = event.result as XML;
			if (result == null || (result.@status != undefined && result.@status != 0)) {
				wr.statusError(result);
			}
		}

		public function setExclude(data:XML, exclude:String):void {
			var updatedItems:Array = new Array();
			if (exclude == 'true') {
				ie.excludeItem(data, updatedItems);
			}
			else {
				ie.includeItem(data, updatedItems);
			}
			saveIncludeExclude(exclude, updatedItems);
		}
		
		public function setLiving(data:XML, living:String):void {
			data.@living = living;
			itemUpdated(data);
			saveLiving(data.@living, data.@id);
			if (data.@ns == ModelUtils.NS_PERSON) {
				var ref:XML;
				for each (ref in data.spouse_of_family) {
					var family:XML = model.familyMap[ref.@id];
					if (family) {
						var spouse:XML;
						var spouseRef:XML;
						var familyIsLiving:String = 'false';
						for each (spouseRef in family.husband) {
							spouse = model.personMap[spouseRef.@id];
							if (spouse && spouse.@living == 'true') familyIsLiving = 'true';
						}
						for each (spouseRef in family.wife) {
							spouse = model.personMap[spouseRef.@id];
							if (spouse && spouse.@living == 'true') familyIsLiving = 'true'; 
						}
						if (family.@living.toString() != familyIsLiving) {
							setLiving(family, familyIsLiving);
						}
					}
				} 
			}
		}
		
		public function setRead(data:XML, read:String):void {
			data.@read = read;
			itemUpdated(data);
		}
		
		public function setWarningRead(data:XML, read:String):void {
			data.@warningRead = read;
			itemUpdated(data);
		}
		
		public function setMatchRead(data:XML, read:String):void {
			data.@matchRead = read;
			itemUpdated(data);
		}
		
		public function setUpdateRead(data:XML, read:String):void {
			data.@updateRead = read;
			itemUpdated(data);
		}
		
		public function setMatch(data:XML, title:String, save:Boolean = true, merged:Boolean = false):void {
			var datas:Array = new Array();
			datas.push(data);
			var titles:Array = new Array();
			titles.push(title);
			setMatches(datas, titles, save, merged);
		}
		
		public function setMatches(datas:Array, titles:Array, save:Boolean = true, merged:Boolean = false, 
											handleRelatedMatches:Function = null):void {
			var matchIds:Array = new Array();
			var mergeIds:Array = new Array();
			var toBeMerged:Array = new Array();
			var prefixedTitles:Array = new Array();
			var mergedTF:String = (merged ? 'true' : 'false');
			for (var i:int = 0; i < datas.length; i++) {
				var matchDiffers:Boolean = (datas[i].@match != titles[i]);
				datas[i].@match = titles[i];
				var mergeDiffers:Boolean = (datas[i].@merged != mergedTF);
				// if matching the same title and already merged, keep merged
				if (titles[i].length > 0 && !matchDiffers && datas[i].@merged == 'true' && !merged) {
					mergeDiffers = false;
				}
				else {
					datas[i].@merged = mergedTF;
				}
				if (titles[i].length == 0) {
					datas[i].@nomatch = 'true';
					datas[i].@matches = datas[i].@gedcomMatches.toString(); // reset title also resets pot matches to original matches
				}
				else {
					datas[i].@nomatch = '';
				}
				setMatchHelperFields(datas[i]);
				itemUpdated(datas[i]);
				if (save) {
					// if !merged, we want to push up all titles, even pre-matched/merged titles, 
					// so we get relatives back for handleRelatedMatches
					if (matchDiffers || !merged) {
						if (titles[i].length == 0) {
							prefixedTitles.push(NOMATCH);
						}
						else {
							// !!! hack - shouldn't assume that all MySource matches are Source's
							prefixedTitles.push(mu.getPrefixedTitle((datas[i].@ns == ModelUtils.NS_MYSOURCE ? ModelUtils.NS_SOURCE : datas[i].@ns.toString()), 
																				 titles[i]));
						} 
						matchIds.push(datas[i].@id.toString());
						toBeMerged.push(datas[i].@merged.toString());
					}
					else if (mergeDiffers) {
						mergeIds.push(datas[i].@id.toString());
					}
				}
			}
			if (save) {
				if (mergeIds.length > 0) saveMerged(mergedTF, mergeIds);
				if (matchIds.length > 0) {
					saveMatches(prefixedTitles, toBeMerged, matchIds, handleRelatedMatches);
				}
				else {
					handleRelatedMatches(new Array(), new Array());
				}
			}
		}
		
		public function setPotentialMatch(data:XML, title:String, save:Boolean = true):void {
			var datas:Array = new Array();
			datas.push(data);
			var titles:Array = new Array();
			titles.push(title);
			setPotentialMatches(datas, titles, save);
		}
		
		public function setPotentialMatches(datas:Array, titles:Array, save:Boolean = true):void {
			var ids:Array = new Array();
			for (var i:int = 0; i < datas.length; i++) {
				datas[i].@matches = (titles[i].length > 0 ? titles[i] : datas[i].@gedcomMatches.toString()); 
				setMatchHelperFields(datas[i]);
				itemUpdated(datas[i]);
				if (save) {
					ids[i] = datas[i].@id.toString();
				}
			}
			if (save) {
				savePotentialMatches(titles, ids);
			}
		}
		
		//
		// load model
		//
		
		public function updateCounts():void {
			var page:XML;
			
			var peopleToImport:int = 0;
			var peopleExcluded:int = 0;
			var peopleMatched:int = 0;
			for each (page in model.people) {
				if (page.@exclude == 'true') {
					peopleExcluded++;
				}
				else if (page.@match.toString().length == 0) {
					peopleToImport++;
				}
				else {
					peopleMatched++;
				}
			}
			if (peopleToImport != model.peopleToImport) model.peopleToImport = peopleToImport;
			if (peopleExcluded != model.peopleExcluded) model.peopleExcluded = peopleExcluded;
			if (peopleMatched != model.peopleMatched) model.peopleMatched = peopleMatched;

			var familiesToImport:int = 0;
			var familiesExcluded:int = 0;
			var familiesMatched:int = 0;
			for each (page in model.families) {
				if (page.@exclude == 'true') {
					familiesExcluded++;
				}
				else if (page.@match.toString().length == 0) {
					familiesToImport++;
				} 
				else {
					familiesMatched++;
				}
			}
			log.info("warnings read={0} unread={1}", warningsRead, warningsUnread);
			if (familiesToImport != model.familiesToImport) model.familiesToImport = familiesToImport;
			if (familiesExcluded != model.familiesExcluded) model.familiesExcluded = familiesExcluded;
			if (familiesMatched != model.familiesMatched) model.familiesMatched = familiesMatched;

			var warningsRead:int = 0;
			var warningsUnread:int = 0;
         var warningCount:int = 0;
         var dupCount:int = 0;
			for each (var warn:XML in model.warnings) {
            if (warn.@warningLevel >= 3) {
               dupCount++;
            }
            warningCount += parseInt(warn.@warningLevel);
				if (warn.@warningRead == 'true') {
					warningsRead++;
				}
				else {
					warningsUnread++;
				} 
			}
			log.info("warnings read={0} unread={1}", warningsRead, warningsUnread);
         var warningLevel:Number = (warningCount * 100.0 / (Math.max(peopleToImport+peopleMatched, 1.0)));
         if (warningCount != model.warningCount) model.warningCount = warningCount;
         if (warningLevel != model.warningLevel) model.warningLevel = warningLevel;
         if (dupCount != model.duplicateCount) model.duplicateCount = dupCount;
			if (warningsRead != model.warningsRead) model.warningsRead = warningsRead;
			if (warningsUnread != model.warningsUnread) model.warningsUnread = warningsUnread;
			
			var sourcesToImport:int = 0;
			var sourcesExcluded:int = 0;
			var sourcesMatched:int = 0;
			for each (page in model.sources) {
				if (page.@exclude == 'true') {
					sourcesExcluded++;
				}
				else if (page.@match.toString().length == 0) {
					sourcesToImport++;
				}
				else {
					sourcesMatched++;
				}
			}
			if (sourcesToImport != model.sourcesToImport) model.sourcesToImport = sourcesToImport;
			if (sourcesExcluded != model.sourcesExcluded) model.sourcesExcluded = sourcesExcluded;
			if (sourcesMatched != model.sourcesMatched) model.sourcesMatched = sourcesMatched;
         var totalNonExcludedSources: int = model.sourcesToImport + model.sourcesMatched + model.sourcesCitationOnly;
         if (totalNonExcludedSources != model.totalNonExcludedSources) model.totalNonExcludedSources = totalNonExcludedSources;

			var placesMatched:int = 0;
			var placesUnmatched:int = 0;			
			for each (page in model.places) {
				if (page.@match.toString().length == 0) {
					placesUnmatched++;
				}
				else {
					placesMatched++;
				}
			}
			if (placesMatched != model.placesMatched) model.placesMatched = placesMatched;
			if (placesUnmatched != model.placesUnmatched) model.placesUnmatched = placesUnmatched;

			var matchesMatched:int = 0;
			var matchesUnmatched:int = 0;
			var matchesUndecided:int = 0;			
			for each (page in model.matches) {
				if (page.@nomatch.toString() == 'true') {
					matchesUnmatched++
				}
				else if (page.@match.toString().length > 0) {
					matchesMatched++;
				}
				else {
					matchesUndecided++;
				}
			}
			log.info("matches undecided={0}", matchesUndecided);
			if (matchesMatched != model.matchesMatched) model.matchesMatched = matchesMatched; 
			if (matchesUnmatched != model.matchesUnmatched) model.matchesUnmatched = matchesUnmatched; 
			if (matchesUndecided != model.matchesUndecided) model.matchesUndecided = matchesUndecided; 
			
			var updatesMade:int = 0;
			var updatesNotMade:int = 0;			
			for each (page in model.updates) {
				if (page.@merged == 'true') {
					updatesMade++;
				}
				else {
					updatesNotMade++;
				} 
			}
			if (warningsRead != model.warningsRead) model.warningsRead = warningsRead;
			if (warningsUnread != model.warningsUnread) model.warningsUnread = warningsUnread;

			updateFlags();
		}

      private function isBelowLowerThreshold():Boolean {
         return (model.warningCount <= ALLOWED_WARNINGS || model.warningLevel < WARNING_LOWER_THRESHOLD);
      }

      private function isBelowUpperThreshold():Boolean {
         return (model.warningCount <= ALLOWED_WARNINGS || model.warningLevel < WARNING_UPPER_THRESHOLD);
      }

		private function updateFlags():void {
			var resourceManager:IResourceManager = ResourceManager.getInstance();

         if (isBelowLowerThreshold()) {
            model.warningComment = '';
         }
         else if (isBelowUpperThreshold()) {
            model.warningComment = resourceManager.getString('messages', 'warningsAboveLowerThreshold');
         }
         else {
            model.warningComment = resourceManager.getString('messages', 'warningsAboveUpperThreshold')
         }
         if (model.duplicateCount == 0) {
            model.duplicateComment = '';
         }
         else {
            model.duplicateComment = resourceManager.getString('messages', 'internalDuplicates');
         }
			model.isUpdatable = false;	
			model.isReturnable = false;
         model.isHoldable = false;
			model.isImportable = false;
         model.isMatchable = false;
			if (model.status == ModelUtils.STATUS_PHASE2) {
				var warnings:Array = new Array();
				if (model.warningsUnread > 0) {
					warnings.push(resourceManager.getString('messages', 'notReadyWarnings'));
				}
				if (model.matchesUndecided > 0) {
					warnings.push(resourceManager.getString('messages', 'notReadyFamilies'));
				}
            if (!isBelowUpperThreshold() || model.duplicateCount > 0) {
               model.importInstructions = resourceManager.getString('messages', 'notImportable');
            }
				else if (warnings.length > 0) {
               model.importInstructions = resourceManager.getString('messages', 'notReady')+'<li>'+
                                          warnings.join('<li>');
				}
            else if (!isBelowLowerThreshold()) {
               model.importInstructions = resourceManager.getString('messages', 'probablyNotImportable');
            }
				else {
               model.importInstructions = resourceManager.getString('messages', 'phase2');
				}
				model.isUpdatable = true;
            model.isImportable = ((isBelowUpperThreshold() && model.duplicateCount == 0 && warnings.length == 0) || model.isAdmin);
            model.isMatchable = ((isBelowUpperThreshold() && model.duplicateCount == 0) || model.isAdmin);
            model.isHoldable = model.isAdmin;
				model.nextSteps = resourceManager.getString('messages', 'nextsteps');
			}
         else if (model.status == ModelUtils.STATUS_HOLD) {
            model.nextSteps = resourceManager.getString('messages', 'onhold');
            model.isUpdatable = true;
            model.isReturnable = model.isAdmin;
         }
			else if (model.status == ModelUtils.STATUS_PHASE3 || model.status == ModelUtils.STATUS_IMPORTING) {
				model.importInstructions = model.nextSteps = resourceManager.getString('messages', 'phase3');			
			}
			else if (model.status == ModelUtils.STATUS_ADMIN_REVIEW && model.isAdmin) {
				model.importInstructions = resourceManager.getString('messages', 'adminReviewAdmin', [model.userName]);			
				model.nextSteps = resourceManager.getString('messages', 'nextsteps');
				model.isUpdatable = true;
				model.isReturnable = true;
				model.isImportable = true;
            model.isMatchable = true;
			}
         else if (model.status == ModelUtils.STATUS_ADMIN_REVIEW) {
            model.importInstructions = model.nextSteps = resourceManager.getString('messages', 'adminReview');
         }
         else if (model.status == 0) { // I don't know how they get in this status
            model.importInstructions = model.nextSteps = resourceManager.getString('messages', 'statuszero');
         }
			else {
				model.importInstructions = model.nextSteps = resourceManager.getString('messages', 'statusother', [model.status]);			
			}
         model.isMergeable = (model.isUpdatable && ((isBelowLowerThreshold() && model.duplicateCount == 0) || model.isAdmin));
		}

		private function setMatchHelperFields(data:XML):void {
			data.@stdMatch = data.@nomatch == 'true' ? NOMATCH : data.@match.toString().toLowerCase(); 
//			data.@matchesCount = (data.@matches.toString().length > 0 ? StringUtils.countOf(data.@matches.toString(), '|')+1 : '');
		}
		
		private function loadWarningsMatchesUpdates():void {
			var readWarnings:Object = so.getReadItems(model.gedcomId, ModelUtils.WARNINGS);
			var readMatches:Object = so.getReadItems(model.gedcomId, ModelUtils.MATCHES);
			var readUpdates:Object = so.getReadItems(model.gedcomId, ModelUtils.UPDATES);

			for each (var person:XML in model.people) {
				if (person.@exclude != 'true') {
					if (person.@warning.toString().length > 0) {
						model.addUpdateWarnings(person, readWarnings);
					}
					if (person.@updated == 'true') {
						person.@updateRead = (readUpdates[person.@id] ? 'true' : '');
						model.addUpdateUpdate(person);
					}
				}
//				if (person.@match.toString().length > 0 || person.@matches.toString().length > 0) {
//					setMatchHelperFields(person);
//					person.@matchRead = (readMatches[person.@id] ? 'true' : '');
//					model.addUpdateMatch(person);
//				}
			}

			var matchesCount:int = 0;
			for each (var family:XML in model.families) {
				if (family.@exclude != 'true') {
					if (family.@warning.toString().length > 0) {
						model.addUpdateWarnings(family, readWarnings);
					}
					if (family.@match.toString().length > 0 || family.@matches.toString().length > 0) {
						matchesCount++; 
						family.@matchRead = (readMatches[family.@id] ? 'true' : '');
						model.addUpdateMatch(family);
					}
					if (family.@updated == 'true') {
						family.@updateRead = (readUpdates[family.@id] ? 'true' : '');
						model.addUpdateUpdate(family);
					}
				}
			}
			log.info("family matches={1}", matchesCount);
		}
		
		private function setPrimary(id:String):void {
			if (id.length > 0) {
				var primary:XML = model.personMap[id];
				if (primary) {
					model.primaryPerson = primary;
				}
			}
		}
		
		private function createModelObjectFromContent(tag:String, content:String):XML {
			var content:String = content;
			var endTag:String = '</'+tag+'>';
			var endPos:int = content.indexOf(endTag) + endTag.length;
			var result:XML = new XML(content.substr(0, endPos));
			result.content = StringUtils.trim(content.substr(endPos));
			return result;
		}
		
		private function createModelObject(tag:String, page:XML):XML {
			var result:XML = createModelObjectFromContent(tag, page.content.toString());
			result.@id = page.@id.toString();
			result.@ns = page.@namespace.toString();
			result.@exclude = page.@exclude.toString();
         result.@living = page.@living.toString();
         result.@beforeCutoff = page.@beforeCutoff.toString();
			result.@match = page.@match.toString();
			result.@matches = page.@potentialMatches.toString();
			setMatchHelperFields(result);
			result.@gedcomMatches = page.@potentialMatches.toString();
			result.@warning = page.@problems.toString(); //.replace(/\|/g, ", ");
			return result;
		}
		
		private function setStdPersonAttrs(person:XML):void {
			person.@stdDate = Utils.getDateSortKey(person.event_fact.(@type=='Birth').@date);
			person.@stdDeathDate = Utils.getDateSortKey(person.event_fact.(@type=='Death').@date);
			person.@stdName = mu.getPersonFullName(person).toLowerCase();
		}
		
		private function setStdFamilyAttrs(family:XML):void {
			family.@stdHusbandName = mu.getFullName(family.husband[0]).toLowerCase();
			family.@stdWifeName = mu.getFullName(family.wife[0]).toLowerCase();
			family.@stdName = (family.@stdHusbandName.toString() + " and " + family.@stdWifeName.toString()).toLowerCase();
			family.@stdDate = Utils.getDateSortKey(family.event_fact.(@type=='Marriage').@date);
		}	
		
		private function setStdMySourceAttrs(mysource:XML):void {
			mysource.@stdName = mu.getMySourceName(mysource, null).toLowerCase();
			mysource.@stdAuthor = mysource.author.toString().toLowerCase();
		}
		
		// copy everything but relationships
		private function copyData(target:XML, source:XML):void {
			delete target.*;
//			for (var i:int = target.children().length()-1; i >= 0; i--) {
//				delete target.children()[i];					 	
//			}
			for each (var elm:XML in source.children()) {
				target.appendChild(elm);
			}
		}

		public function updateData(data:XML, text:String):void {
			log.info("updateData in={0}", data.toXMLString());
			log.info("updateData new={0}", text);
			var result:XML = null;
			if (data.@ns == ModelUtils.NS_PERSON) {
				result = createModelObjectFromContent('person', text);
				copyData(data, result);
				setStdPersonAttrs(data);
			}
			else if (data.@ns == ModelUtils.NS_FAMILY) {
				result = createModelObjectFromContent('family', text);
				copyData(data, result);
				setStdFamilyAttrs(data);
			}
			else if (data.@ns == ModelUtils.NS_MYSOURCE) {
				result = createModelObjectFromContent('mysource', text);
				copyData(data, result);
				setStdMySourceAttrs(data);
			}
			log.info("updateData out={0}", data.toXMLString());
			itemUpdated(data);
		}

		public function loadGedcom(gedcom:XML):void {
			model.people.removeAll();
			model.families.removeAll();
			model.sources.removeAll();
			model.places.removeAll();
			
			var readPlaces:Object = so.getReadItems(model.gedcomId, ModelUtils.PLACES);
			var readSources:Object = so.getReadItems(model.gedcomId, ModelUtils.SOURCES);

			for each (var page:XML in gedcom.page) {
				if (page.@namespace == ModelUtils.NS_PERSON) {
					var person:XML = createModelObject('person', page);
					setStdPersonAttrs(person);
					model.addPerson(person);
				}
				else if (page.@namespace == ModelUtils.NS_FAMILY) {
					var family:XML = createModelObject('family', page);
					setStdFamilyAttrs(family);
					model.addFamily(family);
				}
				else if (page.@namespace == ModelUtils.NS_MYSOURCE) {
					var mysource:XML = createModelObject('mysource', page);
					setStdMySourceAttrs(mysource);
					mysource.@read = (readSources[mysource.@id] ? 'true' : '');
					model.addSource(mysource);
				}
			}
			
         if (gedcom.@citation_only_sources) {
            model.sourcesCitationOnly = parseInt(gedcom.@citation_only_sources);
         }

			setPrimary(gedcom.@primary_person);
			if (model.primaryPerson == null && model.people.length > 0) {
				model.primaryPerson = model.people.getItemAt(0) as XML;
			}
			
			for each (var p:XML in gedcom.place) {
				var place:XML = <place/>;
				place.@id = p.@key.toString();
				place.@ns = ModelUtils.NS_PLACE;
				place.@text = p.@text.toString();
				place.@stdName = p.@text.toString().toLowerCase();
				place.@bestMatch = p.@title.toString();
				if (p.@error.toString().length == 0) { // ignore matches that have errors
					place.@match = p.@title.toString();
				}
				else {
					place.@match = '';
				}
				setMatchHelperFields(place);
				place.@read = (readPlaces[place.@id] ? 'true' : '');
				model.addPlace(place);
			}
		}
		
		public function loadGedcomData(data:XML):void {
			model.userName = data.@username.toString();
			model.isOwner = (data.@owner == 'true');
			model.isAdmin = (data.@admin == 'true');
log.info("loadGedcomData userName={0} isOwner={1} isAdmin={2}", model.userName, model.isOwner, model.isAdmin);			
			setStatus(data.@gedcomStatus);
//			if (data.@reviewer.toString().length > 0) {
//				Alert.show("This GEDCOM is currently being reviewed by "+data.@reviewer,
//								"GEDCOM under review", Alert.OK, null, null, InfoIcon);
//			}
			
			setPrimary(data.@primary);
			
			for each (var row:XML in data.result) {
				var dataComponent:Object = mu.getDataComponent(row.@key);
				if (dataComponent) {
					var data:XML = dataComponent.data;
					var match:String = row.@match.toString();
					if (row.text().length() > 0) {
						updateData(data, row.text()[0]);
						data.@edited = 'true';
					}
					if (row.@exclude != undefined && row.@exclude != 0) {
						data.@exclude = getTrueFalse(row.@exclude);
					}
               if (row.@living != undefined && row.@living != 0) {
                  data.@living = getTrueFalse(row.@living);
               }
					if (row.@merged != undefined && row.@merged != 0) {
						data.@merged = getTrueFalse(row.@merged);
					}
					if (match.length > 0) {
						if (match == NOMATCH) {
							data.@match = '';
							data.@nomatch = 'true';
						}
						else {
							data.@match = mu.getUnprefixedTitle(match);
						}
						setMatchHelperFields(data);
					}
					if (row.@matches.toString().length > 0) {
						data.@matches = row.@matches.toString();
						setMatchHelperFields(data);
					}
				}
			}
		}
		
		public function modelLoaded():void {
			log.info("modelLoaded");
			// calculate distance
			ie.updateRootDistances();

			loadWarningsMatchesUpdates();
			refreshViews();
			
			// update counts
			updateCounts();

         if (model.status == ModelUtils.STATUS_HOLD) {
            ExternalInterface.call("loadContent", "/wiki/"+Utils.encodeWikiURIComponent("User_talk:"+model.userName));
         }
		}
		
		public function setStatus(status:int):void {
			model.status = status;
			updateFlags();
		}
	}
}
