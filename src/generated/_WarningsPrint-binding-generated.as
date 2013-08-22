

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import flash.filters.*;
import flash.profiler.*;
import flash.external.*;
import flash.display.*;
import mx.printing.PrintDataGrid;
import flash.net.*;
import flash.debugger.*;
import org.werelate.model.ModelUtils;
import flash.utils.*;
import flash.printing.*;
import flash.text.*;
import flash.geom.*;
import flash.events.*;
import org.werelate.comps.*;
import flash.accessibility.*;
import mx.core.*;
import mx.binding.*;
import flash.ui.*;
import flash.media.*;
import flash.xml.*;
import mx.styles.*;
import flash.system.*;
import flash.errors.*;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property myDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'myDataGrid' moved to '_2045440036myDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get myDataGrid():mx.printing.PrintDataGrid
    {
        return this._2045440036myDataGrid;
    }

    public function set myDataGrid(value:mx.printing.PrintDataGrid):void
    {
    	var oldValue:Object = this._2045440036myDataGrid;
        if (oldValue !== value)
        {
            this._2045440036myDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "myDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property mu (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'mu' moved to '_3496mu'
	 */

    [Bindable(event="propertyChange")]
    public function get mu():ModelUtils
    {
        return this._3496mu;
    }

    public function set mu(value:ModelUtils):void
    {
    	var oldValue:Object = this._3496mu;
        if (oldValue !== value)
        {
            this._3496mu = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mu", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property pageNumber (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'pageNumber' moved to '_1144767160pageNumber'
	 */

    [Bindable(event="propertyChange")]
    public function get pageNumber():Number
    {
        return this._1144767160pageNumber;
    }

    public function set pageNumber(value:Number):void
    {
    	var oldValue:Object = this._1144767160pageNumber;
        if (oldValue !== value)
        {
            this._1144767160pageNumber = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pageNumber", oldValue, value));
        }
    }



}
