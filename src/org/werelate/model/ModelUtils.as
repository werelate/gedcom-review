package org.werelate.model
{
	import com.gskinner.StringUtils;
	
	import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class ModelUtils
	{
		public static const NS_SOURCE:int = 104;
		public static const NS_PLACE:int = 106;
		public static const NS_PERSON:int = 108;
		public static const NS_FAMILY:int = 110;
		public static const NS_MYSOURCE:int = 112;

		public static const NAMESPACES:Object = {104:'Source',
															  106:'Place',
															  108:'Person',
															  110:'Family',
															  112:'MySource'};		
		// components
		public static const OVERVIEW:int = 1;
		public static const PEOPLE:int = 2;
		public static const FAMILIES:int = 3;
		public static const WARNINGS:int = 4;
		public static const PLACES:int = 5;
		public static const SOURCES:int = 6;
		public static const MATCHES:int = 7;
		public static const UPDATES:int = 8;
		public static const IMPORT:int = 9;
		// keep the help pages in sync with the components
		public static const HELPPAGES:Object = {1:'Help:Review_GEDCOM',
															 2:'Help:Review_GEDCOM#People_Tab',
															 3:'Help:Review_GEDCOM#Families_Tab',
															 4:'Help:Review_GEDCOM#Warnings_Tab',
															 5:'Help:Review_GEDCOM#Places_Tab',
															 6:'Help:Review_GEDCOM#Sources_Tab',
															 7:'Help:Review_GEDCOM#Family_Matches_Tab',
															 8:'Help:Review_GEDCOM#Updates_Tab',
															 9:'Help:Review_GEDCOM#Import_Tab'
															 };
      public static const NOT_MATCHABLE_PAGE:String = 'Help:Review_GEDCOM/Not_Matchable';
		public static const STATUS_DELETE:int = 0;
		public static const STATUS_WAITING:int = 1;
		public static const STATUS_ANALYZING:int = 2;
		public static const STATUS_READY:int = 3;
		public static const STATUS_OPENED:int = 4;
		public static const STATUS_PHASE2:int = 5;
		public static const STATUS_PHASE3:int = 6;
		public static const STATUS_IMPORTING:int = 7;
		public static const STATUS_ADMIN_REVIEW:int = 8;
      public static const STATUS_HOLD:int = 19;
		
		public static const NOT_CONNECTED:int = 9999;
		
		public static const MAX_PEOPLE:int = 5100;
		
		[Autowire(bean="model")]
		public var model : Model;

		private static const log:ILogger = Log.getLogger("org.werelate.model.ModelUtils");
		
		public function getDefaultComponent(ns:int):int {
			if (ns == NS_FAMILY) return FAMILIES;
			if (ns == NS_PERSON) return PEOPLE;
			if (ns == NS_MYSOURCE) return SOURCES;
			if (ns == NS_PLACE) return PLACES;
			return 0;
		}
		
		public function getDataComponent(id:String):Object {		
			var data:XML;
			data = model.personMap[id];
			if (data != null) {
				return {data:data, component:PEOPLE};
			}
			data = model.familyMap[id];
			if (data != null) {
				return {data:data, component:FAMILIES};
			}
			data = model.sourceMap[id];
			if (data != null) {
				return {data:data, component:SOURCES};
			}
			data = model.placeMap[id];
			if (data) {
				return {data:data, component:PLACES};
			}
			return null;
		}
		
		public function cleanName(name:String):String {
			return name.replace(/[?~!@#$%^&*\.()_+=\/<>{}\[\];:\"\\,|]/g, " ").replace(/\s+/g, " ");
		}
		
		public function cleanWikiTitle(title:String):String {
			title = title.replace(/[<\[{]/g, "(")
					  .replace(/[>\]}]/g, ")")
					  .replace(/\|/g, "-")
					  .replace(/_/g, " ")
					  .replace(/#/g, "number ")
					  .replace(/\?/g, " question ")
					  .replace(/\+/g, " plus ")
					  .replace(/%([0-9a-fA-F][0-9a-fA-F])/g, "% $1")
					  .replace(/\s+/g, " ")
					  .replace(/\/\/+/g, "/");
			title = StringUtils.trim(title);
			while (title.length > 0 && (title.charAt(0) == '.' || title.charAt(0) == '/')) {
				title = title.substr(1);
			}					  
			if (title.length > 150) {
				title = title.substr(0, 149);
			}
			return StringUtils.capitalize(title);
		}
		
		public function getPrebarTitle(fullTitle:String):String {
			var pos:int = fullTitle.indexOf("|");
			return (pos > 0 ? fullTitle.substr(0, pos) : fullTitle);
		}
		
		public function getPersonFamilyData(id:String, ns:int):XML {
			return (ns == ModelUtils.NS_PERSON ? model.personMap[id] : model.familyMap[id]);
		}
		
		public function getPrefixedTitle(ns:Number, title:String):String {
			if (title.indexOf(NAMESPACES[ns]+':') != 0) {
				return NAMESPACES[ns]+':'+title;
			}
			return title;
		}
		
		public function getUnprefixedTitle(prefixedTitle:String):String {
			for each (var nsText:String in NAMESPACES) {
				if (prefixedTitle.indexOf(nsText+':') == 0) {
					return prefixedTitle.substr(nsText.length+1);
				}
			}
			return prefixedTitle;
		}
		
		public function getFullName(name:XML):String {
			if (name == null) {
				return "";
			}
			else {
				return name.@surname.toString() + "," + 
					(name.@title_prefix.toString().length > 0 ? " "+name.@title_prefix.toString() : "") +
					(name.@given.toString().length > 0 ? " "+name.@given.toString() : "") +
					(name.@title_suffix.toString().length > 0 ? " "+name.@title_suffix.toString() : "");
			}
		}
		
		public function getPersonFullName(person:XML):String {
			return getFullName(person.name[0]);
		}
		
		public function getPersonTitle(person:XML):String {
			var name:String;
			if (person.@living == 'true') {
				name = "Living";
			}
			else {
				name = StringUtils.trim(person.name[0].@given);
				var pos:int = name.indexOf(' ');
				if (pos  > 0) {
					name = name.substr(0, pos);
				}
			}
			name = cleanName(name+" "+StringUtils.trim(person.name[0].@surname));
         // TODO
			return cleanWikiTitle(StringUtils.capitalize(name.toLowerCase(), true));
		}
		
		public function getFamilyTitle(husband:XML, wife:XML):String {
			var title:String = '';
			title += (husband ? getPersonTitle(husband) : 'Unknown');
			title += " and ";
			title += (wife ? getPersonTitle(wife) : 'Unknown');
			return title;
		}

		public function getFamilyFullName(family:XML):String {
			return getFullName(family.husband[0]) + " and " + 
					 getFullName(family.wife[0]);
		}
		
		public function getPersonFamilyName(data:XML):String {
			if (data.@ns == NS_PERSON) {
				return getPersonFullName(data);
			}
			else {
				return getFamilyFullName(data);
			}
		}
		
		public function getMySourceName(data:XML, userName:String):String {
			var title:String = '';
			if (data.title.toString().length > 0) {
				title = data.title;
			}
			else if (data.abbrev.toString().length > 0) {
				title = data.abbrev;
			}
			else if (data.author.toString().length > 0) {
				if (data.publication_info.toString().length > 0) {
					title = data.author.toString()+" "+data.publication_info.toString();
				}
				else {
					title = data.author;
				}
			}
			else {
				title = "Source";
			}
			if (userName != null) {
				title = userName+"/"+title;				
			}
			return cleanWikiTitle(title);
		}
		
		public function getReferences(data:XML):ArrayCollection {
			var references:ArrayCollection = new ArrayCollection();
			var pf:XML;
			var ef:XML;
			var sc:XML;
			for each (pf in model.people) {
				if (data.@ns == ModelUtils.NS_PLACE) {
					for each (ef in pf.event_fact) {
						if (getPrebarTitle(ef.@place) == data.@text) {
							references.addItem(pf);
							break;
						}
					}
				}
				else if (data.@ns == ModelUtils.NS_MYSOURCE) {
					for each (sc in pf.source_citation) {
						if (sc.@source_id == data.@id) {
							references.addItem(pf);
							break;
						}
					}
				}
			}
			for each (pf in model.families) {
				if (data.@ns == ModelUtils.NS_PLACE) {
					for each (ef in pf.event_fact) {
						if (getPrebarTitle(ef.@place) == data.@text) {
							references.addItem(pf);
							break;
						}
					}
				}
				else if (data.@ns == ModelUtils.NS_MYSOURCE) {
					for each (sc in pf.source_citation) {
						if (sc.@source_id == data.@id) {
							references.addItem(pf);
							break;
						}
					}
				}
			}
			return references;
		}
		
		public function getMySourceCitationIds(data:XML):ArrayCollection {
			var ids:ArrayCollection = new ArrayCollection();
			for each (var sc:XML in data.source_citation) {
				var id:String = sc.@source_id;
				if (!ids.contains(id)) ids.addItem(id);
			}
			return ids;
		}
		
		private function compareNames(name1:String, name2:String, threshold:int):int {
			var score:int = 0;
			name1 = StringUtils.trim(name1);
			name2 = StringUtils.trim(name2);
			if (name1.length > 0 && name2.length > 0) {
				var namePieces1:Array = name1.split(/[ ,\-']+/); 
				var namePieces2:Array = name2.split(/[ ,\-']+/);
				for each (var namePiece1:String in namePieces1) {
					namePiece1 = namePiece1.toLowerCase();
					for each (var namePiece2:String in namePieces2) {
						namePiece2 = namePiece2.toLowerCase();
						if (namePiece1 == namePiece2) score+=2;
						else if (StringUtils.similarity(namePiece1, namePiece2) >= threshold) score+=1;
					}
				}
			}
			return score;
		}
		
		private function compareFamily(matchingTitle:String, family:XML, data:XML, isSpouse:Boolean, threshold:int):int {
			var score:int = 0;
			var pattern:RegExp = /(.*)\s+and\s+(.*)\s+\(\d+\)/i;
			var result:Object = pattern.exec(matchingTitle);
			if (result != null) {
				var matchingHusbandName:String = result[1];
				var husband:XML = (family.husband[0] ? model.personMap[family.husband[0].@id] : null);
				var husbandName:String = (husband ? getFullName(husband.name[0]) : '');
				if (!isSpouse || data.gender == 'F') {
					score += compareNames(matchingHusbandName, husbandName, threshold);
				}
				 
				var matchingWifeName:String = result[2];
				var wife:XML = (family.wife[0] ? model.personMap[family.wife[0].@id] : null);
				var wifeName:String = (wife ? getFullName(wife.name[0]) : '');
				if (!isSpouse || data.gender == 'M') {
					score += compareNames(matchingWifeName, wifeName, threshold);
				}
			} 
			return score;
		}
		
		private function compareFamilies(matchTitles:Array, families:Array, data:XML, isSpouse:Boolean, threshold:int, 
													matchedFamilies:Array, matchedTitles:Array):void {
			var matched:Array = new Array();															
			for (var i:int = 0; i < families.length; i++) {
				var bestScore:int = 0;
				var bestTitle:int = -1;
				for (var j:int = 0; j < matchTitles.length; j++) {
					if (!matched[j]) {
						var score:int = compareFamily(matchTitles[j], families[i], data, isSpouse, threshold);
						if (score > bestScore) {
							bestScore = score;
							bestTitle = j;
						}
						else if (score > 0 && score == bestScore) { // don't match either if >1 title with same score
							bestTitle = -1;
						}
					}
				}
				if (bestTitle >= 0) {
					matchedFamilies.push(families[i]);
					matchedTitles.push(matchTitles[bestTitle]);
					matched[j] = true;
				}
			}
		}
		
		public function matchRelatedFamilies(person:XML, match:XML, threshold:int, 
															matchedFamilies:Array, matchedTitles:Array):void {
			var families:Array;
			var matchTitles:Array;
			var family:XML;
			var matchingFamily:XML;
			var ref:XML;
			
			// compare parents
			families = new Array();
			matchTitles = new Array();
			for each (ref in person.child_of_family) {
				family = model.familyMap[ref.@id];
				if (family) families.push(family);
			}
			for each (matchingFamily in match.child_of_family) {
				matchTitles.push(matchingFamily.@title.toString());
			}
			compareFamilies(matchTitles, families, person, false, threshold, matchedFamilies, matchedTitles);
			
			// compare spouses
			families = new Array();
			matchTitles = new Array();
			for each (ref in person.spouse_of_family) {
				family = model.familyMap[ref.@id];
				if (family) families.push(family);
			}
			for each (matchingFamily in match.spouse_of_family) {
				matchTitles.push(matchingFamily.@title.toString());
			}
			compareFamilies(matchTitles, families, person, true, threshold, matchedFamilies, matchedTitles);
		}

		private function getGedcomPersonTitle(person:XML):String {
			var title:String = getPersonTitle(person);
			if (person.@exclude == 'true') {
				title += " - Excluded";
			}
			title += " ("+person.@id+" gedcom)";
			return title;
		}
		
		private function getGedcomFamilyTitle(family:XML):String {
			var husband:XML = (family.husband[0] ? model.personMap[family.husband[0].@id] : null);
			var wife:XML = (family.wife[0] ? model.personMap[family.wife[0].@id] : null);
			var title:String = getFamilyTitle(husband, wife);
			if (family.@exclude == 'true') {
				title += " - Excluded";
			}
			title += " ("+family.@id+" gedcom)";
			return title;
		}
		
		private function getGedcomSourceTitle(source:XML, findAdd:Boolean=false):String {
			if (findAdd && source.@match.toString().length > 0) {
				return "Source:"+source.@match;
			}
			else {
				var title:String = "MySource:"+getMySourceName(source, model.userName);
				if (!findAdd) {
					if (source.@exclude == 'true') {
						title += " - Excluded";
					}
					title += " ("+source.@id+" gedcom)";
				}
				return title;
			}			
		}
		
		public function getGedcomPageTitle(data:XML):String {
			if (data.@ns == NS_PERSON) {
				return getGedcomPersonTitle(data);
			}
			else if (data.@ns == NS_FAMILY) {
				return getGedcomFamilyTitle(data);
			}
			else if (data.@ns == NS_MYSOURCE) {
				return getGedcomSourceTitle(data);
			}
			return '';
		}
		
		public function getGedcomKey(pageTitle:String):String {
			if (pageTitle != null) {
				var start:int = pageTitle.lastIndexOf('(');
				var end:int = pageTitle.lastIndexOf(' gedcom)');
				if (start >= 0 && end > start) return pageTitle.substr(start+1, end-start-1);
			}
			return null; 
		}

		private function standardizePlace(placeText:String):String {
			var place:XML = model.placeTextMap[placeText];
			if (place) {
				var std:String = place.@match.toString();
				if (place.@nomatch == 'true') {
					return placeText;
				}
				else if (std.length == 0) {
					return place.@bestMatch.toString()+'|'+placeText;
				}
				else {
					return std+'|'+placeText;
				}
			}
			else {
				return placeText;
			}		
		}

		private function updatePersonRef(ref:XML, findAdd:Boolean):void {
			var person:XML = model.personMap[ref.@id];
			if (person) {
				ref.@title = getGedcomPersonTitle(person);
				if (findAdd && person.@match.toString().length > 0) { // pass up match title separately
					ref.@match = person.@match.toString();
				}
				if (person.@exclude == 'true') {
					ref.@title_suffix += ' - Excluded';  
					if (findAdd) ref.@exclude = 'true';
				}
				if (person.@living == 'true') {
					ref.@given = 'Living';
					ref.@title_prefix = '';
					ref.@title_suffix = '';
					ref.@birthdate = '';
					ref.@birthplace = '';
					ref.@chrdate = '';
					ref.@chrplace = '';
					ref.@deathdate = '';
					ref.@deathplace = '';
					ref.@burialdate = '';
					ref.@burialplace = '';
				}
			}
			if (ref.@birthplace.toString().length > 0) ref.@birthplace = standardizePlace(ref.@birthplace);
			if (ref.@chrplace.toString().length > 0) ref.@chrplace = standardizePlace(ref.@chrplace);
			if (ref.@deathplace.toString().length > 0) ref.@deathplace = standardizePlace(ref.@deathplace);
			if (ref.@burialplace.toString().length > 0) ref.@burialplace = standardizePlace(ref.@burialplace);
			if (ref.@child_of_family.toString().length > 0) {
				var family:XML = model.familyMap[ref.@child_of_family];
				if (family) ref.@child_of_family = getGedcomFamilyTitle(family);
			}
		}
		
		private function updateFamilyRef(ref:XML, findAdd:Boolean):void {
			var family:XML = model.familyMap[ref.@id];
			if (family) {
				ref.@title = getGedcomFamilyTitle(family); 
				if (findAdd && family.@match.toString().length > 0) { // pass up match title separately
					ref.@match = family.@match.toString();
				}
				if (family.@exclude == 'true') {
					if (findAdd) ref.@exclude = 'true';
				}
			}
		}
		
		private function updateEventFact(ef:XML):void {
			if (ef.@place.toString().length > 0) ef.@place = standardizePlace(ef.@place);
		}
		
		private function updateSourceCitation(citation:XML, findAdd:Boolean):void {
			var source:XML = model.sourceMap[citation.@source_id];
			if (source) {
				citation.@title = getGedcomSourceTitle(source, findAdd);
				if (source.@exclude == 'true') {
					if (findAdd) citation.@exclude = 'true';
				} 
			}
		}
		
		private function deleteExcluded(list:XMLList):void {
			for (var i:int = list.length()-1; i>=0; i--) {
				if (list[i].@exclude == 'true') {
					log.info("deleting={0}", i);
					delete list[i];
				}
			}
		}
		
		public function preparePageData(data:XML, findAdd:Boolean=false):XML {
			// convert titles (excluded, matched); handle living
			// IMPORTANT: in order to handle editing the page properly, loading a single page MUST use
			// the GEDCOM title including the GEDCOM key for ref.@title attrs
			var clone:XML;
			var node:XML;
//			if (data.@living != 'true') {
				clone = data.copy();
//			}
//			else {
//				if (data.@ns == NS_PERSON) {
//					clone = <person><name given="Living"/></person>;
//					if (data.name.length() > 0) clone.name[0].@surname = data.name[0].@surname.toString();
//					if (data.gender.length() > 0) clone.appendChild(data.gender[0].copy());
//					for each (node in data.child_of_family) clone.appendChild(node.copy());
//					for each (node in data.spouse_of_family) clone.appendChild(node.copy());
//				}
//				else { // living family
//					clone = <family/>;
//					for each (node in data.husband) clone.appendChild(node.copy());
//					for each (node in data.wife) clone.appendChild(node.copy());
//					for each (node in data.child) clone.appendChild(node.copy());
//				}
//				clone.@id = data.@id.toString();
//				clone.@ns = data.@ns.toString();
//			}
			
			// set the page title
			clone.@title = getPrefixedTitle(data.@ns, getGedcomPageTitle(data));
			clone.@merged = data.@merged.toString();
			
			// update pf titles (living, excluded), place titles, source titles
			for each (node in clone.child_of_family) updateFamilyRef(node, findAdd);
			for each (node in clone.spouse_of_family) updateFamilyRef(node, findAdd);
			for each (node in clone.husband) updatePersonRef(node, findAdd);
			for each (node in clone.wife) updatePersonRef(node, findAdd);
			for each (node in clone.child) updatePersonRef(node, findAdd);
			for each (node in clone.event_fact) updateEventFact(node);
			for each (node in clone.source_citation) updateSourceCitation(node, findAdd);
			
			if (findAdd) {
				deleteExcluded(clone.child_of_family);
				deleteExcluded(clone.spouse_of_family);
				deleteExcluded(clone.husband);
				deleteExcluded(clone.wife);
				deleteExcluded(clone.child);
				deleteExcluded(clone.source_citation);
			}
			return clone;
		}
		
		private function addFamily(familyId:String, selfId:String, result:XML):void {
			var ref:XML;
			var member:XML;
			var family:XML = model.familyMap[familyId];
			if (family) {
				result.appendChild(preparePageData(family, true));
				for each (ref in family.husband) {
					member = model.personMap[ref.@id];
					if (member && member.@id != selfId) result.appendChild(preparePageData(member, true));
				}
				for each (ref in family.wife) {
					member = model.personMap[ref.@id];
					if (member && member.@id != selfId) result.appendChild(preparePageData(member, true));
				}
			}
		}
		
		public function prepareFindAddData(data:XML):XML {
			var node:XML;
			var result:XML = <gedcom/>;
			result.@gedcomId = model.gedcomId;
			var clone:XML = preparePageData(data, true);
			result.appendChild(clone);
			if (clone.@ns == NS_PERSON) {
				for each (node in clone.child_of_family) {
					addFamily(node.@id, clone.@id, result);
				}
				for each (node in clone.spouse_of_family) {
					addFamily(node.@id, clone.@id, result);
				}
			}
			else if (clone.@ns == NS_FAMILY) {
				var member:XML;
				for each (node in clone.husband) {
					member = model.personMap[node.@id];
					if (member) result.appendChild(preparePageData(member, true));
				}
				for each (node in clone.wife) {
					member = model.personMap[node.@id];
					if (member) result.appendChild(preparePageData(member, true));
				}
				for each (node in clone.child) {
					member = model.personMap[node.@id];
					if (member) result.appendChild(preparePageData(member, true));
				}
			}
			return result;
		}

      public function getWarningPersonFamily(warn:XML):XML {
         return (warn.@ns == ModelUtils.NS_PERSON ? warn.person[0] : warn.family[0]);
      }

      public function getWarningLevelDesc(warn:XML):String {
         var level:String = "";
         if (warn.@warningLevel == 0) {
            level="alert";
         }
         else if (warn.@warningLevel == 1) {
            level="warning";
         }
         else if (warn.@warningLevel == 2) {
            level="error";
         }
         else if (warn.@warningLevel == 3) {
            level="duplicate";
         }
         return level;
      }
	}
}