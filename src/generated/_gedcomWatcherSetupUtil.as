






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
public class _gedcomWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _gedcomWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import gedcom;
        (gedcom).watcherSetupUtil = new _gedcomWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.logging.ILoggingTarget;
        import mx.collections.ArrayCollection;
        import org.werelate.controllers.MainController;
        import mx.utils.ObjectProxy;
        import org.werelate.comps.LivingCheckBox;
        import org.werelate.model.ModelUtils;
        import flash.events.MouseEvent;
        import mx.controls.Spacer;
        import mx.logging.ILogger;
        import mx.containers.Grid;
        import mx.controls.DataGrid;
        import mx.core.ClassFactory;
        import mx.core.IFactory;
        import mx.controls.Button;
        import mx.utils.UIDUtil;
        import flash.events.EventDispatcher;
        import mx.core.Application;
        import org.werelate.comps.ExcludeCheckBox;
        import mx.containers.HBox;
        import mx.containers.GridRow;
        import mx.containers.GridItem;
        import org.werelate.TestBeans;
        import mx.core.IDeferredInstance;
        import mx.controls.Image;
        import org.werelate.comps.BeforeCutoffCheckBox;
        import mx.managers.HistoryManager;
        import mx.core.IPropertyChangeNotifier;
        import mx.containers.Canvas;
        import flash.events.IEventDispatcher;
        import mx.events.PropertyChangeEvent;
        import mx.controls.dataGridClasses.DataGridColumn;
        import mx.events.FlexEvent;
        import mx.events.DynamicEvent;
        import mx.events.ItemClickEvent;
        import mx.events.ListEvent;
        import flash.events.Event;
        import mx.core.UIComponentDescriptor;
        import mx.logging.LogEventLevel;
        import mx.core.DeferredInstanceFromClass;
        import mx.controls.Text;
        import mx.resources.ResourceManager;
        import mx.binding.IBindingClient;
        import org.werelate.model.Model;
        import org.werelate.comps.ReadableItemRenderer;
        import mx.containers.VBox;
        import mx.core.Container;
        import org.werelate.comps.MatchItemRenderer;
        import mx.core.DeferredInstanceFromFunction;
        import com.gskinner.StringUtils;
        import mx.logging.Log;
        import org.werelate.ReleaseBeans;
        import mx.controls.Alert;
        import mx.binding.BindingManager;
        import mx.controls.TabBar;
        import org.werelate.shared.Utils;
        import org.werelate.comps.ExcludableItemRenderer;
        import mx.controls.Label;
        import org.werelate.Beans;
        import mx.formatters.NumberFormatter;
        import xpanel.XPanelTarget;
        import org.swizframework.Swiz;
        import mx.events.ResizeEvent;
        import mx.core.mx_internal;
        import mx.logging.targets.LineFormattedTarget;
        import org.werelate.comps.WarningItemRenderer;

        // writeWatcher id=2 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[2] = new mx.binding.PropertyWatcher("model",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=2 size=25
        [
        bindings[34],
        bindings[2],
        bindings[3],
        bindings[38],
        bindings[7],
        bindings[42],
        bindings[9],
        bindings[46],
        bindings[13],
        bindings[15],
        bindings[51],
        bindings[50],
        bindings[49],
        bindings[19],
        bindings[48],
        bindings[55],
        bindings[53],
        bindings[52],
        bindings[22],
        bindings[59],
        bindings[58],
        bindings[57],
        bindings[56],
        bindings[26],
        bindings[30]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=24 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[24] = new mx.binding.PropertyWatcher("familiesMatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=24 size=1
        [
        bindings[30]
        ]
,
                                                                 null
);

        // writeWatcher id=33 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[33] = new mx.binding.PropertyWatcher("sourcesCitationOnly",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=33 size=1
        [
        bindings[42]
        ]
,
                                                                 null
);

        // writeWatcher id=31 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[31] = new mx.binding.PropertyWatcher("sourcesMatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=31 size=1
        [
        bindings[42]
        ]
,
                                                                 null
);

        // writeWatcher id=28 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[28] = new mx.binding.PropertyWatcher("placesMatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=28 size=1
        [
        bindings[38]
        ]
,
                                                                 null
);

        // writeWatcher id=46 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[46] = new mx.binding.PropertyWatcher("isHoldable",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=46 size=1
        [
        bindings[59]
        ]
,
                                                                 null
);

        // writeWatcher id=37 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[37] = new mx.binding.PropertyWatcher("people",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=37 size=1
        [
        bindings[48]
        ]
,
                                                                 null
);

        // writeWatcher id=41 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[41] = new mx.binding.PropertyWatcher("sources",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=41 size=1
        [
        bindings[52]
        ]
