
package 
{

import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.core.mx_internal;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

[ExcludeClass]

public class _TitleWindowStyle
{
    [Embed(_resolvedSource='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', symbol='CloseButtonOver', source='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='1492', _file='/home/dallan/libs/flex3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf_CloseButtonOver_330438724:Class;
    [Embed(_resolvedSource='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', symbol='CloseButtonDisabled', source='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='1490', _file='/home/dallan/libs/flex3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf_CloseButtonDisabled_2098433892:Class;
    [Embed(_resolvedSource='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', symbol='CloseButtonDown', source='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='1491', _file='/home/dallan/libs/flex3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf_CloseButtonDown_1766527338:Class;
    [Embed(_resolvedSource='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', symbol='CloseButtonUp', source='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='1493', _file='/home/dallan/libs/flex3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf_CloseButtonUp_745599491:Class;

    public static function init(fbs:IFlexModuleFactory):void
    {
        var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TitleWindow");
    
        if (!style)
        {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TitleWindow", style, false);
        }
    
        if (style.defaultFactory == null)
        {
            style.defaultFactory = function():void
            {
                this.closeButtonDisabledSkin = _embed_css_Assets_swf_CloseButtonDisabled_2098433892;
                this.paddingTop = 4;
                this.dropShadowEnabled = true;
                this.backgroundColor = 0xffffff;
                this.closeButtonOverSkin = _embed_css_Assets_swf_CloseButtonOver_330438724;
                this.closeButtonUpSkin = _embed_css_Assets_swf_CloseButtonUp_745599491;
                this.closeButtonDownSkin = _embed_css_Assets_swf_CloseButtonDown_1766527338;
                this.cornerRadius = 8;
                this.paddingLeft = 4;
                this.paddingBottom = 4;
                this.paddingRight = 4;
            };
        }
    }
}

}
