
package 
{
import flash.accessibility.*;
import flash.debugger.*;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.*;
import flash.filters.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.printing.*;
import flash.profiler.*;
import flash.system.*;
import flash.text.*;
import flash.ui.*;
import flash.utils.*;
import flash.xml.*;
import mx.binding.*;
import mx.containers.Canvas;
import mx.controls.DataGrid;
import mx.controls.TabBar;
import mx.core.Application;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.formatters.NumberFormatter;
import mx.styles.*;
import mx.containers.Grid;
import mx.containers.HBox;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.containers.GridRow;
import mx.controls.Button;
import mx.containers.VBox;
import mx.containers.GridItem;
import mx.controls.Text;
import mx.controls.Label;
import mx.controls.Image;
import mx.core.Application;
import mx.controls.Spacer;


[ResourceBundle("messages")]

public class gedcom extends mx.core.Application
{
	public function gedcom() {}

	[Bindable]
	public var warningLevelFormatter : mx.formatters.NumberFormatter;
	[Bindable]
	public var tabs : mx.controls.TabBar;
	[Bindable]
	public var containers : mx.containers.Canvas;
	[Bindable]
	public var overviewTab : mx.containers.Canvas;
	[Bindable]
	public var peopleTab : mx.containers.Canvas;
	[Bindable]
	public var peopleDataGrid : mx.controls.DataGrid;
	[Bindable]
	public var familiesTab : mx.containers.Canvas;
	[Bindable]
	public var familiesDataGrid : mx.controls.DataGrid;
	[Bindable]
	public var warningsTab : mx.containers.Canvas;
	[Bindable]
	public var warningsDataGrid : mx.controls.DataGrid;
	[Bindable]
	public var placesTab : mx.containers.Canvas;
	[Bindable]
	public var placesDataGrid : mx.controls.DataGrid;
	[Bindable]
	public var sourcesTab : mx.containers.Canvas;
	[Bindable]
	public var sourcesDataGrid : mx.controls.DataGrid;
	[Bindable]
	public var matchesTab : mx.containers.Canvas;
	[Bindable]
	public var matchesDataGrid : mx.controls.DataGrid;
	[Bindable]
	public var importTab : mx.containers.Canvas;

	mx_internal var _bindings : Array;
	mx_internal var _watchers : Array;
	mx_internal var _bindingsByDestination : Object;
	mx_internal var _bindingsBeginWithWord : Object;

include "/home/dallan/werelate/gedcom-review/src/gedcom.mxml:17,716";

}}
