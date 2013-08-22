






package
{
import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.binding.ArrayElementWatcher;
import mx.binding.FunctionReturnWatcher;
import mx.binding.IWatcherSetupUtil;
import mx.binding.PropertyWatcher;
import mx.binding.RepeaterComponentWatcher;
import mx.binding.RepeaterItemWatcher;
import mx.binding.StaticPropertyWatcher;
import mx.binding.XMLWatcher;
import mx.binding.Watcher;

[ExcludeClass]
[Mixin]
public class _org_werelate_comps_TipAlertWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _org_werelate_comps_TipAlertWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import org.werelate.comps.TipAlert;
        (org.werelate.comps.TipAlert).watcherSetupUtil = new _org_werelate_comps_TipAlertWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.UIComponentDescriptor;
        import org.werelate.controllers.TipAlertController;
        import mx.core.DeferredInstanceFromClass;
        import mx.utils.ObjectProxy;
        import mx.controls.Text;
        import mx.events.CloseEvent;
        import mx.binding.IBindingClient;
        import flash.events.MouseEvent;
        import mx.controls.Spacer;
        import mx.containers.TitleWindow;
        import mx.core.ClassFactory;
        import mx.controls.CheckBox;
        import mx.core.IFactory;
        import mx.controls.Button;
        import mx.core.DeferredInstanceFromFunction;
        import mx.utils.UIDUtil;
        import flash.events.EventDispatcher;
        import mx.core.Application;
        import mx.containers.HBox;
        import mx.binding.BindingManager;
        import mx.managers.PopUpManager;
        import mx.core.IFlexDisplayObject;
        import mx.core.IDeferredInstance;
        import mx.core.IPropertyChangeNotifier;
        import flash.events.IEventDispatcher;
        import mx.events.PropertyChangeEvent;
        import mx.core.mx_internal;
        import mx.events.FlexEvent;
        import flash.events.Event;

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("tipMessage",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=1 size=1
        [
        bindings[1]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("okButton",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=0 size=1
        [
        bindings[0]
        ]
,
                                                                 propertyGetter
);


        // writeWatcherBottom id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[1].updateParent(target);

 





        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





    }
}

}
