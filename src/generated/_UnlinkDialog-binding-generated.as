

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.DataGrid;
import mx.controls.Button;
import mx.collections.ArrayCollection;

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
	 * generated bindable wrapper for property membersDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'membersDataGrid' moved to '_1859915337membersDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get membersDataGrid():mx.controls.DataGrid
    {
        return this._1859915337membersDataGrid;
    }

    public function set membersDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._1859915337membersDataGrid;
        if (oldValue !== value)
        {
            this._1859915337membersDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "membersDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property okButton (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'okButton' moved to '_1641788370okButton'
	 */

    [Bindable(event="propertyChange")]
    public function get okButton():mx.controls.Button
    {
        return this._1641788370okButton;
    }

    public function set okButton(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._1641788370okButton;
        if (oldValue !== value)
        {
            this._1641788370okButton = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "okButton", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property selectButton (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'selectButton' moved to '_1555143502selectButton'
	 */

    [Bindable(event="propertyChange")]
    public function get selectButton():mx.controls.Button
    {
        return this._1555143502selectButton;
    }

    public function set selectButton(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._1555143502selectButton;
        if (oldValue !== value)
        {
            this._1555143502selectButton = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "selectButton", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property members (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'members' moved to '_948881689members'
	 */

    [Bindable(event="propertyChange")]
    private function get members():ArrayCollection
    {
        return this._948881689members;
    }

    private function set members(value:ArrayCollection):void
    {
    	var oldValue:Object = this._948881689members;
        if (oldValue !== value)
        {
            this._948881689members = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "members", oldValue, value));
        }
    }



}
