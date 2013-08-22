package org.werelate.controllers
{
	import mx.collections.ArrayCollection;
	
	import org.swizframework.controller.AbstractController;
	import org.werelate.comps.WLHDialog;
	import org.werelate.model.Model;
	import org.werelate.model.ModelUtils;
	import org.werelate.shared.Utils;
	
	public class WLHController extends AbstractController
	{
		[Autowire]
		public var model : Model;
		[Autowire]
		public var mu : ModelUtils;

		private var wlhDialog:WLHDialog;
		
		public function show(data:XML):void {
			var references:ArrayCollection = mu.getReferences(data);
			wlhDialog = new WLHDialog();
			wlhDialog.init(references);
			wlhDialog.show();
		}
		
		public function goto(pf:XML):void {
			wlhDialog = null;
			if (pf != null) {
				Utils.dispatchDynamicEvent("mainController:loadGedcomId", {id: pf.@id}); 
			}
		}
		
		public function isVisible():Boolean {
			return wlhDialog != null;
		}
	}
}
