package org.werelate.controllers
{
	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;
	
	import mx.core.Application;
	import mx.logging.ILogger;
	import mx.logging.Log;
//	import mx.managers.PopUpManager;
	
	import org.swizframework.controller.AbstractController;
//	import org.werelate.comps.PromptView;
	import org.werelate.model.ModelUtils;
	import org.werelate.shared.Utils;
	
	public class PromptController extends AbstractController
	{
		[Autowire(bean="mainController")]
		public var mc : MainController;
		
		//private var pv: PromptView;
		//private var isVisible:Boolean;
		private var matchedDatas:Array;
		 
		private static const log:ILogger = Log.getLogger("org.werelate.controllers.PromptController");
		
		public function PromptController():void {
			//pv = new PromptView();
			//isVisible = false;
			matchedDatas = new Array();									
		}

		private function isQualified(data:XML):Boolean {
			return (data.@exclude != 'true' && data.@living != 'true' && 
					  data.@match.toString().length == 0 && 
					  data.@matches.toString().length > 0);
		}	
			
		public function startMatching():void {
//			if (!isVisible) {
				while (matchedDatas.length > 0) {
					var data:XML = matchedDatas.pop() as XML;
					if (isQualified(data)) {
						//isVisible = true;
						// select the item and show the compare page
						Utils.dispatchDynamicEvent("gedcom:setSelectedItem", 
							{data:data, component:ModelUtils.MATCHES});
						mc.selectedItemUpdated(data, ModelUtils.MATCHES);
						mc.compareItem(data);
						// don't show the merge view
						//pv.init(data);
						//PopUpManager.addPopUp(pv, DisplayObject(Application.application), true);
						//PopUpManager.centerPopUp(pv);
						break;
					}
				}
//			}
		}
		
		public function hasNext():Boolean {
			for each (var data:XML in matchedDatas) {
				if (isQualified(data)) return true;
			}
			return false;
		}
		
		public function hidePromptView():void {
			//PopUpManager.removePopUp(pv);
			//isVisible = false;
		}
		
		public function windowResize():void { // !!! remove
//			if (isVisible) {
//				PopUpManager.centerPopUp(pv);
//			}
		}
		
		public function addMatchedData(data:XML):void {
			matchedDatas.push(data);
		}
		
		public function match():void {
			ExternalInterface.call("parent.content.doGedcomMatch");
		}
		
		public function merge():void {
			ExternalInterface.call("parent.content.doGedcomPrepareToMerge");
		}
		
		public function notMatch():void {
			ExternalInterface.call("parent.content.doGedcomNotMatch");
		}
		
		public function matchAll():void {
			ExternalInterface.call("parent.content.doGedcomMatchAll");
		}
		
		public function cancel():void {
//			if (isVisible) {
//				hidePromptView();
//			}
			matchedDatas = new Array(); // clear the stack
		}
	}
}