,
                                                                 null
);

        // writeWatcher id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[3] = new mx.binding.PropertyWatcher("nextSteps",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=3 size=1
        [
        bindings[2]
        ]
,
                                                                 null
);

        // writeWatcher id=20 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[20] = new mx.binding.PropertyWatcher("peopleToImport",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=20 size=1
        [
        bindings[26]
        ]
,
                                                                 null
);

        // writeWatcher id=42 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[42] = new mx.binding.PropertyWatcher("matches",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=42 size=1
        [
        bindings[53]
        ]
,
                                                                 null
);

        // writeWatcher id=11 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[11] = new mx.binding.PropertyWatcher("warningComment",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=11 size=1
        [
        bindings[9]
        ]
,
                                                                 null
);

        // writeWatcher id=22 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[22] = new mx.binding.PropertyWatcher("peopleExcluded",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=22 size=1
        [
        bindings[26]
        ]
,
                                                                 null
);

        // writeWatcher id=14 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[14] = new mx.binding.PropertyWatcher("totalNonExcludedSources",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=14 size=1
        [
        bindings[19]
        ]
,
                                                                 null
);

        // writeWatcher id=26 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[26] = new mx.binding.PropertyWatcher("warningsRead",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=26 size=1
        [
        bindings[34]
        ]
,
                                                                 null
);

        // writeWatcher id=35 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[35] = new mx.binding.PropertyWatcher("matchesUnmatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=35 size=1
        [
        bindings[46]
        ]
,
                                                                 null
);

        // writeWatcher id=17 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[17] = new mx.binding.PropertyWatcher("primaryPerson",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=17 size=1
        [
        bindings[22]
        ]
,
                                                                 null
);

        // writeWatcher id=18 shouldWriteSelf=true class=flex2.compiler.as3.binding.XMLWatcher shouldWriteChildren=true
        watchers[18] = new mx.binding.XMLWatcher("event_fact",
        // writeWatcherListeners id=18 size=1
        [
        bindings[22]
        ]
        );

        // writeWatcher id=45 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[45] = new mx.binding.PropertyWatcher("isReturnable",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=45 size=2
        [
        bindings[58],
        bindings[57]
        ]
,
                                                                 null
);

        // writeWatcher id=39 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[39] = new mx.binding.PropertyWatcher("warnings",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=39 size=1
        [
        bindings[50]
        ]
,
                                                                 null
);

        // writeWatcher id=30 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[30] = new mx.binding.PropertyWatcher("sourcesToImport",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=30 size=1
        [
        bindings[42]
        ]
,
                                                                 null
);

        // writeWatcher id=9 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[9] = new mx.binding.PropertyWatcher("warningLevel",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=9 size=1
        [
        bindings[7]
        ]
,
                                                                 null
);

        // writeWatcher id=25 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[25] = new mx.binding.PropertyWatcher("familiesExcluded",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=25 size=1
        [
        bindings[30]
        ]
,
                                                                 null
);

        // writeWatcher id=12 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[12] = new mx.binding.PropertyWatcher("duplicateCount",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=12 size=1
        [
        bindings[13]
        ]
,
                                                                 null
);

        // writeWatcher id=13 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[13] = new mx.binding.PropertyWatcher("duplicateComment",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=13 size=1
        [
        bindings[15]
        ]
,
                                                                 null
);

        // writeWatcher id=32 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[32] = new mx.binding.PropertyWatcher("sourcesExcluded",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=32 size=1
        [
        bindings[42]
        ]
,
                                                                 null
);

        // writeWatcher id=40 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[40] = new mx.binding.PropertyWatcher("places",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=40 size=1
        [
        bindings[51]
        ]
,
                                                                 null
);

        // writeWatcher id=27 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[27] = new mx.binding.PropertyWatcher("warningsUnread",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=27 size=1
        [
        bindings[34]
        ]
,
                                                                 null
);

        // writeWatcher id=38 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[38] = new mx.binding.PropertyWatcher("families",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=38 size=1
        [
        bindings[49]
        ]
,
                                                                 null
);

        // writeWatcher id=23 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[23] = new mx.binding.PropertyWatcher("familiesToImport",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=23 size=1
        [
        bindings[30]
        ]
,
                                                                 null
);

        // writeWatcher id=44 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[44] = new mx.binding.PropertyWatcher("isImportable",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=44 size=1
        [
        bindings[56]
        ]
,
                                                                 null
);

        // writeWatcher id=21 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[21] = new mx.binding.PropertyWatcher("peopleMatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=21 size=1
        [
        bindings[26]
        ]
,
                                                                 null
);

        // writeWatcher id=29 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[29] = new mx.binding.PropertyWatcher("placesUnmatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=29 size=1
        [
        bindings[38]
        ]
