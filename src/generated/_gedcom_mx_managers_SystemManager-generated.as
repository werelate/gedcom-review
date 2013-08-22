package
{

import flash.display.LoaderInfo;
import flash.text.Font;
import flash.text.TextFormat;
import flash.system.ApplicationDomain;
import flash.system.Security;
import flash.utils.getDefinitionByName;
import flash.utils.Dictionary;
import mx.core.IFlexModule;
import mx.core.IFlexModuleFactory;
import mx.core.FlexVersion;
import mx.managers.SystemManager;

/**
 *  @private
 */
[ExcludeClass]
public class _gedcom_mx_managers_SystemManager
    extends mx.managers.SystemManager
    implements IFlexModuleFactory
{
    public function _gedcom_mx_managers_SystemManager()
    {
        FlexVersion.compatibilityVersionString = "3.0.0";
        super();
    }

    override     public function create(... params):Object
    {
        if (params.length > 0 && !(params[0] is String))
            return super.create.apply(this, params);

        var mainClassName:String = params.length == 0 ? "gedcom" : String(params[0]);
        var mainClass:Class = Class(getDefinitionByName(mainClassName));
        if (!mainClass)
            return null;

        var instance:Object = new mainClass();
        if (instance is IFlexModule)
            (IFlexModule(instance)).moduleFactory = this;
        return instance;
    }

    override    public function info():Object
    {
        return {
            backgroundColor: "#90b0ff",
            compiledLocales: [ "en_US" ],
            compiledResourceBundleNames: [ "SharedResources", "collections", "containers", "controls", "core", "effects", "formatters", "logging", "messages", "messaging", "rpc", "skins", "styles" ],
            creationComplete: "onCreationComplete()",
            currentDomain: ApplicationDomain.currentDomain,
            historyManagementEnabled: "false",
            layout: "vertical",
            mainClassName: "gedcom",
            mixins: [ "_gedcom_FlexInit", "_richTextEditorTextAreaStyleStyle", "_alertButtonStyleStyle", "_ControlBarStyle", "_SWFLoaderStyle", "_textAreaVScrollBarStyleStyle", "_headerDateTextStyle", "_TitleWindowStyle", "_globalStyle", "_ListBaseStyle", "_todayStyleStyle", "_AlertStyle", "_TabBarStyle", "_windowStylesStyle", "_PrintDataGridStyle", "_ApplicationStyle", "_ToolTipStyle", "_ButtonBarButtonStyle", "_CursorManagerStyle", "_opaquePanelStyle", "_TextInputStyle", "_errorTipStyle", "_ApplicationControlBarStyle", "_dateFieldPopupStyle", "_DataGridStyle", "_TabStyle", "_dataGridStylesStyle", "_popUpMenuStyle", "_headerDragProxyStyleStyle", "_activeTabStyleStyle", "_PanelStyle", "_ProgressBarStyle", "_DragManagerStyle", "_ContainerStyle", "_windowStatusStyle", "_ScrollBarStyle", "_swatchPanelTextFieldStyle", "_ButtonBarStyle", "_textAreaHScrollBarStyleStyle", "_plainStyle", "_activeButtonStyleStyle", "_CheckBoxStyle", "_comboDropdownStyle", "_ButtonStyle", "_DataGridItemRendererStyle", "_weekDayStyleStyle", "_linkButtonStyleStyle", "_gedcomWatcherSetupUtil", "_org_werelate_comps_WarningsPrintWatcherSetupUtil", "_org_werelate_comps_TipAlertWatcherSetupUtil", "_org_werelate_comps_UnlinkDialogWatcherSetupUtil", "_org_werelate_comps_WLHDialogWatcherSetupUtil", "_org_werelate_comps_UnlinkDialog_inlineComponent1WatcherSetupUtil", "_org_werelate_comps_LivingCheckBoxWatcherSetupUtil", "_org_werelate_comps_BeforeCutoffCheckBoxWatcherSetupUtil", "_org_werelate_comps_ExcludeCheckBoxWatcherSetupUtil" ],
            paddingBottom: "0",
            paddingLeft: "0",
            paddingRight: "0",
            paddingTop: "0",
            preinitialize: "onPreInit()",
            verticalGap: "-1"
        }
    }


    /**
     *  @private
     */
    private var _preloadedRSLs:Dictionary; // key: LoaderInfo, value: RSL URL

    /**
     *  The RSLs loaded by this system manager before the application
     *  starts. RSLs loaded by the application are not included in this list.
     */
    override     public function get preloadedRSLs():Dictionary
    {
        if (_preloadedRSLs == null)
           _preloadedRSLs = new Dictionary(true);
        return _preloadedRSLs;
    }

    /**
     *  Calls Security.allowDomain() for the SWF associated with this IFlexModuleFactory
     *  plus all the SWFs assocatiated with RSLs preLoaded by this IFlexModuleFactory.
     *
     */
    override     public function allowDomain(... domains):void
    {
        Security.allowDomain(domains);

        for (var loaderInfo:Object in _preloadedRSLs)
        {
            if (loaderInfo.content && ("allowDomainInRSL" in loaderInfo.content))
            {
                loaderInfo.content["allowDomainInRSL"](domains);
            }
        }
    }

    /**
     *  Calls Security.allowInsecureDomain() for the SWF associated with this IFlexModuleFactory
     *  plus all the SWFs assocatiated with RSLs preLoaded by this IFlexModuleFactory.
     *
     */
    override     public function allowInsecureDomain(... domains):void
    {
        Security.allowInsecureDomain(domains);

        for (var loaderInfo:Object in _preloadedRSLs)
        {
            if (loaderInfo.content && ("allowInsecureDomainInRSL" in loaderInfo.content))
            {
                loaderInfo.content["allowInsecureDomainInRSL"](domains);
            }
        }
    }


}

}
