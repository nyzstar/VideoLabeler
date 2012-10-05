package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.*;
	public class Button extends Sprite
	{
		var cover:Shape;
		public function Button()
		{
			this.cover = new Shape();
			this.addEventListener(MouseEvent.MOUSE_DOWN, buttonChangeColor);
		}

		private function buttonChangeColor(e:MouseEvent):void
		{
			cover.graphics.clear();
			cover.graphics.beginFill(0x000000, 0.5);
			cover.graphics.drawRect(0, 0, this.width, this.height);
			cover.graphics.endFill();
			if(!this.contains(cover)){
				this.addChild(cover);
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, buttonResetColor);
			//stage.addEventListener(MouseEvent.ROLL_OUT, buttonResetColor);
			
		}

		private function buttonResetColor(e:MouseEvent):void
		{
			cover.graphics.clear();
		}
	}

}