

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.Button;
import mx.collections.ArrayCollection;
import mx.controls.List;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property cancelButton (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'cancelButton' moved to '_1990131276cancelButton'
	 */

    [Bindable(event="propertyChange")]
    public function get cancelButton():mx.controls.Button
    {
        return this._1990131276cancelButton;
    }

    public function set cancelButton(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._1990131276cancelButton;
        if (oldValue !== value)
        {
            this._1990131276cancelButton = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cancelButton", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property referencesDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'referencesDataGrid' moved to '_1424682824referencesDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get referencesDataGrid():mx.controls.List
    {
        return this._1424682824referencesDataGrid;
    }

    public function set referencesDataGrid(value:mx.controls.List):void
    {
    	var oldValue:Object = this._1424682824referencesDataGrid;
        if (oldValue !== value)
        {
            this._1424682824referencesDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "referencesDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property references (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'references' moved to '_1384950408references'
	 */

    [Bindable(event="propertyChange")]
    private function get references():ArrayCollection
    {
        return this._1384950408references;
    }

    private function set references(value:ArrayCollection):void
    {
    	var oldValue:Object = this._1384950408references;
        if (oldValue !== value)
        {
            this._1384950408references = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "references", oldValue, value));
        }
    }



}
