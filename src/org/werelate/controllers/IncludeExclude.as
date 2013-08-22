package org.werelate.controllers
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.swizframework.controller.AbstractController;
	import org.werelate.model.Model;
	import org.werelate.model.ModelUtils;
	
	public class IncludeExclude extends AbstractController
	{
		[Autowire]
		public var model : Model;
		[Autowire]
		public var mu : ModelUtils;

		private static const log:ILogger = Log.getLogger("org.werelate.controllers.IncludeExclude");
		
		private function getRefDistance(id:String, ns:int):int {
			var data:XML = mu.getPersonFamilyData(id, ns);
			return (data ? data.@distance : ModelUtils.NOT_CONNECTED);
		}
		
		// get distance for id by looking at immediate relatives
		private function getMinDistance(data:XML):int {
			if (data.@distance == 0) return 0; // root
			var dist:int = ModelUtils.NOT_CONNECTED;
			var relRef:XML;
			var refDist:int;
			if (data.@ns == ModelUtils.NS_PERSON) {
				for each (relRef in data.child_of_family) {
					dist = Math.min(dist, getRefDistance(relRef.@id, ModelUtils.NS_FAMILY));
				} 
				for each (relRef in data.spouse_of_family) {
					dist = Math.min(dist, getRefDistance(relRef.@id, ModelUtils.NS_FAMILY));
				}
			}
			else {
				for each (relRef in data.husband) {
					dist = Math.min(dist, getRefDistance(relRef.@id, ModelUtils.NS_PERSON));
				} 
				for each (relRef in data.wife) {
					dist = Math.min(dist, getRefDistance(relRef.@id, ModelUtils.NS_PERSON));
				} 
				for each (relRef in data.child) {
					dist = Math.min(dist, getRefDistance(relRef.@id, ModelUtils.NS_PERSON));
				} 
			}
			if (dist != ModelUtils.NOT_CONNECTED) dist = dist+1;
			return dist; 
		}
		
//		private function getMinRelativeDistance(data:XML):int {
//			var minDist:int = ModelUtils.NOT_CONNECTED;
//			var ref:XML;
//			var relDist:int;
//			if (data.@ns == ModelUtils.NS_PERSON) {
//				for each (ref in data.child_of_family) {
//					relDist = getAltDistance(ref.@id, ModelUtils.NS_FAMILY, data.@id);
//					if (relDist < minDist) minDist = relDist;
//				} 
//				for each (ref in data.spouse_of_family) {
//					relDist = getAltDistance(ref.@id, ModelUtils.NS_FAMILY, data.@id);
//					if (relDist < minDist) minDist = relDist;
//				}
//			}
//			else {
//				for each (ref in data.husband) {
//					relDist = getAltDistance(ref.@id, ModelUtils.NS_PERSON, data.@id);
//					if (relDist < minDist) minDist = relDist;
//				}
//				for each (ref in data.wife) {
//					relDist = getAltDistance(ref.@id, ModelUtils.NS_PERSON, data.@id);
//					if (relDist < minDist) minDist = relDist;
//				}
//				for each (ref in data.child) {
//					relDist = getAltDistance(ref.@id, ModelUtils.NS_PERSON, data.@id);
//					if (relDist < minDist) minDist = relDist;
//				}
//			}
//			return minDist;
//		}
		
		private function updateRelatedDistanceIncludeRelative(id:String, ns:int, includedItems:Array, dist:int):void {
			var relative:XML = mu.getPersonFamilyData(id, ns);
			if (relative) {
				if (relative.@distance > dist+1) { // && relative.@exclude != 'true') {
					relative.@distance = dist+1;
					updateRelatedDistanceInclude(relative, includedItems);
				}
			}
		}

		private function updateRelatedDistanceInclude(data:XML, includedItems:Array):void {
			var ref:XML;
			var dist:int = data.@distance;
			if (data.@ns == ModelUtils.NS_PERSON) {
				for each (ref in data.child_of_family)
					updateRelatedDistanceIncludeRelative(ref.@id, ModelUtils.NS_FAMILY, includedItems, dist);
				for each (ref in data.spouse_of_family)
					updateRelatedDistanceIncludeRelative(ref.@id, ModelUtils.NS_FAMILY, includedItems, dist);
			}
			else {
				for each (ref in data.husband)
					updateRelatedDistanceIncludeRelative(ref.@id, ModelUtils.NS_PERSON, includedItems, dist);
				for each (ref in data.wife)
					updateRelatedDistanceIncludeRelative(ref.@id, ModelUtils.NS_PERSON, includedItems, dist);
				for each (ref in data.child)
					updateRelatedDistanceIncludeRelative(ref.@id, ModelUtils.NS_PERSON, includedItems, dist);
			}
		}
		
		private function isExcluded(id:String, ns:int):Boolean {
			var data:XML = mu.getPersonFamilyData(id, ns);
			return (data.@exclude == 'true');
		}

      private function countIncludedFamilyMembers(data:XML):int {
         var includedMembers:int = 0;
         var ref:XML;
         for each (ref in data.husband)
            if (!isExcluded(ref.@id, ModelUtils.NS_PERSON)) includedMembers++;
         for each (ref in data.wife)
            if (!isExcluded(ref.@id, ModelUtils.NS_PERSON)) includedMembers++;
         for each (ref in data.child)
            if (!isExcluded(ref.@id, ModelUtils.NS_PERSON)) includedMembers++;
         return includedMembers;
      }
		
		private function testIncludeFamily(id:String, includedItems:Array):void {
			var data:XML = mu.getPersonFamilyData(id, ModelUtils.NS_FAMILY);
			if (data && data.@exclude == 'true') {
				if (countIncludedFamilyMembers(data) > 1) {
					includeItem(data, includedItems);
				}
			}
		}
		
		private function includeRelatedFamilies(data:XML, includedItems:Array):void {
			var ref:XML;
			for each (ref in data.child_of_family) 
				testIncludeFamily(ref.@id, includedItems);
			for each (ref in data.spouse_of_family) 
				testIncludeFamily(ref.@id, includedItems);
		}
		
		public function includeItem(data:XML, includedItems:Array):void {
			data.@exclude = 'false';
			includedItems.push(data);
         if (data.@ns == ModelUtils.NS_PERSON || data.@ns == ModelUtils.NS_FAMILY) {
            // include excluded sources referenced by this page
            for each (var sc:XML in data.source_citation) {
               var sourceId:String = sc.@source_id;
               if (sourceId != null) {
                  var page:XML = model.sourceMap[sourceId];
                  if (page != null && page.@exclude == 'true') {
                     includeItem(page,  includedItems);
                  }
               }
            }
         }
			if ((data.@ns == ModelUtils.NS_PERSON || data.@ns == ModelUtils.NS_FAMILY) &&
			 	 model.people.length <= ModelUtils.MAX_PEOPLE) {
				data.@distance = getMinDistance(data);
				if (data.@distance != ModelUtils.NOT_CONNECTED) {
					updateRelatedDistanceInclude(data, includedItems);
				}
			}
			if (data.@ns == ModelUtils.NS_PERSON) {
				includeRelatedFamilies(data, includedItems);
			}
		}
		
		private function updateRelatedDistanceExcludeRelative(id:String, ns:int):void {
			var relative:XML = mu.getPersonFamilyData(id, ns);
			if (relative && relative.@exclude != 'true') {
				if (relative.@distance < getMinDistance(relative)) {
					//relative.@distance = ModelUtils.NOT_CONNECTED; // assume not connected anymore
					updateRelatedDistanceExclude(relative);
				}
			}
		}
		
		private function updateRelatedDistanceExclude(data:XML):void {
			var ref:XML;
			if (data.@ns == ModelUtils.NS_PERSON) {
				for each (ref in data.child_of_family) 
					updateRelatedDistanceExcludeRelative(ref.@id, ModelUtils.NS_FAMILY);
				for each (ref in data.spouse_of_family) 
					updateRelatedDistanceExcludeRelative(ref.@id, ModelUtils.NS_FAMILY);
			}
			else {
				for each (ref in data.husband) 
					updateRelatedDistanceExcludeRelative(ref.@id, ModelUtils.NS_PERSON);
				for each (ref in data.wife) 
					updateRelatedDistanceExcludeRelative(ref.@id, ModelUtils.NS_PERSON);
				for each (ref in data.child) 
					updateRelatedDistanceExcludeRelative(ref.@id, ModelUtils.NS_PERSON);
			}
		}
		
		private function testExcludeFamily(id:String, excludedItems:Array):void {
			var data:XML = mu.getPersonFamilyData(id, ModelUtils.NS_FAMILY);
			if (data && data.@exclude != 'true') {
				if (countIncludedFamilyMembers(data) <= 1) {
					excludeItem(data, excludedItems);
				}
			}
		}
		
		private function excludeRelatedFamilies(data:XML, excludedItems:Array):void {
			var ref:XML;
			for each (ref in data.child_of_family) 
				testExcludeFamily(ref.@id, excludedItems);
			for each (ref in data.spouse_of_family) 
				testExcludeFamily(ref.@id, excludedItems);
		}
		
//		private function testExclude(id:String, ns:int, excludedItems:Array):void {
//			var data:XML = mu.getPersonFamilyData(id, ns);
//			if (data && data.@exclude != 'true' && data != model.primaryPerson && data.@distance != ModelUtils.NOT_CONNECTED) {
//				var minDist:int = getMinRelativeDistance(data);
//				if (minDist != ModelUtils.NOT_CONNECTED) minDist++;
//				if (minDist == ModelUtils.NOT_CONNECTED) {
//					excludeItem(data, excludedItems);
//				}
//				else if (data.@distance != minDist) {
//					data.@distance = minDist;
//					updateRelatedDistanceExclude(data);
//				}
//			}			
//		}
		
		public function excludeItem(data:XML, excludedItems:Array):void {
			var ref:XML;
			data.@exclude = 'true';
			excludedItems.push(data);
//			if ((data.@ns == ModelUtils.NS_PERSON || data.@ns == ModelUtils.NS_FAMILY) &&
//			 	 model.people.length <= ModelUtils.MAX_PEOPLE) {
//				//data.@distance = ModelUtils.NOT_CONNECTED;
//				updateRelatedDistanceExclude(data);
//			}
         if (data.@ns == ModelUtils.NS_PERSON || data.@ns == ModelUtils.NS_FAMILY) {
            // excluded sources referenced only by this page
            for each (var sc:XML in data.source_citation) {
               var sourceId:String = sc.@source_id;
               if (sourceId != null) {
                  var page:XML = model.sourceMap[sourceId];
                  if (page != null) {
                     var found:Boolean = false;
                     for each (var pf:XML in mu.getReferences(page)) {
                        if (pf.@exclude != 'true') {
                           found = true;
                           break;
                        }
                     }
                     if (!found) {
                        excludeItem(page,  excludedItems);
                     }
                  }
               }
            }
         }
			if (data.@ns == ModelUtils.NS_PERSON) {
				excludeRelatedFamilies(data, excludedItems);
			}
//			if (data.@ns == ModelUtils.NS_PERSON) {
//				for each (ref in data.child_of_family) testExclude(ref.@id, ModelUtils.NS_FAMILY, excludedItems); 
//				for each (ref in data.spouse_of_family) testExclude(ref.@id, ModelUtils.NS_FAMILY, excludedItems); 
//			}
//			else if (data.@ns == ModelUtils.NS_FAMILY) {
//				for each (ref in data.husband) testExclude(ref.@id, ModelUtils.NS_PERSON, excludedItems); 
//				for each (ref in data.wife) testExclude(ref.@id, ModelUtils.NS_PERSON, excludedItems); 
//				for each (ref in data.child) testExclude(ref.@id, ModelUtils.NS_PERSON, excludedItems); 
//			}
		}
		
//		private function getReachableExcludedRef(id:String, ns:int, d:Object):void {
//			var data:XML = mu.getPersonFamilyData(id, ns);
//			if (data) {
//				if (data.@exclude == 'true') {
//					d.excludedRelative = true;
//				}
//				else if (data.@distance < ModelUtils.NOT_CONNECTED) {
//					d.reachableRelative = true;
//				}
//			}
//		}

//		public function isOnExcludeBorder(data:XML):Boolean {
//			var d:Object = {excludedRelative: false, includedRelative: false};
//			var ref:XML;
//			if (data.@ns == ModelUtils.NS_PERSON) {
//				for each (ref in data.child_of_family) getReachableExcludedRef(ref.@id, ModelUtils.NS_FAMILY, d); 
//				for each (ref in data.spouse_of_family) getReachableExcludedRef(ref.@id, ModelUtils.NS_FAMILY, d);
//			}
//			else {
//				for each (ref in data.husband) getReachableExcludedRef(ref.@id, ModelUtils.NS_PERSON, d);
//				for each (ref in data.wife) getReachableExcludedRef(ref.@id, ModelUtils.NS_PERSON, d);
//				for each (ref in data.child) getReachableExcludedRef(ref.@id, ModelUtils.NS_PERSON, d);
//			}
//			return d.reachableRelative;
//		}

		public function updateRootDistances():void {
			log.info("updateRootDistances");
			for each (var person:XML in model.people) {
				person.@distance = ModelUtils.NOT_CONNECTED;
			}
			for each (var family:XML in model.families) {
				family.@distance = ModelUtils.NOT_CONNECTED;	
			}
			if (model.primaryPerson != null && model.people.length <= ModelUtils.MAX_PEOPLE) {
				model.primaryPerson.@distance = 0;
				updateRelatedDistanceInclude(model.primaryPerson, null);
			}
		}
		
//		public function includeSelfAndAncestors(data:XML, includedItems:Array):void {
//			if (data.@exclude == 'true') {
//				data.@exclude = 'false';
//				includedItems.push(data);
//
//				var ref:XML;
//				for each (ref in data.husband) {
//					includeSelfAndAncestors(mu.getPersonFamilyData(ref.@id, ModelUtils.NS_PERSON), includedItems);
//				}
//				for each (ref in data.wife) {
//					includeSelfAndAncestors(mu.getPersonFamilyData(ref.@id, ModelUtils.NS_PERSON), includedItems);
//				}
//				for each (ref in data.child_of_family) {
//					includeSelfAndAncestors(mu.getPersonFamilyData(ref.@id, ModelUtils.NS_FAMILY), includedItems);
//				}
//			}
//		}
	}
}