,
                                                                 null
);

        // writeWatcher id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[4] = new mx.binding.PropertyWatcher("isUpdatable",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=4 size=1
        [
        bindings[3]
        ]
,
                                                                 null
);

        // writeWatcher id=43 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[43] = new mx.binding.PropertyWatcher("importInstructions",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=43 size=1
        [
        bindings[55]
        ]
,
                                                                 null
);

        // writeWatcher id=36 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[36] = new mx.binding.PropertyWatcher("matchesUndecided",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=36 size=1
        [
        bindings[46]
        ]
,
                                                                 null
);

        // writeWatcher id=34 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[34] = new mx.binding.PropertyWatcher("matchesMatched",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=34 size=1
        [
        bindings[46]
        ]
,
                                                                 null
);

        // writeWatcher id=10 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true

        // writeWatcher id=5 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true

        // writeWatcher id=15 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[15] = new mx.binding.PropertyWatcher("mu",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=15 size=1
        [
        bindings[22]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=16 shouldWriteSelf=false class=flex2.compiler.as3.binding.FunctionReturnWatcher shouldWriteChildren=true

        // writeWatcher id=7 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[7] = new mx.binding.PropertyWatcher("warningLevelFormatter",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=7 size=1
        [
        bindings[7]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=8 shouldWriteSelf=false class=flex2.compiler.as3.binding.FunctionReturnWatcher shouldWriteChildren=true

        // writeWatcher id=6 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true

        // writeWatcher id=19 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("TABS",
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

        // writeWatcher id=1 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true


        // writeWatcherBottom id=2 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].updateParent(target);

 





        // writeWatcherBottom id=24 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[24]);

 





        // writeWatcherBottom id=33 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[33]);

 





        // writeWatcherBottom id=31 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[31]);

 





        // writeWatcherBottom id=28 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[28]);

 





        // writeWatcherBottom id=46 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[46]);

 





        // writeWatcherBottom id=37 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[37]);

 





        // writeWatcherBottom id=41 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[41]);

 





        // writeWatcherBottom id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[3]);

 





        // writeWatcherBottom id=20 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[20]);

 





        // writeWatcherBottom id=42 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[42]);

 





        // writeWatcherBottom id=11 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[11]);

 





        // writeWatcherBottom id=22 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[22]);

 





        // writeWatcherBottom id=14 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[14]);

 





        // writeWatcherBottom id=26 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[26]);

 





        // writeWatcherBottom id=35 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[35]);

 





        // writeWatcherBottom id=17 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[17]);

 





        // writeWatcherBottom id=18 shouldWriteSelf=true class=flex2.compiler.as3.binding.XMLWatcher
        watchers[17].addChild(watchers[18]);

 





        // writeWatcherBottom id=45 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[45]);

 





        // writeWatcherBottom id=39 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[39]);

 





        // writeWatcherBottom id=30 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[30]);

 





        // writeWatcherBottom id=9 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[9]);

 





        // writeWatcherBottom id=25 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[25]);

 





        // writeWatcherBottom id=12 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[12]);

 





        // writeWatcherBottom id=13 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[13]);

 





        // writeWatcherBottom id=32 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[32]);

 





        // writeWatcherBottom id=40 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[40]);

 





        // writeWatcherBottom id=27 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[27]);

 





        // writeWatcherBottom id=38 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[38]);

 





        // writeWatcherBottom id=23 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[23]);

 





        // writeWatcherBottom id=44 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[44]);

 





        // writeWatcherBottom id=21 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[21]);

 





        // writeWatcherBottom id=29 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[29]);

 





        // writeWatcherBottom id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[4]);

 





        // writeWatcherBottom id=43 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[43]);

 





        // writeWatcherBottom id=36 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[36]);

 





        // writeWatcherBottom id=34 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].addChild(watchers[34]);

 





        // writeWatcherBottom id=10 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher

 





        // writeWatcherBottom id=5 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher

 





        // writeWatcherBottom id=15 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[15].updateParent(target);

 





        // writeWatcherBottom id=16 shouldWriteSelf=false class=flex2.compiler.as3.binding.FunctionReturnWatcher

 





        // writeWatcherBottom id=7 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[7].updateParent(target);

 





        // writeWatcherBottom id=8 shouldWriteSelf=false class=flex2.compiler.as3.binding.FunctionReturnWatcher

 





        // writeWatcherBottom id=6 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher

 





        // writeWatcherBottom id=19 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher

 





        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





        // writeWatcherBottom id=1 shouldWriteSelf=false class=flex2.compiler.as3.binding.PropertyWatcher

 





    }
}

}
