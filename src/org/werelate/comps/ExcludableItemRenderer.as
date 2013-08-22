package org.werelate.comps
{
	import mx.controls.DataGrid;
	import mx.controls.Label;

	public class ExcludableItemRenderer extends Label
	{
		private function getToolTip():String{
			var dg:DataGrid = listData.owner as DataGrid;
			var func:Function = dg.columns[listData.columnIndex].dataTipFunction;
		
			if(func != null) {
				return func.call(this, this.data);
			}
			else if(dg.columns[listData.columnIndex].dataTipField != null) {
				return data[dg.columns[listData.columnIndex].dataTipField];
			}
			else {
				return "";
			}
		}
				
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle('color', data.@exclude == 'true' ? 'gray' : 'black');
			this.toolTip = getToolTip(); 
		}
	}
}