package org.werelate.comps
{
import flash.display.Graphics;

import mx.controls.DataGrid;
import mx.controls.Label;
import mx.controls.dataGridClasses.DataGridListData;

public class WarningItemRenderer extends ExcludableItemRenderer
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle('fontWeight', data.@warningRead == 'true' ? 'normal' : 'bold');
         var color:uint = 0xFFFFFF;
         if (data.@warningLevel == 0) {
            color = 0xFFFFFF; // white
         }
         else if (data.@warningLevel == 1) {
            color = 0xFFFF00; // yellow
         }
         else if (data.@warningLevel >= 2) {
            color = 0xFF0000; // red
         }
         var g:Graphics=graphics;
         g.clear();
         var grid1:DataGrid=DataGrid(DataGridListData(listData).owner);
         if (grid1.isItemSelected(data) || grid1.isItemHighlighted(data)) {
            return;
         }
         g.beginFill(color, .03);
         g.drawRect(0,0,unscaledWidth,unscaledHeight);
         g.endFill();
         // setStyle('color', color);
		}
	}
}