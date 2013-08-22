package org.werelate.shared
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.events.DynamicEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.PopUpManager;
	
	import org.swizframework.Swiz;
	
	//
	// This class borrows from but is not the same as com.genefun.shared.Utils
	//
	public class Utils
	{
		private static const log:ILogger = Log.getLogger("org.werelate.shared.Utils");

		public static function dispatchDynamicEvent(type:String, obj:Object):void {
      	var event : DynamicEvent = new DynamicEvent(type);
      	for (var key:String in obj) {
   			event[key] = obj[key];
        	}
        	log.info("dispatchDynamicEvent {0}", type);
        	Swiz.dispatchEvent(event);
		}
		
		// escapes a string so we can embed it in XML
		public static function escapeXML(s:String):String
		{
			return s.replace(/&/g, "&amp;")
					  .replace(/</g, "&lt;")
					  .replace(/>/g, "&gt;")
					  .replace(/\\'/g, "&apos;")
					  .replace(/\\"/g, "&quot;");
		}
		
		// escapes a string so we can embed it in HTML
		public static function htmlspecialchars(s:String):String
		{
			return s.replace(/&/g, "&amp;")
					  .replace(/</g, "&lt;")
					  .replace(/>/g, "&gt;")
					  .replace(/\\"/g, "&quot;");
		}
		
		private static const slashRegExp:RegExp = /%2F/g;
		private static const colonRegExp:RegExp = /%3A/g;
		private static const spaceRegExp:RegExp = /%20/g;
		private static const hashRegExp:RegExp = /%23/g;

		public static function encodeWikiURIComponent(url:String):String {
			// MediaWiki wants /'s in titles to not be encoded
			// and we might as well unencode :'s so the titles look better
			// also, we need to unencode #'s and spaces
			return encodeURIComponent(url).
				replace(colonRegExp, ":").replace(slashRegExp, "/").replace(spaceRegExp, '_').replace(hashRegExp, '#');
		}
		
		private static var _pleaseWait:PleaseWait;
		private static var _pleaseWaitCallback:Function;
		private static var _pleaseWaitCallbackParams:Array;
		
		public static function showPleaseWait(callbackFunction:Function, parent:DisplayObject, message:String, callbackParams:Array = null, delay:int = 250):PleaseWait
		{
			_pleaseWait = new PleaseWait();
			_pleaseWait.init("Please Wait", -1, message);
			PopUpManager.addPopUp(_pleaseWait, parent, true);
			PopUpManager.centerPopUp(_pleaseWait);
//			_pleaseWaitAlert = Alert.show("Please wait...", "", Alert.OK, parent);
//			_pleaseWaitAlert.mx_internal::alertForm.mx_internal::buttons[0].enabled = false;
//			_pleaseWaitAlert.mx_internal::alertForm.removeChild(_pleaseWaitAlert.mx_internal::alertForm.mx_internal::buttons[0]);
			_pleaseWaitCallback = callbackFunction;
			_pleaseWaitCallbackParams = callbackParams;
			
			if (callbackFunction != null) {
				var t:Timer = new Timer(delay); // wait for the screen to refresh before calling the callback function
				t.addEventListener(TimerEvent.TIMER, pleaseWaitTimer);
				t.start();
			}
			return _pleaseWait;
		}
		
		private static function pleaseWaitTimer(e:TimerEvent):void {
			var t:Timer = e.target as Timer;
			t.stop();
			t.removeEventListener(TimerEvent.TIMER, pleaseWaitTimer);
			
			if (_pleaseWaitCallback != null) {
				_pleaseWaitCallback.apply(null, _pleaseWaitCallbackParams);
				_pleaseWaitCallback = null;
				_pleaseWaitCallbackParams = null;
			}
		}
		
		public static function hidePleaseWait():void {
			if (_pleaseWait != null) {
				PopUpManager.removePopUp(_pleaseWait);
				_pleaseWait = null;
			}
		}

		private static function isYear(y:int):Boolean {
		   return y >= 1000 && y <= 2200;
		}
	    
	   private static var MONTHS:Dictionary = new Dictionary();
	   {
	      MONTHS["january"] = 1;
	      MONTHS["february"] = 2;
	      MONTHS["march"] = 3;
	      MONTHS["april"] = 4;
	      MONTHS["may"] = 5;
	      MONTHS["june"] = 6;
	      MONTHS["june"] = 6;
	      MONTHS["july"] = 7;
	      MONTHS["august"] = 8;
	      MONTHS["september"] = 9;
	      MONTHS["october"] = 10;
	      MONTHS["november"] = 11;
	      MONTHS["december"] = 12;
	      MONTHS["jan"] = 1;
	      MONTHS["feb"] = 2;
	      MONTHS["mar"] = 3;
	      MONTHS["apr"] = 4;
	      MONTHS["may"] = 5;
	      MONTHS["jun"] = 6;
	      MONTHS["jul"] = 7;
	      MONTHS["aug"] = 8;
	      MONTHS["sep"] = 9;
	      MONTHS["oct"] = 10;
	      MONTHS["nov"] = 11;
	      MONTHS["dec"] = 12;
	      MONTHS["febr"] = 2;
	      MONTHS["sept"] = 9;
	   }
	      
	   private static function getAlphaMonth(mon:String):int {
		     mon = mon.toLowerCase();
		     if (MONTHS[mon] != null) {
		             return MONTHS[mon];
		     }
		     return 0;
   		}  
   		private static function isDay(d:int):Boolean 
   		{
	      return d >= 1 && d <= 31;
	   }
	    
	   private static function isNumMonth(m:int):Boolean 
	   {
	      return m >= 1 && m <= 12;
	   }
	    
      private static var pAlphaNumRegExp:RegExp =  
        		new RegExp("\\d+|[^0-9\\s'~!@#$%^&*()_+\\-={}|:'<>?;,/\"\\[\\]\\.\\\\]+", "g");
        		
      public static function getDateSortKey(date:String):String {
	      var result:String = "";
	      if (date != null && date.length > 0)
	      {
	         var year:int = 0;
	         var month:int = 0;
	         var day:int = 0;
	         
	         var fields:Array = new Array();
	         var field:String;
	         for each (field in date.match(pAlphaNumRegExp))
	         {
	         	fields.push(field);
	         }
	         
	         for (var i:int = 0; i < fields.length; i++) {
	            field = fields[i];
	            var num:int = parseInt(field);
	            if (isYear(num))
	            {
	               if (year == 0) year = num;
	            } else if (getAlphaMonth(field) > 0)
	            {
	               if (month == 0) month = getAlphaMonth(field);
	            } else if (isDay(num) && (!isNumMonth(num) ||
	                  (i > 0 && getAlphaMonth(fields[i - 1]) > 0) ||
	                  (i < fields.length - 1 && getAlphaMonth(fields[i + 1]) > 0)))
	            {
	               if (day == 0) day = num;
	            } else if (i > 0 && isYear(parseInt(fields[i - 1])))
	            {
	               // ignore -- probably 1963/4
	            } else if (isNumMonth(num))
	            {
	               if (month == 0) month = num;
	            }
	         }
	
	         if (year > 0) {
	            result = String(year);
	            if (month > 0) {
	               result += (month < 10 ? "0" +
	                     String(month) : String(month));
	               if (day > 0) {
	                  result += (day < 10 ? "0" +
	                        String(day) : String(day));
	               }
	            }
	         }
	      }
	      return result;
	   } 
	}
}