

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import org.werelate.model.Model;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property model (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'model' moved to '_104069929model'
	 */

    [Bindable(event="propertyChange")]
    public function get model():Model
    {
        return this._104069929model;
    }

    public function set model(value:Model):void
    {
    	var oldValue:Object = this._104069929model;
        if (oldValue !== value)
        {
            this._104069929model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "model", oldValue, value));
        }
    }



}
