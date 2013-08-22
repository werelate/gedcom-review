package org.werelate.controllers
{
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.swizframework.controller.AbstractController;
	import org.werelate.comps.UnlinkDialog;
	import org.werelate.model.ModelUtils;
	
	public class UnlinkController extends AbstractController
	{
		[Autowire]
		public var mu : ModelUtils;
		[Autowire]
		public var ml : ModelLoader;

		private static const log:ILogger = Log.getLogger("org.werelate.controllers.UnlinkController");

		private var family:XML;
		private var unlinkDialog:UnlinkDialog;
		
		public function UnlinkController() {
			family = null;
			unlinkDialog = null;
		}
		
		public function show(family:XML):void {
			var members:ArrayCollection = new ArrayCollection();
			var ref:XML;
			var data:XML;
			for each (ref in family.husband) {
				data = mu.getPersonFamilyData(ref.@id, ModelUtils.NS_PERSON);
				if (data.@match.toString().length > 0) members.addItem(data);
			}
			for each (ref in family.wife) {
				data = mu.getPersonFamilyData(ref.@id, ModelUtils.NS_PERSON);
				if (data.@match.toString().length > 0) members.addItem(data);
			}
			for each (ref in family.child) {
				data = mu.getPersonFamilyData(ref.@id, ModelUtils.NS_PERSON);
				if (data.@match.toString().length > 0) members.addItem(data);
			}
			if (members.length > 0) {
				this.family = family;
				unlinkDialog = new UnlinkDialog();
				unlinkDialog.init(members);
				unlinkDialog.show();
			}
			else {
				ml.setMatch(family, '');
			}
		}
		
		public function unlink(unlink:Boolean, members:Array):void {
			unlinkDialog = null;
			if (unlink) {
				members.push(family);
				var titles:Array = new Array();
				for (var i:int = 0; i < members.length; i++) {
					titles.push('');
				}
				ml.setMatches(members, titles);
			}
		}
		
		public function isVisible():Boolean {
			return unlinkDialog != null;
		}
	}
}