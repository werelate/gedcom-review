package org.werelate.controllers
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	import org.werelate.model.Model;
	import org.werelate.model.ModelUtils;
	import org.werelate.services.WeRelateService;
	
	public class MatchAllController extends AbstractController
	{
		[Autowire]
		public var model:Model;
		[Autowire]
		public var mu : ModelUtils;
		[Autowire]
		public var ml : ModelLoader;
		[Autowire]
		public var wr : WeRelateService;
		
		private static const log:ILogger = Log.getLogger("org.werelate.controllers.MatchAllController");

		private static const NAME_MATCH_THRESHOLD:Number = 60;

		private var familyMatches:Array;
		private var isMatching:Boolean;
		
		public function MatchAllController()
		{
			familyMatches = new Array();
			isMatching = false;			
		}
		
		public function addFamilyMatch(data:XML, title:String):void {
			familyMatches.push(title+'|'+data.@id.toString());
		}
		
		private function matchFamily(family:XML, title:String):void {
			var matchData:XML = mu.prepareFindAddData(family);
			matchData.@match = title;
			matchData.@id = family.@id.toString();
			executeServiceCall(wr.matchFamily(matchData), matchFamily_result, wr.service_fault);
		}
		private function matchFamily_result(event:ResultEvent):void {
			var error:Boolean = false;
			log.info("matchFamily_result {0}", event.result);
			var result:XML = event.result as XML;
			if (result == null || (result.@status != undefined && result.@status != 0)) {
				wr.statusError(result);
				error = true;
			}
			else {
				var matchedFamilies:Array = new Array();
				var matchedFamilyTitles:Array = new Array();
				var matchedPF:Array = new Array();
				var unmatchedPF:Array = new Array();
				var matchedPFTitles:Array = new Array();
				var unmatchedPFTitles:Array = new Array();
				for each (var match:XML in result.match) {
					var id:String = match.@id;
					var dataComponent:Object = mu.getDataComponent(id);
					var pf:XML = dataComponent.data as XML;
					// set match or potential matches
log.info("match id={0} match={1} matches={2}", match.@id, match.@match, match.@matches);					
					if (match.@match.toString().length > 0) {
						matchedPF.push(pf);
						matchedPFTitles.push(mu.getUnprefixedTitle(match.@match.toString()));
						// for matching people, read relatives + get related families
						if (dataComponent.component == ModelUtils.PEOPLE) {
							mu.matchRelatedFamilies(pf, match, NAME_MATCH_THRESHOLD,
															matchedFamilies, matchedFamilyTitles);
						}
					}
					else if (match.@matches.toString().length > 0) {
						unmatchedPF.push(pf);
						unmatchedPFTitles.push(match.@matches.toString());
					}
				}
				// set match or potential matches
log.info("matchedPF size={0}", matchedPF.length);					
log.info("unmatchedPF size={0}", unmatchedPF.length);					
				if (matchedPF.length > 0) {
					ml.setMatches(matchedPF, matchedPFTitles, false);
				}
				if (unmatchedPF.length > 0) {
					ml.setPotentialMatches(unmatchedPF, unmatchedPFTitles, false);
				}
				
				// post related families on stack
				for (var i:int = 0; i < matchedFamilies.length; i++) {
					addFamilyMatch(matchedFamilies[i], matchedFamilyTitles[i]);
				}
			}
			isMatching = false;
			if (!error) {
				startMatching();
			} 
		}
		
		public function startMatching():Boolean {
			if (!isMatching) {
				while (familyMatches.length > 0) {
					var match:String = familyMatches.pop() as String;
					var fields:Array = match.split('|', 2);
					var title:String = fields[0];
					var family:XML = model.familyMap[fields[1]];
					if (family.@exclude != 'true' && family.@living != 'true' && 
						 family.@match.toString().length == 0) { 
						isMatching = true;
						matchFamily(family, title);
						break;
					}
				}
			}
			return isMatching;
		}
	}
}
