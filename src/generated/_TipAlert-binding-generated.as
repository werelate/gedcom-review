

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
import flash.net.*;
import flash.debugger.*;
import mx.controls.Text;
import flash.utils.*;
import flash.printing.*;
import flash.text.*;
import flash.geom.*;
import flash.events.*;
import org.werelate.comps.*;
import mx.controls.CheckBox;
import flash.accessibility.*;
import mx.binding.*;
import mx.controls.Button;
import flash.ui.*;
import flash.media.*;
import flash.xml.*;
import mx.styles.*;
import flash.system.*;
import flash.errors.*;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property noShow (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'noShow' moved to '_1040673698noShow'
	 */

    [Bindable(event="propertyChange")]
    public function get noShow():mx.controls.CheckBox
    {
        return this._1040673698noShow;
    }

    public function set noShow(value:mx.controls.CheckBox):void
    {
    	var oldValue:Object = this._1040673698noShow;
        if (oldValue !== value)
        {
            this._1040673698noShow = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "noShow", oldValue, value));
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
	 * generated bindable wrapper for property tipMsg (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'tipMsg' moved to '_873601818tipMsg'
	 */

    [Bindable(event="propertyChange")]
    public function get tipMsg():mx.controls.Text
    {
        return this._873601818tipMsg;
    }

    public function set tipMsg(value:mx.controls.Text):void
    {
    	var oldValue:Object = this._873601818tipMsg;
        if (oldValue !== value)
        {
            this._873601818tipMsg = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tipMsg", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property tipMessage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'tipMessage' moved to '_1879047444tipMessage'
	 */

    [Bindable(event="propertyChange")]
    private function get tipMessage():String
    {
        return this._1879047444tipMessage;
    }

    private function set tipMessage(value:String):void
    {
    	var oldValue:Object = this._1879047444tipMessage;
        if (oldValue !== value)
        {
            this._1879047444tipMessage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tipMessage", oldValue, value));
        }
    }



}
