package org.werelate.comps
{
	import mx.controls.Label;

	public class ReadableItemRenderer extends ExcludableItemRenderer
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle('fontWeight', data.@read == 'true' ? 'normal' : 'bold'); 
		}
	}
}