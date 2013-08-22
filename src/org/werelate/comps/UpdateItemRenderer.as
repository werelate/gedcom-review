package org.werelate.comps
{
	import mx.controls.Label;

	public class UpdateItemRenderer extends ExcludableItemRenderer
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle('fontWeight', data.@updateRead == 'true' ? 'normal' : 'bold'); 
		}
	}
}