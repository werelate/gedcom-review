






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
public class _org_werelate_comps_ExcludeCheckBoxWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _org_werelate_comps_ExcludeCheckBoxWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import org.werelate.comps.ExcludeCheckBox;
        (org.werelate.comps.ExcludeCheckBox).watcherSetupUtil = new _org_werelate_comps_ExcludeCheckBoxWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.UIComponentDescriptor;
        import mx.containers.HBox;
        import mx.binding.BindingManager;
        import mx.core.DeferredInstanceFromClass;
        import org.werelate.controllers.MainController;
        import mx.utils.ObjectProxy;
        import mx.core.IDeferredInstance;
        import flash.events.MouseEvent;
        import mx.binding.IBindingClient;
        import org.werelate.model.Model;
        import mx.core.IPropertyChangeNotifier;
        import flash.events.IEventDispatcher;
        import mx.events.PropertyChangeEvent;
        import mx.core.ClassFactory;
        import mx.controls.CheckBox;
        import mx.core.IFactory;
        import mx.core.mx_internal;
        import mx.core.DeferredInstanceFromFunction;
        import mx.utils.UIDUtil;
        import flash.events.EventDispatcher;
        import flash.events.Event;

        // writeWatcher id=2 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[2] = new mx.binding.PropertyWatcher("model",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=2 size=1
        [
        bindings[1]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[3] = new mx.binding.PropertyWatcher("isUpdatable",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=3 size=1
        [
        bindings[1]
        ]
,
                                                                 null
);

        // writeWatcher id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[4] = new mx.binding.PropertyWatcher("isAdmin",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=4 size=1
        [
        bindings[1]
        ]
,
                                                                 null
);

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("data",
            {
                dataChange: true
            }
,         // writeWatcherListeners id=0 size=2
        [
        bindings[0],
        bindings[1]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=6 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[6] = new mx.binding.PropertyWatcher("beforeCutoff",
            null
,         // writeWatcherListeners id=6 size=1
        [
        bindings[1]
        ]
,
                                                                 null
);

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("exclude",
            null
,         // writeWatcherListeners id=1 size=1
        [
        bindings[0]
        ]
,
                                                                 null
);

        // writeWatcher id=5 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[5] = new mx.binding.PropertyWatcher("living",
            null
,         // writeWatcherListeners id=5 size=1
        [
        bindings[1]
        ]
,
                                                                 null
);


        // writeWatcherBottom id=2 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].updateParent(target);

 





        // writeWatcherBottom id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[3]);

 





        // writeWatcherBottom id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[4]);

 





        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





        // writeWatcherBottom id=6 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].addChild(watchers[6]);

 





        // writeWatcherBottom id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].addChild(watchers[1]);

 





        // writeWatcherBottom id=5 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].addChild(watchers[5]);

 





    }
}

}
