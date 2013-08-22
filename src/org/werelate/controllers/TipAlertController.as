package org.werelate.controllers
{
	import mx.resources.ResourceManager;
	
	import org.swizframework.controller.AbstractController;
	import org.werelate.comps.TipAlert;
	import org.werelate.services.SharedObjectService;
	
	public class TipAlertController extends AbstractController
	{
		public static const MATCH:String = 'tip_match';
		public static const MERGE:String = 'tip_merge';
		public static const FIND_ADD_PLACE:String = 'tip_find_add_place';
		public static const FIND_ADD_SOURCE:String = 'tip_find_add_source';
		
		[Autowire]
		public var so : SharedObjectService;

		private var visibleTip:TipAlert;
		
		public function TipAlertController() {
			visibleTip = null;
		}
		
		public function showTip(gedcomId:int, tipId:String):void {
			// do we need to show the tip?
			if (!so.getNoShowTip(gedcomId, tipId)) {
				// if so, get the tip message
				var tipMessage:String = ResourceManager.getInstance().getString('messages', tipId)
				// show the tip alert
				if (visibleTip) {
					visibleTip.hide();
				}
				visibleTip = new TipAlert();
				visibleTip.init(gedcomId, tipId, tipMessage);
				visibleTip.show();
			}
		}
		
		public function ok(gedcomId:int, tipId:String, noShow:Boolean):void {
			// remove the tip
			visibleTip = null;			
			// don't show the tip in the future?
			if (noShow) {
				so.setNoShowTip(gedcomId, tipId);
			}
		}
	}
}