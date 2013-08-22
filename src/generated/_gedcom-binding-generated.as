

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.containers.Canvas;
import mx.controls.DataGrid;
import mx.controls.TabBar;
import mx.collections.ArrayCollection;
import org.werelate.model.ModelUtils;
import org.werelate.model.Model;
import mx.formatters.NumberFormatter;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property containers (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'containers' moved to '_145245202containers'
	 */

    [Bindable(event="propertyChange")]
    public function get containers():mx.containers.Canvas
    {
        return this._145245202containers;
    }

    public function set containers(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._145245202containers;
        if (oldValue !== value)
        {
            this._145245202containers = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "containers", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property familiesDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'familiesDataGrid' moved to '_1503908046familiesDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get familiesDataGrid():mx.controls.DataGrid
    {
        return this._1503908046familiesDataGrid;
    }

    public function set familiesDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._1503908046familiesDataGrid;
        if (oldValue !== value)
        {
            this._1503908046familiesDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "familiesDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property familiesTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'familiesTab' moved to '_1450939085familiesTab'
	 */

    [Bindable(event="propertyChange")]
    public function get familiesTab():mx.containers.Canvas
    {
        return this._1450939085familiesTab;
    }

    public function set familiesTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1450939085familiesTab;
        if (oldValue !== value)
        {
            this._1450939085familiesTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "familiesTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property importTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'importTab' moved to '_208538192importTab'
	 */

    [Bindable(event="propertyChange")]
    public function get importTab():mx.containers.Canvas
    {
        return this._208538192importTab;
    }

    public function set importTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._208538192importTab;
        if (oldValue !== value)
        {
            this._208538192importTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "importTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matchesDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matchesDataGrid' moved to '_878767005matchesDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get matchesDataGrid():mx.controls.DataGrid
    {
        return this._878767005matchesDataGrid;
    }

    public function set matchesDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._878767005matchesDataGrid;
        if (oldValue !== value)
        {
            this._878767005matchesDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matchesDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property matchesTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'matchesTab' moved to '_1870744930matchesTab'
	 */

    [Bindable(event="propertyChange")]
    public function get matchesTab():mx.containers.Canvas
    {
        return this._1870744930matchesTab;
    }

    public function set matchesTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1870744930matchesTab;
        if (oldValue !== value)
        {
            this._1870744930matchesTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "matchesTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property overviewTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'overviewTab' moved to '_89930588overviewTab'
	 */

    [Bindable(event="propertyChange")]
    public function get overviewTab():mx.containers.Canvas
    {
        return this._89930588overviewTab;
    }

    public function set overviewTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._89930588overviewTab;
        if (oldValue !== value)
        {
            this._89930588overviewTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "overviewTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property peopleDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'peopleDataGrid' moved to '_1631691199peopleDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get peopleDataGrid():mx.controls.DataGrid
    {
        return this._1631691199peopleDataGrid;
    }

    public function set peopleDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._1631691199peopleDataGrid;
        if (oldValue !== value)
        {
            this._1631691199peopleDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "peopleDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property peopleTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'peopleTab' moved to '_1898260858peopleTab'
	 */

    [Bindable(event="propertyChange")]
    public function get peopleTab():mx.containers.Canvas
    {
        return this._1898260858peopleTab;
    }

    public function set peopleTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1898260858peopleTab;
        if (oldValue !== value)
        {
            this._1898260858peopleTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "peopleTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property placesDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'placesDataGrid' moved to '_1497279100placesDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get placesDataGrid():mx.controls.DataGrid
    {
        return this._1497279100placesDataGrid;
    }

    public function set placesDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._1497279100placesDataGrid;
        if (oldValue !== value)
        {
            this._1497279100placesDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "placesDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property placesTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'placesTab' moved to '_1793100713placesTab'
	 */

    [Bindable(event="propertyChange")]
    public function get placesTab():mx.containers.Canvas
    {
        return this._1793100713placesTab;
    }

    public function set placesTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1793100713placesTab;
        if (oldValue !== value)
        {
            this._1793100713placesTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "placesTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sourcesDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourcesDataGrid' moved to '_1168584216sourcesDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get sourcesDataGrid():mx.controls.DataGrid
    {
        return this._1168584216sourcesDataGrid;
    }

    public function set sourcesDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._1168584216sourcesDataGrid;
        if (oldValue !== value)
        {
            this._1168584216sourcesDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourcesDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property sourcesTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourcesTab' moved to '_1110544195sourcesTab'
	 */

    [Bindable(event="propertyChange")]
    public function get sourcesTab():mx.containers.Canvas
    {
        return this._1110544195sourcesTab;
    }

    public function set sourcesTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1110544195sourcesTab;
        if (oldValue !== value)
        {
            this._1110544195sourcesTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourcesTab", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property tabs (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'tabs' moved to '_3552126tabs'
	 */

    [Bindable(event="propertyChange")]
    public function get tabs():mx.controls.TabBar
    {
        return this._3552126tabs;
    }

    public function set tabs(value:mx.controls.TabBar):void
    {
    	var oldValue:Object = this._3552126tabs;
        if (oldValue !== value)
        {
            this._3552126tabs = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tabs", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningLevelFormatter (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningLevelFormatter' moved to '_967500898warningLevelFormatter'
	 */

    [Bindable(event="propertyChange")]
    public function get warningLevelFormatter():mx.formatters.NumberFormatter
    {
        return this._967500898warningLevelFormatter;
    }

    public function set warningLevelFormatter(value:mx.formatters.NumberFormatter):void
    {
    	var oldValue:Object = this._967500898warningLevelFormatter;
        if (oldValue !== value)
        {
            this._967500898warningLevelFormatter = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningLevelFormatter", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningsDataGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningsDataGrid' moved to '_1826974599warningsDataGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get warningsDataGrid():mx.controls.DataGrid
    {
        return this._1826974599warningsDataGrid;
    }

    public function set warningsDataGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._1826974599warningsDataGrid;
        if (oldValue !== value)
        {
            this._1826974599warningsDataGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningsDataGrid", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property warningsTab (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'warningsTab' moved to '_480112706warningsTab'
	 */

    [Bindable(event="propertyChange")]
    public function get warningsTab():mx.containers.Canvas
    {
        return this._480112706warningsTab;
    }

    public function set warningsTab(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._480112706warningsTab;
        if (oldValue !== value)
        {
            this._480112706warningsTab = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warningsTab", oldValue, value));
        }
    }

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
	 * generated bindable wrapper for property TABS (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'TABS' moved to '_2567038TABS'
	 */

    [Bindable(event="propertyChange")]
    private function get TABS():ArrayCollection
    {
        return this._2567038TABS;
    }

    private function set TABS(value:ArrayCollection):void
    {
    	var oldValue:Object = this._2567038TABS;
        if (oldValue !== value)
        {
            this._2567038TABS = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "TABS", oldValue, value));
        }
    }



}
