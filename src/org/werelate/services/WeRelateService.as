package org.werelate.services
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
import flash.external.ExternalInterface;
import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPService;
	
	[ResourceBundle("messages")]
	public class WeRelateService
	{
		public static const STATUS_NOT_SIGNED_IN:int = -2;
		public static const STATUS_NOT_AUTHORIZED:int = -3;
		public static const STATUS_NOT_FOUND:int = -6;
      public static const STATUS_ON_HOLD:int = -8;

		[Autowire(bean="server")]
		public var server:String;
		
		[Embed(source="/images/warning.png")]
		private var WarningIcon:Class;
		
		[Embed(source="/images/info.png")]
		private var InfoIcon:Class;
		
		private static const log:ILogger = Log.getLogger("org.werelate.services.WeRelateService");

		private function getBaseURL():String {
			return 'http://'+server+'/w/index.php';
		}		
		
		private function sendAjaxService(functionName:String, parms:Object = null, method:String = "GET"):AsyncToken {
			var service:HTTPService = new HTTPService();
			service.url = getBaseURL(); 
			service.method = method
			service.resultFormat = 'e4x';
			var sendParms:Object = {'action' : 'ajax', 'rs' : functionName};
			var rsargs:String = '';
			if (parms is String) {
				rsargs = parms as String;
			}
			else if (parms) {
				for (var key:String in parms) {
					if (rsargs.length > 0) rsargs += '|';
					rsargs += key + '=' + parms[key];
				}
			}
			if (rsargs.length > 0) {
				sendParms['rsargs'] = rsargs;
			}
			return service.send(sendParms);
		}

       private function handleFatalError(event:CloseEvent):void {
         ExternalInterface.call("loadParentContent", "https://"+server);
      }
		
		public function service_fault(event:FaultEvent):void {
			Alert.show(event.fault.message, "Unable to complete request", 
							Alert.OK, null, handleFatalError, WarningIcon);
		} 
		
		public function statusError(result:XML):void {
			var msg:String;
			var parms:Array = null;
			var status:int = result ? int(result.@status) : 404;
			if (status == STATUS_NOT_SIGNED_IN) {
				msg='notsignedin';
			}
			else if (status == STATUS_NOT_AUTHORIZED) {
				msg = 'notauthorized';
			}
			else if (status == STATUS_NOT_FOUND) {
				msg = 'gedcomnotfound';				
			}
         else if (status == STATUS_ON_HOLD) {
            msg = 'gedcomhold';
         }
			else {
			 	msg = 'unexpectederror';
				parms = [status];
			}
			Alert.show(ResourceManager.getInstance().getString('messages', msg, parms),
								"Unable to complete request", Alert.OK, null, handleFatalError, WarningIcon);
		}

		public function readGedcom(gedcomId:int, progressHandler:Function, completeHandler:Function, errorHandler:Function):URLLoader {
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
 			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			var request:URLRequest = new URLRequest(getBaseURL()+"?action=ajax&rs=wfReadGedcom&rsargs=gedcom_id="+gedcomId);
			loader.load(request);
			return loader;
//			return sendAjaxService('wfReadGedcom', {gedcom_id : gedcomId});
		}
		
		public function readGedcomData(gedcomId:int):AsyncToken {
			return sendAjaxService('wfReadGedcomData', {gedcom_id : gedcomId});
		}
		
		public function updatePrimaryPage(gedcomId:int, primaryId:String):AsyncToken {
			return sendAjaxService('wfUpdateGedcomPrimary', {gedcom_id : gedcomId, primary: primaryId});
		}
		
		public function sendPageData(data:XML):AsyncToken {
			return sendAjaxService('wfSetGedcomPage', data.toXMLString(), "POST");
		}
		
		public function readGedcomPageData(gedcomId:int, key:String):AsyncToken {
			return sendAjaxService('wfReadGedcomPageData', {gedcom_id : gedcomId, key: key});
		}
		
		public function matchFamily(data:XML):AsyncToken {
			return sendAjaxService('wfMatchFamily', data.toXMLString(), "POST");
		}
		
		public function updateGedcomFlag(gedcomId:int, attr:String, value:String, keys:Object):AsyncToken {
			var key:String;
			var method:String;
			if (keys is Array) {
				key = (keys as Array).join("\n");
				method = "POST";
			}
			else {
				key = keys.toString();
				method = "GET";
			}
			return sendAjaxService('wfUpdateGedcomFlag', 
						{gedcom_id : gedcomId, attr: attr, value: value, key: key}, method);
		}
		
		public function saveMatches(gedcomId:int, prefixedTitles:Array, merged:Array, keys:Array):AsyncToken {
			return sendAjaxService('wfUpdateGedcomMatches',
						{gedcom_id : gedcomId, match: prefixedTitles.join("\n"), key: keys.join("\n"), merged: merged.join("\n")}, "POST"); 
		}
		
		// potential matches are unprefixed titles
		public function savePotentialMatches(gedcomId:int, potentialMatches:Array, keys:Array):AsyncToken {
			return sendAjaxService('wfUpdateGedcomPotentialMatches',
						{gedcom_id : gedcomId, matches: potentialMatches.join("\n"), key: keys.join("\n")}, "POST"); 
		}
		
		public function updateGedcomStatus(gedcomId:int, status:int, warning:String):AsyncToken {
			return sendAjaxService('wfUpdateGedcomStatus', {gedcom_id: gedcomId, gedcomStatus: status, warning: warning});
		}
		
	}
}