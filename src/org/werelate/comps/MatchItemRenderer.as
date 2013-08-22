package org.werelate.comps
{
	import mx.controls.Label;

	public class MatchItemRenderer extends ExcludableItemRenderer
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle('fontWeight', data.@matchRead == 'true' ? 'normal' : 'bold'); 
		}
	}
}