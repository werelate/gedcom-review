
package 
{

import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.core.mx_internal;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;
import mx.skins.halo.BrokenImageBorderSkin;

[ExcludeClass]

public class _SWFLoaderStyle
{
    [Embed(_resolvedSource='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', symbol='__brokenImage', source='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='1333', _file='/home/dallan/libs/flex3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf___brokenImage_1835627076:Class;

    public static function init(fbs:IFlexModuleFactory):void
    {
        var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("SWFLoader");
    
        if (!style)
        {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("SWFLoader", style, false);
        }
    
        if (style.defaultFactory == null)
        {
            style.defaultFactory = function():void
            {
                this.borderStyle = "none";
                this.brokenImageSkin = _embed_css_Assets_swf___brokenImage_1835627076;
                this.brokenImageBorderSkin = mx.skins.halo.BrokenImageBorderSkin;
            };
        }
    }
}

}
