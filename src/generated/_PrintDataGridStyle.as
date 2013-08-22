
package 
{

import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.core.mx_internal;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;
import mx.skins.halo.DataGridSortArrow;
import mx.skins.halo.DataGridColumnResizeSkin;
import mx.skins.halo.DataGridHeaderSeparator;

[ExcludeClass]

public class _PrintDataGridStyle
{
    [Embed(_resolvedSource='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', symbol='cursorStretch', source='/home/dallan/libs/flex3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='1157', _file='/home/dallan/libs/flex3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf_cursorStretch_1576438377:Class;

    public static function init(fbs:IFlexModuleFactory):void
    {
        var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("PrintDataGrid");
    
        if (!style)
        {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("PrintDataGrid", style, false);
        }
    
        if (style.defaultFactory == null)
        {
            style.defaultFactory = function():void
            {
                this.sortArrowSkin = mx.skins.halo.DataGridSortArrow;
                this.borderColor = 0;
                this.columnResizeSkin = mx.skins.halo.DataGridColumnResizeSkin;
                this.stretchCursor = _embed_css_Assets_swf_cursorStretch_1576438377;
                this.horizontalGridLines = true;
                this.alternatingItemColors = [0xffffff, 0xffffff];
                this.horizontalGridLineColor = 0;
                this.headerStyleName = "dataGridStyles";
                this.headerSeparatorSkin = mx.skins.halo.DataGridHeaderSeparator;
                this.headerColors = [0xffffff, 0xffffff];
                this.verticalGridLineColor = 0x000000;
            };
        }
    }
}

}
