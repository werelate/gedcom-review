

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
import flash.utils.*;
import flash.printing.*;
import flash.text.*;
import flash.geom.*;
import flash.events.*;
import flash.accessibility.*;
import org.werelate.*;
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
	 * generated bindable wrapper for property server (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'server' moved to '_905826493server'
	 */

    [Bindable(event="propertyChange")]
    public function get server():String
    {
        return this._905826493server;
    }

    public function set server(value:String):void
    {
    	var oldValue:Object = this._905826493server;
        if (oldValue !== value)
        {
            this._905826493server = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "server", oldValue, value));
        }
    }



}
