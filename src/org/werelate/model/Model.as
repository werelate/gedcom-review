package org.werelate.model
{
import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
import mx.controls.Alert;
import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class Model
	{
		private static const log:ILogger = Log.getLogger("org.werelate.model.Model");
		
		public var gedcomId:int;
		public var userName:String;
		
		[Bindable]
		public var primaryPerson:XML;
		
		[Bindable]
		public var status:int;
		[Bindable]
		public var importInstructions:String;
		[Bindable]
		public var nextSteps:String;
		[Bindable]
		public var isOwner:Boolean;
		[Bindable]
		public var isAdmin:Boolean;
		[Bindable]
		public var isUpdatable:Boolean;
      [Bindable]
      public var isReturnable:Boolean;
      [Bindable]
      public var isHoldable:Boolean;
      [Bindable]
      public var isImportable:Boolean;
      [Bindable]
      public var isMatchable:Boolean;
      [Bindable]
      public var isMergeable:Boolean; // pages in this gedcom can be merged with existing wiki pages; also, uploader can edit pages

		[Bindable]
		public var peopleToImport:int;
		[Bindable]
		public var peopleMatched:int;
		[Bindable]
		public var peopleExcluded:int;
		
		[Bindable]
		public var familiesToImport:int;
		[Bindable]
		public var familiesMatched:int;
		[Bindable]
		public var familiesExcluded:int;
		
      [Bindable]
      public var warningsRead:int;
      [Bindable]
      public var warningsUnread:int;
      [Bindable]
      public var warningCount:int;
      [Bindable]
      public var warningLevel:Number;
      [Bindable]
      public var warningComment:String;
      [Bindable]
      public var duplicateCount:int;
      [Bindable]
      public var duplicateComment:String;

		[Bindable]
		public var sourcesToImport:int;
		[Bindable]
		public var sourcesMatched:int;
      [Bindable]
      public var sourcesExcluded:int;
      [Bindable]
      public var sourcesCitationOnly:int;
      [Bindable]
      public var totalNonExcludedSources:int;

		[Bindable]
		public var placesMatched:int;
		[Bindable]
		public var placesUnmatched:int;
		
		[Bindable]
		public var matchesMatched:int;
		[Bindable]
		public var matchesUnmatched:int;
		[Bindable]
		public var matchesUndecided:int;
		
		[Bindable]
		public var updatesMade:int;
		[Bindable]
		public var updatesNotMade:int;
		
		[Bindable]
		public var people:ArrayCollection;
		
		[Bindable]
		public var families:ArrayCollection;

		[Bindable]
		public var sources:ArrayCollection;

		[Bindable]
		public var places:ArrayCollection;
		
		[Bindable]
		public var warnings:ArrayCollection;
		
		[Bindable]
		public var matches:ArrayCollection;
		
		[Bindable]
		public var updates:ArrayCollection;
		
		public var personMap:Object;
		public var familyMap:Object;
		public var sourceMap:Object;
		public var placeMap:Object;  // id
		public var placeTextMap:Object; // text
		
		public function Model() {
			gedcomId = 0;
			userName = '';
			status = 0;
			importInstructions = nextSteps = '';
			isOwner = false;
			isAdmin = false;
			isUpdatable = false;
			isReturnable = false;
         isHoldable = false;
			isImportable = false;
         isMatchable = false;
         isMergeable = false;
			primaryPerson = null;
			peopleToImport = peopleExcluded = peopleMatched = 0;
			familiesToImport = familiesExcluded = familiesMatched = 0;
			warningsRead = warningsUnread = 0;
         warningLevel = 0.0;
         warningComment = '';
         duplicateCount = 0;
         duplicateComment = '';
			sourcesToImport = sourcesMatched = sourcesExcluded = sourcesCitationOnly = totalNonExcludedSources = 0;
			placesMatched = placesUnmatched = 0;
			matchesMatched = matchesUnmatched = matchesUndecided = 0;
			updatesMade = updatesNotMade = 0;
			
			personMap = new Object();
			familyMap = new Object();
			sourceMap = new Object();
			placeMap = new Object();
			placeTextMap = new Object();
			
			people = new ArrayCollection();
			people.sort = new Sort();
			people.sort.fields = [new SortField("@stdName"), new SortField("@id")];
			people.refresh();
			
			families = new ArrayCollection();
			families.sort = new Sort();
			families.sort.fields = [new SortField("@stdHusbandName"), new SortField("@stdName"), new SortField("@id")];
			families.refresh();
			
			sources = new ArrayCollection();
			sources.sort = new Sort();
			sources.sort.fields = [new SortField("@stdName", true), new SortField("@id")];
			sources.refresh();
			
			places = new ArrayCollection();
			places.sort = new Sort();
			places.sort.fields = [new SortField("@stdName", true), new SortField("@id")];
			places.refresh();
			
			log.info("Init warnings and matches");
			warnings = new ArrayCollection();
			warnings.sort = new Sort();
			warnings.sort.fields = [new SortField("@stdName", true), new SortField("@id")];
			warnings.refresh();
			
			matches = new ArrayCollection();
			matches.sort = new Sort();
			matches.sort.fields = [new SortField("@distance", true), new SortField("@stdName", true), new SortField("@id")];
			matches.refresh();

			updates = new ArrayCollection();
			updates.sort = new Sort();
			updates.sort.fields = [new SortField("@stdName", true), new SortField("@id")];
			updates.refresh();
		}
		
		public function addPerson(person:XML):void {
			people.addItem(person);
			personMap[person.@id] = person;
		}
		
		public function addFamily(family:XML):void {
			families.addItem(family);
			familyMap[family.@id] = family;
		}
		
		public function addSource(source:XML):void {
			sources.addItem(source);
			sourceMap[source.@id] = source;
		}
		
		public function addPlace(place:XML):void {
			places.addItem(place);
			placeMap[place.@id] = place;
			placeTextMap[place.@text] = place;
		}
		
		private function getItemIndex(a:ArrayCollection, data:XML):int {
			var id:String = data.@id;
			for (var i:int = 0; i < a.length; i++) {
				if ((a.getItemAt(i) as XML).@id == id) return i;
			}
			return -1;
		}
		
		private function addUpdate(a:ArrayCollection, data:XML):void {
			if (getItemIndex(a, data) >= 0) {
				a.itemUpdated(data);
			}
			else {
				a.addItem(data);
				if (a.length != a.source.length) a.refresh(); // flex bug
			}
		}
		
		private function remove(a:ArrayCollection, data:XML):void {
			var pos:int = getItemIndex(a, data);
			if (pos >= 0) {
				a.removeItemAt(pos);
				if (a.length != a.source.length) a.refresh();
			}			
		}
		
		public function addUpdateWarnings(pf:XML, readWarnings:Object=null):void {
         // loop through all warnings
         var warns:Array = pf.@warning.split('|');
         for (var i:int = 0; i < warns.length; i++) {
            var warn:String = warns[i];
            var x:XML = new XML('<warning/>');
            x.@id = pf.@id + '|' + i;
            var level:Number = parseInt(warn.substr(0,1));
            if (isNaN(level)) {
               x.@warningLevel = 1;
               x.@warning = warn;
            }
            else {
               x.@warningLevel = level;
               x.@warning = warn.substr(1);
            }
            x.@stdName = pf.@stdName.toString();
            x.@ns = pf.@ns.toString();
            x.appendChild(pf);
            if (readWarnings != null) {
               x.@warningRead = (readWarnings[x.@id] ? 'true' : '');
            }
            addUpdate(warnings, x);
         }
		}
		
		public function removeWarnings(pf:XML):void {
         var prefix:String = pf.@id+'|';
         for (var i:int = warnings.length - 1; i >= 0; i--) {
            if (warnings[i].@id.indexOf(prefix) == 0) {
               remove(warnings, warnings[i]);
            }
         }
		}
		
		public function addUpdateMatch(match:XML):void {
			addUpdate(matches, match);
		}

		public function removeMatch(match:XML):void {
			remove(matches, match);
		}
		
		public function addUpdateUpdate(update:XML):void {
			addUpdate(updates, update);
		}
		
		public function removeUpdate(update:XML):void {
			remove(updates, update);
		}
	}
}