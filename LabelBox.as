package  {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class LabelBox extends Sprite{
		public var labelname:String;
		public var labelWidth:Number;
		public var labelHeight:Number;
		public var fillColor:Number;
		private var lineColor:Number;
		private var labelText:TextField;
		private var lineWidth:int;
		private var fondSize:int;
		public function LabelBox(w:Number, h:Number, c:Number = 0xFFFFFF, n:String = "") {
			// constructor code
			labelname = n;
			labelWidth = w;
			labelHeight = h;
			fillColor = c;
			lineColor = 0x000000;
			lineWidth = 1;
			labelText = new TextField();
			drawLabelBox();
		}
		
		public function updateLabelBox(w:Number, h:Number, c:Number, n:String){
			labelname = n;
			labelWidth = w;
			labelHeight = h;
			fillColor = c;
			drawLabelBox();
		}
		
		public function resizeLabelBox(w:Number, h:Number){
			labelWidth = w;
			labelHeight = h;
			drawLabelBox();
		}
		
		public function changeLabelName(n:String){
			labelname = n;
			drawLabelBox();
		}
		
		public function changeLabelColor(c:Number){
			fillColor = c;
			drawLabelBox();
		}
		
		public function changeLineWidth(w:Number){
			lineWidth = w;
			drawLabelBox();
		}
		private function drawLabelBox(){
			this.graphics.clear();
			this.graphics.lineStyle(lineWidth, lineColor);
			this.graphics.beginFill(fillColor);
			//trace(labelWidth);
			//trace(labelHeight);
			this.graphics.drawRect(0, 0, labelWidth, labelHeight);
			this.graphics.endFill();
			labelText.text = labelname;
			labelText.selectable = false;
			labelText.autoSize = TextFieldAutoSize.CENTER;
			var newFormat:TextFormat = new TextFormat();
            newFormat.size = labelHeight;
			labelText.setTextFormat(newFormat);
			fondSize = labelHeight;
			while(labelText.textWidth > labelWidth){ //be care of infinte loops
				//trace(newFormat.size);
				fondSize = Math.floor(fondSize *0.6);
				newFormat.size = fondSize;
				labelText.setTextFormat(newFormat);
				if(fondSize<10){
					labelText.text = "";
					break;
				}
			}
			labelText.x = .5*labelWidth - .5*labelText.textWidth;
			labelText.y = .5*labelHeight - .5*labelText.textHeight;
			this.addChild(labelText);
		}
	}
	
}
