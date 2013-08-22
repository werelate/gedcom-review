
package org.werelate.shared
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
import mx.containers.HBox;
import mx.containers.VBox;
import mx.controls.Label;
import mx.controls.ProgressBar;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.styles.*;
import mx.containers.Canvas;
import mx.containers.ApplicationControlBar;
import mx.containers.VBox;
import mx.controls.Spacer;

public class PleaseWait extends mx.containers.VBox
{
	public function PleaseWait() {}

	[Bindable]
	public var heading : mx.controls.Label;
	[Bindable]
	public var progressBar : mx.controls.ProgressBar;
	[Bindable]
	public var countBar : mx.containers.HBox;
	[Bindable]
	public var countLabel : mx.controls.Label;
	[Bindable]
	public var message : mx.controls.Label;

	mx_internal var _bindings : Array;
	mx_internal var _watchers : Array;
	mx_internal var _bindingsByDestination : Object;
	mx_internal var _bindingsBeginWithWord : Object;

include "/home/dallan/werelate/gedcom-review/src/org/werelate/shared/PleaseWait.mxml:8,81";

}}
