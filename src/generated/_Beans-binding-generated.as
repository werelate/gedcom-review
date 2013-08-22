

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import org.werelate.controllers.TipAlertController;
import org.werelate.controllers.IncludeExclude;
import org.werelate.controllers.MatchAllController;
import org.werelate.services.WeRelateService;
import org.werelate.controllers.ModelLoader;
import org.werelate.controllers.MainController;
import org.werelate.services.SharedObjectService;
import org.werelate.controllers.WLHController;
import org.werelate.model.ModelUtils;
import org.werelate.controllers.UnlinkController;
import org.werelate.model.Model;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property includeExclude (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'includeExclude' moved to '_1961946094includeExclude'
	 */

    [Bindable(event="propertyChange")]
    public function get includeExclude():org.werelate.controllers.IncludeExclude
    {
        return this._1961946094includeExclude;
    }

    public function set includeExclude(value:org.werelate.controllers.IncludeExclude):void
    {
    	var oldValue:Object = this._1961946094includeExclude;
        if (oldValue !== value)
        {
            this._1961946094includeExclude = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "includeExclude", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property mainController (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'mainController' moved to '_1241920053mainController'
	 */

    [Bindable(event="propertyChange")]
    public function get mainController():org.werelate.controllers.MainController
    {
        return this._1241920053mainController;
    }

    public function set mainController(value:org.werelate.controllers.MainController):void
    {
    	var oldValue:Object = this._1241920053mainController;
        if (oldValue !== value)
        {
            this._1241920053mainController = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mainController", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matchAllController (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matchAllController' moved to '_906560088matchAllController'
	 */

    [Bindable(event="propertyChange")]
    public function get matchAllController():org.werelate.controllers.MatchAllController
    {
        return this._906560088matchAllController;
    }

    public function set matchAllController(value:org.werelate.controllers.MatchAllController):void
    {
    	var oldValue:Object = this._906560088matchAllController;
        if (oldValue !== value)
        {
            this._906560088matchAllController = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matchAllController", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property model (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'model' moved to '_104069929model'
	 */

    [Bindable(event="propertyChange")]
    public function get model():org.werelate.model.Model
    {
        return this._104069929model;
    }

    public function set model(value:org.werelate.model.Model):void
    {
    	var oldValue:Object = this._104069929model;
        if (oldValue !== value)
        {
            this._104069929model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "model", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property modelLoader (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'modelLoader' moved to '_283464860modelLoader'
	 */

    [Bindable(event="propertyChange")]
    public function get modelLoader():org.werelate.controllers.ModelLoader
    {
        return this._283464860modelLoader;
    }

    public function set modelLoader(value:org.werelate.controllers.ModelLoader):void
    {
    	var oldValue:Object = this._283464860modelLoader;
        if (oldValue !== value)
        {
            this._283464860modelLoader = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "modelLoader", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property modelUtils (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'modelUtils' moved to '_2095822600modelUtils'
	 */

    [Bindable(event="propertyChange")]
    public function get modelUtils():org.werelate.model.ModelUtils
    {
        return this._2095822600modelUtils;
    }

    public function set modelUtils(value:org.werelate.model.ModelUtils):void
    {
    	var oldValue:Object = this._2095822600modelUtils;
        if (oldValue !== value)
        {
            this._2095822600modelUtils = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "modelUtils", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sharedObjectService (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sharedObjectService' moved to '_966068719sharedObjectService'
	 */

    [Bindable(event="propertyChange")]
    public function get sharedObjectService():org.werelate.services.SharedObjectService
    {
        return this._966068719sharedObjectService;
    }

    public function set sharedObjectService(value:org.werelate.services.SharedObjectService):void
    {
    	var oldValue:Object = this._966068719sharedObjectService;
        if (oldValue !== value)
        {
            this._966068719sharedObjectService = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sharedObjectService", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property tipAlertController (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'tipAlertController' moved to '_1927474179tipAlertController'
	 */

    [Bindable(event="propertyChange")]
    public function get tipAlertController():org.werelate.controllers.TipAlertController
    {
        return this._1927474179tipAlertController;
    }

    public function set tipAlertController(value:org.werelate.controllers.TipAlertController):void
    {
    	var oldValue:Object = this._1927474179tipAlertController;
        if (oldValue !== value)
        {
            this._1927474179tipAlertController = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tipAlertController", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property unlinkController (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'unlinkController' moved to '_134427121unlinkController'
	 */

    [Bindable(event="propertyChange")]
    public function get unlinkController():org.werelate.controllers.UnlinkController
    {
        return this._134427121unlinkController;
    }

    public function set unlinkController(value:org.werelate.controllers.UnlinkController):void
    {
    	var oldValue:Object = this._134427121unlinkController;
        if (oldValue !== value)
        {
            this._134427121unlinkController = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "unlinkController", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property werelateService (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'werelateService' moved to '_2053981938werelateService'
	 */

    [Bindable(event="propertyChange")]
    public function get werelateService():org.werelate.services.WeRelateService
    {
        return this._2053981938werelateService;
    }

    public function set werelateService(value:org.werelate.services.WeRelateService):void
    {
    	var oldValue:Object = this._2053981938werelateService;
        if (oldValue !== value)
        {
            this._2053981938werelateService = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "werelateService", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property wlhController (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'wlhController' moved to '_932358191wlhController'
	 */

    [Bindable(event="propertyChange")]
    public function get wlhController():org.werelate.controllers.WLHController
    {
        return this._932358191wlhController;
    }

    public function set wlhController(value:org.werelate.controllers.WLHController):void
    {
    	var oldValue:Object = this._932358191wlhController;
        if (oldValue !== value)
        {
            this._932358191wlhController = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "wlhController", oldValue, value));
        }
    }



}
