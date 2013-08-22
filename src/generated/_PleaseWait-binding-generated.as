

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import flash.filters.*;
import flash.profiler.*;
import mx.containers.HBox;
import flash.external.*;
import flash.display.*;
import flash.net.*;
import flash.debugger.*;
import mx.controls.Label;
import org.werelate.shared.*;
import flash.utils.*;
import flash.printing.*;
import flash.text.*;
import flash.geom.*;
import flash.events.*;
import flash.accessibility.*;
import mx.binding.*;
import mx.controls.ProgressBar;
import flash.ui.*;
import flash.media.*;
import flash.xml.*;
import mx.styles.*;
import flash.system.*;
import flash.errors.*;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property countBar (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'countBar' moved to '_372054908countBar'
	 */

    [Bindable(event="propertyChange")]
    public function get countBar():mx.containers.HBox
    {
        return this._372054908countBar;
    }

    public function set countBar(value:mx.containers.HBox):void
    {
    	var oldValue:Object = this._372054908countBar;
        if (oldValue !== value)
        {
            this._372054908countBar = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "countBar", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property countLabel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'countLabel' moved to '_1053257947countLabel'
	 */

    [Bindable(event="propertyChange")]
    public function get countLabel():mx.controls.Label
    {
        return this._1053257947countLabel;
    }

    public function set countLabel(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._1053257947countLabel;
        if (oldValue !== value)
        {
            this._1053257947countLabel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "countLabel", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property heading (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'heading' moved to '_795311618heading'
	 */

    [Bindable(event="propertyChange")]
    public function get heading():mx.controls.Label
    {
        return this._795311618heading;
    }

    public function set heading(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._795311618heading;
        if (oldValue !== value)
        {
            this._795311618heading = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "heading", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property message (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'message' moved to '_954925063message'
	 */

    [Bindable(event="propertyChange")]
    public function get message():mx.controls.Label
    {
        return this._954925063message;
    }

    public function set message(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._954925063message;
        if (oldValue !== value)
        {
            this._954925063message = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "message", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property progressBar (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'progressBar' moved to '_1131509414progressBar'
	 */

    [Bindable(event="propertyChange")]
    public function get progressBar():mx.controls.ProgressBar
    {
        return this._1131509414progressBar;
    }

    public function set progressBar(value:mx.controls.ProgressBar):void
    {
    	var oldValue:Object = this._1131509414progressBar;
        if (oldValue !== value)
        {
            this._1131509414progressBar = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "progressBar", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property _count (private)
	 * - generated setter
	 * - generated getter
	 * - original private var '_count' moved to '_1480346608_count'
	 */

    [Bindable(event="propertyChange")]
    private function get _count():int
    {
        return this._1480346608_count;
    }

    private function set _count(value:int):void
    {
    	var oldValue:Object = this._1480346608_count;
        if (oldValue !== value)
        {
            this._1480346608_count = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_count", oldValue, value));
        }
    }



}
