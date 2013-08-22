

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.collections.ArrayCollection;
import org.werelate.model.*;

class BindableProperty
    implements flash.events.IEventDispatcher
{
	/**
	 * generated bindable wrapper for property primaryPerson (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'primaryPerson' moved to '_623932425primaryPerson'
	 */

    [Bindable(event="propertyChange")]
    public function get primaryPerson():XML
    {
        return this._623932425primaryPerson;
    }

    public function set primaryPerson(value:XML):void
    {
    	var oldValue:Object = this._623932425primaryPerson;
        if (oldValue !== value)
        {
            this._623932425primaryPerson = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "primaryPerson", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property status (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'status' moved to '_892481550status'
	 */

    [Bindable(event="propertyChange")]
    public function get status():int
    {
        return this._892481550status;
    }

    public function set status(value:int):void
    {
    	var oldValue:Object = this._892481550status;
        if (oldValue !== value)
        {
            this._892481550status = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "status", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property importInstructions (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'importInstructions' moved to '_2100305386importInstructions'
	 */

    [Bindable(event="propertyChange")]
    public function get importInstructions():String
    {
        return this._2100305386importInstructions;
    }

    public function set importInstructions(value:String):void
    {
    	var oldValue:Object = this._2100305386importInstructions;
        if (oldValue !== value)
        {
            this._2100305386importInstructions = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "importInstructions", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property nextSteps (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'nextSteps' moved to '_1206138868nextSteps'
	 */

    [Bindable(event="propertyChange")]
    public function get nextSteps():String
    {
        return this._1206138868nextSteps;
    }

    public function set nextSteps(value:String):void
    {
    	var oldValue:Object = this._1206138868nextSteps;
        if (oldValue !== value)
        {
            this._1206138868nextSteps = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "nextSteps", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isOwner (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isOwner' moved to '_2067570601isOwner'
	 */

    [Bindable(event="propertyChange")]
    public function get isOwner():Boolean
    {
        return this._2067570601isOwner;
    }

    public function set isOwner(value:Boolean):void
    {
    	var oldValue:Object = this._2067570601isOwner;
        if (oldValue !== value)
        {
            this._2067570601isOwner = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isOwner", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isAdmin (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isAdmin' moved to '_2054074437isAdmin'
	 */

    [Bindable(event="propertyChange")]
    public function get isAdmin():Boolean
    {
        return this._2054074437isAdmin;
    }

    public function set isAdmin(value:Boolean):void
    {
    	var oldValue:Object = this._2054074437isAdmin;
        if (oldValue !== value)
        {
            this._2054074437isAdmin = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isAdmin", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isUpdatable (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isUpdatable' moved to '_770894740isUpdatable'
	 */

    [Bindable(event="propertyChange")]
    public function get isUpdatable():Boolean
    {
        return this._770894740isUpdatable;
    }

    public function set isUpdatable(value:Boolean):void
    {
    	var oldValue:Object = this._770894740isUpdatable;
        if (oldValue !== value)
        {
            this._770894740isUpdatable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isUpdatable", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isReturnable (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isReturnable' moved to '_786122924isReturnable'
	 */

    [Bindable(event="propertyChange")]
    public function get isReturnable():Boolean
    {
        return this._786122924isReturnable;
    }

    public function set isReturnable(value:Boolean):void
    {
    	var oldValue:Object = this._786122924isReturnable;
        if (oldValue !== value)
        {
            this._786122924isReturnable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isReturnable", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isHoldable (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isHoldable' moved to '_1308640797isHoldable'
	 */

    [Bindable(event="propertyChange")]
    public function get isHoldable():Boolean
    {
        return this._1308640797isHoldable;
    }

    public function set isHoldable(value:Boolean):void
    {
    	var oldValue:Object = this._1308640797isHoldable;
        if (oldValue !== value)
        {
            this._1308640797isHoldable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isHoldable", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isImportable (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isImportable' moved to '_1944393isImportable'
	 */

    [Bindable(event="propertyChange")]
    public function get isImportable():Boolean
    {
        return this._1944393isImportable;
    }

    public function set isImportable(value:Boolean):void
    {
    	var oldValue:Object = this._1944393isImportable;
        if (oldValue !== value)
        {
            this._1944393isImportable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isImportable", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isMatchable (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isMatchable' moved to '_1792820885isMatchable'
	 */

    [Bindable(event="propertyChange")]
    public function get isMatchable():Boolean
    {
        return this._1792820885isMatchable;
    }

    public function set isMatchable(value:Boolean):void
    {
    	var oldValue:Object = this._1792820885isMatchable;
        if (oldValue !== value)
        {
            this._1792820885isMatchable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isMatchable", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property isMergeable (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'isMergeable' moved to '_1489133688isMergeable'
	 */

    [Bindable(event="propertyChange")]
    public function get isMergeable():Boolean
    {
        return this._1489133688isMergeable;
    }

    public function set isMergeable(value:Boolean):void
    {
    	var oldValue:Object = this._1489133688isMergeable;
        if (oldValue !== value)
        {
            this._1489133688isMergeable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isMergeable", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property peopleToImport (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'peopleToImport' moved to '_2068250031peopleToImport'
	 */

    [Bindable(event="propertyChange")]
    public function get peopleToImport():int
    {
        return this._2068250031peopleToImport;
    }

    public function set peopleToImport(value:int):void
    {
    	var oldValue:Object = this._2068250031peopleToImport;
        if (oldValue !== value)
        {
            this._2068250031peopleToImport = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "peopleToImport", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property peopleMatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'peopleMatched' moved to '_272580715peopleMatched'
	 */

    [Bindable(event="propertyChange")]
    public function get peopleMatched():int
    {
        return this._272580715peopleMatched;
    }

    public function set peopleMatched(value:int):void
    {
    	var oldValue:Object = this._272580715peopleMatched;
        if (oldValue !== value)
        {
            this._272580715peopleMatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "peopleMatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property peopleExcluded (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'peopleExcluded' moved to '_1837069689peopleExcluded'
	 */

    [Bindable(event="propertyChange")]
    public function get peopleExcluded():int
    {
        return this._1837069689peopleExcluded;
    }

    public function set peopleExcluded(value:int):void
    {
    	var oldValue:Object = this._1837069689peopleExcluded;
        if (oldValue !== value)
        {
            this._1837069689peopleExcluded = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "peopleExcluded", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property familiesToImport (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'familiesToImport' moved to '_1067349214familiesToImport'
	 */

    [Bindable(event="propertyChange")]
    public function get familiesToImport():int
    {
        return this._1067349214familiesToImport;
    }

    public function set familiesToImport(value:int):void
    {
    	var oldValue:Object = this._1067349214familiesToImport;
        if (oldValue !== value)
        {
            this._1067349214familiesToImport = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "familiesToImport", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property familiesMatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'familiesMatched' moved to '_650823742familiesMatched'
	 */

    [Bindable(event="propertyChange")]
    public function get familiesMatched():int
    {
        return this._650823742familiesMatched;
    }

    public function set familiesMatched(value:int):void
    {
    	var oldValue:Object = this._650823742familiesMatched;
        if (oldValue !== value)
        {
            this._650823742familiesMatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "familiesMatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property familiesExcluded (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'familiesExcluded' moved to '_1298529556familiesExcluded'
	 */

    [Bindable(event="propertyChange")]
    public function get familiesExcluded():int
    {
        return this._1298529556familiesExcluded;
    }

    public function set familiesExcluded(value:int):void
    {
    	var oldValue:Object = this._1298529556familiesExcluded;
        if (oldValue !== value)
        {
            this._1298529556familiesExcluded = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "familiesExcluded", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningsRead (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningsRead' moved to '_1998647667warningsRead'
	 */

    [Bindable(event="propertyChange")]
    public function get warningsRead():int
    {
        return this._1998647667warningsRead;
    }

    public function set warningsRead(value:int):void
    {
    	var oldValue:Object = this._1998647667warningsRead;
        if (oldValue !== value)
        {
            this._1998647667warningsRead = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningsRead", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningsUnread (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningsUnread' moved to '_755317018warningsUnread'
	 */

    [Bindable(event="propertyChange")]
    public function get warningsUnread():int
    {
        return this._755317018warningsUnread;
    }

    public function set warningsUnread(value:int):void
    {
    	var oldValue:Object = this._755317018warningsUnread;
        if (oldValue !== value)
        {
            this._755317018warningsUnread = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningsUnread", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningCount (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningCount' moved to '_2042096941warningCount'
	 */

    [Bindable(event="propertyChange")]
    public function get warningCount():int
    {
        return this._2042096941warningCount;
    }

    public function set warningCount(value:int):void
    {
    	var oldValue:Object = this._2042096941warningCount;
        if (oldValue !== value)
        {
            this._2042096941warningCount = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningCount", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningLevel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningLevel' moved to '_2034082488warningLevel'
	 */

    [Bindable(event="propertyChange")]
    public function get warningLevel():Number
    {
        return this._2034082488warningLevel;
    }

    public function set warningLevel(value:Number):void
    {
    	var oldValue:Object = this._2034082488warningLevel;
        if (oldValue !== value)
        {
            this._2034082488warningLevel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningLevel", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningComment (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningComment' moved to '_337465123warningComment'
	 */

    [Bindable(event="propertyChange")]
    public function get warningComment():String
    {
        return this._337465123warningComment;
    }

    public function set warningComment(value:String):void
    {
    	var oldValue:Object = this._337465123warningComment;
        if (oldValue !== value)
        {
            this._337465123warningComment = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningComment", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property duplicateCount (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'duplicateCount' moved to '_130972988duplicateCount'
	 */

    [Bindable(event="propertyChange")]
    public function get duplicateCount():int
    {
        return this._130972988duplicateCount;
    }

    public function set duplicateCount(value:int):void
    {
    	var oldValue:Object = this._130972988duplicateCount;
        if (oldValue !== value)
        {
            this._130972988duplicateCount = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "duplicateCount", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property duplicateComment (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'duplicateComment' moved to '_1318418732duplicateComment'
	 */

    [Bindable(event="propertyChange")]
    public function get duplicateComment():String
    {
        return this._1318418732duplicateComment;
    }

    public function set duplicateComment(value:String):void
    {
    	var oldValue:Object = this._1318418732duplicateComment;
        if (oldValue !== value)
        {
            this._1318418732duplicateComment = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "duplicateComment", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sourcesToImport (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourcesToImport' moved to '_732025384sourcesToImport'
	 */

    [Bindable(event="propertyChange")]
    public function get sourcesToImport():int
    {
        return this._732025384sourcesToImport;
    }

    public function set sourcesToImport(value:int):void
    {
    	var oldValue:Object = this._732025384sourcesToImport;
        if (oldValue !== value)
        {
            this._732025384sourcesToImport = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourcesToImport", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sourcesMatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourcesMatched' moved to '_362912180sourcesMatched'
	 */

    [Bindable(event="propertyChange")]
    public function get sourcesMatched():int
    {
        return this._362912180sourcesMatched;
    }

    public function set sourcesMatched(value:int):void
    {
    	var oldValue:Object = this._362912180sourcesMatched;
        if (oldValue !== value)
        {
            this._362912180sourcesMatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourcesMatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sourcesExcluded (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourcesExcluded' moved to '_963205726sourcesExcluded'
	 */

    [Bindable(event="propertyChange")]
    public function get sourcesExcluded():int
    {
        return this._963205726sourcesExcluded;
    }

    public function set sourcesExcluded(value:int):void
    {
    	var oldValue:Object = this._963205726sourcesExcluded;
        if (oldValue !== value)
        {
            this._963205726sourcesExcluded = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourcesExcluded", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sourcesCitationOnly (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourcesCitationOnly' moved to '_1831726859sourcesCitationOnly'
	 */

    [Bindable(event="propertyChange")]
    public function get sourcesCitationOnly():int
    {
        return this._1831726859sourcesCitationOnly;
    }

    public function set sourcesCitationOnly(value:int):void
    {
    	var oldValue:Object = this._1831726859sourcesCitationOnly;
        if (oldValue !== value)
        {
            this._1831726859sourcesCitationOnly = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourcesCitationOnly", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property totalNonExcludedSources (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'totalNonExcludedSources' moved to '_89613925totalNonExcludedSources'
	 */

    [Bindable(event="propertyChange")]
    public function get totalNonExcludedSources():int
    {
        return this._89613925totalNonExcludedSources;
    }

    public function set totalNonExcludedSources(value:int):void
    {
    	var oldValue:Object = this._89613925totalNonExcludedSources;
        if (oldValue !== value)
        {
            this._89613925totalNonExcludedSources = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "totalNonExcludedSources", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property placesMatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'placesMatched' moved to '_970009400placesMatched'
	 */

    [Bindable(event="propertyChange")]
    public function get placesMatched():int
    {
        return this._970009400placesMatched;
    }

    public function set placesMatched(value:int):void
    {
    	var oldValue:Object = this._970009400placesMatched;
        if (oldValue !== value)
        {
            this._970009400placesMatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "placesMatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property placesUnmatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'placesUnmatched' moved to '_2109274495placesUnmatched'
	 */

    [Bindable(event="propertyChange")]
    public function get placesUnmatched():int
    {
        return this._2109274495placesUnmatched;
    }

    public function set placesUnmatched(value:int):void
    {
    	var oldValue:Object = this._2109274495placesUnmatched;
        if (oldValue !== value)
        {
            this._2109274495placesUnmatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "placesUnmatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matchesMatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matchesMatched' moved to '_1739036559matchesMatched'
	 */

    [Bindable(event="propertyChange")]
    public function get matchesMatched():int
    {
        return this._1739036559matchesMatched;
    }

    public function set matchesMatched(value:int):void
    {
    	var oldValue:Object = this._1739036559matchesMatched;
        if (oldValue !== value)
        {
            this._1739036559matchesMatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matchesMatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matchesUnmatched (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matchesUnmatched' moved to '_1466289272matchesUnmatched'
	 */

    [Bindable(event="propertyChange")]
    public function get matchesUnmatched():int
    {
        return this._1466289272matchesUnmatched;
    }

    public function set matchesUnmatched(value:int):void
    {
    	var oldValue:Object = this._1466289272matchesUnmatched;
        if (oldValue !== value)
        {
            this._1466289272matchesUnmatched = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matchesUnmatched", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matchesUndecided (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matchesUndecided' moved to '_2127284912matchesUndecided'
	 */

    [Bindable(event="propertyChange")]
    public function get matchesUndecided():int
    {
        return this._2127284912matchesUndecided;
    }

    public function set matchesUndecided(value:int):void
    {
    	var oldValue:Object = this._2127284912matchesUndecided;
        if (oldValue !== value)
        {
            this._2127284912matchesUndecided = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matchesUndecided", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property updatesMade (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'updatesMade' moved to '_556145409updatesMade'
	 */

    [Bindable(event="propertyChange")]
    public function get updatesMade():int
    {
        return this._556145409updatesMade;
    }

    public function set updatesMade(value:int):void
    {
    	var oldValue:Object = this._556145409updatesMade;
        if (oldValue !== value)
        {
            this._556145409updatesMade = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "updatesMade", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property updatesNotMade (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'updatesNotMade' moved to '_1136549282updatesNotMade'
	 */

    [Bindable(event="propertyChange")]
    public function get updatesNotMade():int
    {
        return this._1136549282updatesNotMade;
    }

    public function set updatesNotMade(value:int):void
    {
    	var oldValue:Object = this._1136549282updatesNotMade;
        if (oldValue !== value)
        {
            this._1136549282updatesNotMade = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "updatesNotMade", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property people (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'people' moved to '_991808881people'
	 */

    [Bindable(event="propertyChange")]
    public function get people():ArrayCollection
    {
        return this._991808881people;
    }

    public function set people(value:ArrayCollection):void
    {
    	var oldValue:Object = this._991808881people;
        if (oldValue !== value)
        {
            this._991808881people = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "people", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property families (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'families' moved to '_787407618families'
	 */

    [Bindable(event="propertyChange")]
    public function get families():ArrayCollection
    {
        return this._787407618families;
    }

    public function set families(value:ArrayCollection):void
    {
    	var oldValue:Object = this._787407618families;
        if (oldValue !== value)
        {
            this._787407618families = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "families", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sources (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sources' moved to '_2021876808sources'
	 */

    [Bindable(event="propertyChange")]
    public function get sources():ArrayCollection
    {
        return this._2021876808sources;
    }

    public function set sources(value:ArrayCollection):void
    {
    	var oldValue:Object = this._2021876808sources;
        if (oldValue !== value)
        {
            this._2021876808sources = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sources", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property places (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'places' moved to '_985774004places'
	 */

    [Bindable(event="propertyChange")]
    public function get places():ArrayCollection
    {
        return this._985774004places;
    }

    public function set places(value:ArrayCollection):void
    {
    	var oldValue:Object = this._985774004places;
        if (oldValue !== value)
        {
            this._985774004places = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "places", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warnings (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warnings' moved to '_498091095warnings'
	 */

    [Bindable(event="propertyChange")]
    public function get warnings():ArrayCollection
    {
        return this._498091095warnings;
    }

    public function set warnings(value:ArrayCollection):void
    {
    	var oldValue:Object = this._498091095warnings;
        if (oldValue !== value)
        {
            this._498091095warnings = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warnings", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matches (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matches' moved to '_840862003matches'
	 */

    [Bindable(event="propertyChange")]
    public function get matches():ArrayCollection
    {
        return this._840862003matches;
    }

    public function set matches(value:ArrayCollection):void
    {
    	var oldValue:Object = this._840862003matches;
        if (oldValue !== value)
        {
            this._840862003matches = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matches", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property updates (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'updates' moved to '_234430262updates'
	 */

    [Bindable(event="propertyChange")]
    public function get updates():ArrayCollection
    {
        return this._234430262updates;
    }

    public function set updates(value:ArrayCollection):void
    {
    	var oldValue:Object = this._234430262updates;
        if (oldValue !== value)
        {
            this._234430262updates = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "updates", oldValue, value));
        }
    }


    //    IEventDispatcher implementation
    //
    private var _bindingEventDispatcher:flash.events.EventDispatcher =
        new flash.events.EventDispatcher(flash.events.IEventDispatcher(this));

    public function addEventListener(type:String, listener:Function,
                                     useCapture:Boolean = false,
                                     priority:int = 0,
                                     weakRef:Boolean = false):void
    {
        _bindingEventDispatcher.addEventListener(type, listener, useCapture,
                                                 priority, weakRef);
    }

    public function dispatchEvent(event:flash.events.Event):Boolean
    {
        return _bindingEventDispatcher.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean
    {
        return _bindingEventDispatcher.hasEventListener(type);
    }

    public function removeEventListener(type:String,
                                        listener:Function,
                                        useCapture:Boolean = false):void
    {
        _bindingEventDispatcher.removeEventListener(type, listener, useCapture);
    }

    public function willTrigger(type:String):Boolean
    {
        return _bindingEventDispatcher.willTrigger(type);
    }

}
