






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
public class _org_werelate_comps_UnlinkDialogWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _org_werelate_comps_UnlinkDialogWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import org.werelate.comps.UnlinkDialog;
        (org.werelate.comps.UnlinkDialog).watcherSetupUtil = new _org_werelate_comps_UnlinkDialogWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.UIComponentDescriptor;
        import mx.core.DeferredInstanceFromClass;
        import mx.collections.ArrayCollection;
        import mx.utils.ObjectProxy;
        import mx.events.CloseEvent;
        import mx.binding.IBindingClient;
        import org.werelate.model.ModelUtils;
        import flash.events.MouseEvent;
        import org.werelate.comps.UnlinkDialog_inlineComponent1;
        import org.werelate.controllers.UnlinkController;
        import mx.controls.Spacer;
        import mx.containers.TitleWindow;
        import mx.controls.DataGrid;
        import mx.core.ClassFactory;
        import mx.core.IFactory;
        import mx.controls.Button;
        import mx.core.DeferredInstanceFromFunction;
        import mx.utils.UIDUtil;
        import flash.events.EventDispatcher;
        import mx.core.Application;
        import mx.containers.HBox;
        import mx.binding.BindingManager;
        import mx.managers.PopUpManager;
        import mx.controls.Label;
        import mx.core.IFlexDisplayObject;
        import mx.core.IDeferredInstance;
        import mx.core.IPropertyChangeNotifier;
        import flash.events.IEventDispatcher;
        import mx.events.PropertyChangeEvent;
        import mx.controls.dataGridClasses.DataGridColumn;
        import mx.core.mx_internal;
        import mx.events.FlexEvent;
        import flash.events.Event;

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("members",
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
