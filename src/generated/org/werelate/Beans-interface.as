
package org.werelate
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
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.styles.*;
import org.swizframework.util.BeanLoader;
import org.werelate.controllers.IncludeExclude;
import org.werelate.controllers.MainController;
import org.werelate.controllers.MatchAllController;
import org.werelate.controllers.ModelLoader;
import org.werelate.controllers.TipAlertController;
import org.werelate.controllers.UnlinkController;
import org.werelate.controllers.WLHController;
import org.werelate.model.Model;
import org.werelate.model.ModelUtils;
import org.werelate.services.SharedObjectService;
import org.werelate.services.WeRelateService;
import org.swizframework.util.BeanLoader;

public class Beans extends org.swizframework.util.BeanLoader
{
	public function Beans() {}

	[Bindable]
	public var mainController : org.werelate.controllers.MainController;
	[Bindable]
	public var modelLoader : org.werelate.controllers.ModelLoader;
	[Bindable]
	public var matchAllController : org.werelate.controllers.MatchAllController;
	[Bindable]
	public var includeExclude : org.werelate.controllers.IncludeExclude;
	[Bindable]
	public var tipAlertController : org.werelate.controllers.TipAlertController;
	[Bindable]
	public var unlinkController : org.werelate.controllers.UnlinkController;
	[Bindable]
	public var wlhController : org.werelate.controllers.WLHController;
	[Bindable]
	public var model : org.werelate.model.Model;
	[Bindable]
	public var modelUtils : org.werelate.model.ModelUtils;
	[Bindable]
	public var werelateService : org.werelate.services.WeRelateService;
	[Bindable]
	public var sharedObjectService : org.werelate.services.SharedObjectService;

	mx_internal var _bindings : Array;
	mx_internal var _watchers : Array;
	mx_internal var _bindingsByDestination : Object;
	mx_internal var _bindingsBeginWithWord : Object;


}}
