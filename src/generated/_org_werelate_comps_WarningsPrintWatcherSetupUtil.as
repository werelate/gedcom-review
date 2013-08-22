






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
public class _org_werelate_comps_WarningsPrintWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _org_werelate_comps_WarningsPrintWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import org.werelate.comps.WarningsPrint;
        (org.werelate.comps.WarningsPrint).watcherSetupUtil = new _org_werelate_comps_WarningsPrintWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.UIComponentDescriptor;
        import mx.binding.BindingManager;
        import mx.core.DeferredInstanceFromClass;
        import mx.printing.PrintDataGrid;
        import mx.utils.ObjectProxy;
        import mx.controls.Label;
        import mx.core.IDeferredInstance;
        import org.werelate.model.ModelUtils;
        import mx.binding.IBindingClient;
        import mx.core.IPropertyChangeNotifier;
        import flash.events.IEventDispatcher;
        import mx.events.PropertyChangeEvent;
        import mx.core.ClassFactory;
        import mx.core.IFactory;
        import mx.containers.VBox;
        import mx.controls.dataGridClasses.DataGridColumn;
        import mx.core.mx_internal;
        import mx.core.DeferredInstanceFromFunction;
        import mx.utils.UIDUtil;
        import flash.events.EventDispatcher;
        import flash.events.Event;

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("pageNumber",
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


        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





    }
}

}
