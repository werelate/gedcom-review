package org.werelate.services
{
	import flash.net.SharedObject;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class SharedObjectService
	{
		private var mySO:SharedObject;
		
		private static const log:ILogger = Log.getLogger("org.werelate.services.SharedObjectService");
		
		public function SharedObjectService() {
			mySO = SharedObject.getLocal('preferences');
			if (!mySO.data.exists) {
				mySO.data.exists = true;
				mySO.data.readFlags = new Object();
				mySO.data.noShowTips = new Object();
			}
			else { // expire old data
				var now:Date = new Date();
				var expirationPeriod:Number = 1000 * 60 * 60 * 24 * 31; // one month
				var cutoffTime:Number = (new Date((new Date()).getTime() - expirationPeriod)).getTime();
				var found:Boolean = false;
				var key:String;
				for (key in mySO.data.readFlags) {
					if (mySO.data.readFlags[key] < cutoffTime) {
						found = true;
						delete mySO.data.readFlags[key];
					}
				}
				for (key in mySO.data.noShowTips) {
					if (mySO.data.noShowTips[key] < cutoffTime) {
						found = true;
						delete mySO.data.noShowTips[key];
					}
				}
				if (found) {
					mySO.flush();
				}
			}
		}
		
		private function getItemKey(gedcomId:int, component:int, id:String = ''):String {
			return gedcomId+'|'+component+'|'+id;
		}
		
		private function getTipKey(gedcomId:int, tipId:String):String {
			return gedcomId+'|'+tipId;
		}
		
		public function readItem(gedcomId:int, component:int, id:String):void {
			var key:String = getItemKey(gedcomId, component, id);
			var time:Number = (new Date()).getTime();
			mySO.data.readFlags[key] = time;
			mySO.flush(); 
		}
		
		public function unreadItem(gedcomId:int, component:int, id:String):void {
			var key:String = getItemKey(gedcomId, component, id);
			if (mySO.data.readFlags[key]) {
				delete mySO.data.readFlags[key];
			}
			mySO.flush();
		}
		
		public function getReadItems(gedcomId:int, component:int):Object {
			var readItems:Object = new Object();
			var searchKey:String = getItemKey(gedcomId, component);
			for (var key:String in mySO.data.readFlags) {
				if (key.substr(0, searchKey.length) == searchKey) {
					key = key.substr(searchKey.length)
					readItems[key] = true;
				}
			}
			return readItems;
		}
		
		public function getNoShowTip(gedcomId:int, tipId:String):Boolean {
			var key:String = getTipKey(gedcomId, tipId);
			return mySO.data.noShowTips[key] != null;
		}
		
		public function setNoShowTip(gedcomId:int, tipId:String):void {
			var key:String = getTipKey(gedcomId, tipId);
			var time:Number = (new Date()).getTime();
			mySO.data.noShowTips[key] = time;
			mySO.flush();
		}
	}
}
