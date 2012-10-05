package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.*;
	import flash.text.TextField;
	import fl.controls.ComboBox;
	import flash.events.Event;
	import fl.data.DataProvider;

	public class ControlBar extends Sprite
	{
		//Events
		static public var StartPinMouseDown:String = "StartPinMouseDown";
		static public var EndPinMouseDown:String = "EndPinMouseDown";
		static public var PlayingPinMouseDown:String = "PlayingPinMouseDown";
		static public var StartPinMouseOver:String = "StartPinMouseOver";
		static public var EndPinMouseOver:String = "EndPinMouseOver";
		static public var PlayPauseButtonClicked:String = "PlayPauseButtonClicked";
		static public var PlayPauseButtonMouseOver:String = "PlayPauseButtonMouseOver";
		static public var LabelStartButtonClicked:String = "LabelStartButtonClicked";
		static public var LabelStartButtonMouseOver:String = "LabelStartButtonMouseOver";
		static public var LabelEndButtonClicked:String = "LabelEndButtonClicked";
		static public var LabelEndButtonMouseOver:String = "LabelEndButtonMouseOver";
		static public var InsertButtonClicked:String = "InsertButtonClicked";
		static public var InsertButtonMouseOver:String = "InsertButtonMouseOver";
		static public var DeleteButtonClicked:String = "DeleteButtonClicked";
		static public var DeleteButtonMouseOver:String = "DeleteButtonMouseOver";
		static public var DownloadButtonClicked:String = "DownloadButtonClicked";
		static public var DownloadButtonMouseOver:String = "DownloadButtonMouseOver";
		static public var LabelSelBoxItemChange:String = "LabelSelBoxItemChange";
		
		
		public var timeScales:Array = [0.5, 1, 5, 10, 20, 50,100,200,500,1000,2000];
		private var barWidth:Number;
		private var barHeight:Number;
		private var colorBorder:Number;
		private var colorBack:Number;

		private var scrollBarX:Number;
		private var scrollBarY:Number;
		private var scrollBarWidth:Number;
		private var scrollBarHeight:Number;
		private var scrollBarBackColor:Number;
		private var progressBarX:Number;
		private var progressBarY:Number;
		private var progressBarWidth:Number;
		private var progressBarHeight:Number;
		private var timeBarX:Number;
		private var timeBarY:Number;
		private var timeBarWidth:Number;
		private var timeBarHeight:Number;
		private var timeBarColor:Number;
		private var buttonBarX:Number;
		private var buttonBarY:Number;
		private var buttonBarWidth:Number;
		private var buttonBarHeight:Number;

		private var scrollBar:Sprite;
		private var scrollBrick:Button;
		private var scrollBrickX:Number;
		private var scrollBrickY:Number;
		private var scrollBrickWidth:Number;
		private var scrollBrickHeight:Number;
		private var scrollBrickColor:Number;
		private var scrollBrickOffsetX:Number;
		private var scrollBrickLeftLimit:Number;
		private var scrollBrickRightLimit:Number;

		private var moveScrollBrickLeftButton:Button;
		private var moveScrollBrickRightButton:Button;
		private var moveScrollBrickLeftButtonX:Number;
		private var moveScrollBrickLeftButtonY:Number;
		private var moveScrollBrickRightButtonX:Number;
		private var moveScrollBrickRightButtonY:Number;
		private var scrollButtonWidth:Number;
		private var scrollButtonHeight:Number;
		private var scrollButtonColor:Number;
		private var scrollDistance:Number;
		private var timeBar:Sprite;
		private var timeLineShort:Number;
		private var timeLineLong:Number;
		private var timeBarStartTime:Number;
		private var timeBarEndTime:Number;
		private var timeBarScale:Number;
		private var timeBarBackColor:Number;
		private var maxTimeBarScale:Number;
		private var timeMarker:Array;

		private var buttonBar:Sprite;
		private var buttonBarBackColor:Number;
		private var scaleUpButton:Button;
		private var scaleDownButton:Button;
		private var scaleUpButtonX:Number;
		private var scaleUpButtonY:Number;
		private var scaleDownButtonX:Number;
		private var scaleDownButtonY:Number;
		private var scaleButtonHeight:Number;
		private var scaleButtonWidth:Number;
		private var scaleButtonColor:Number;

		private var labelBar:Sprite;
		private var labelBarBackColor:Number;
		private var labelBarX:Number;
		private var labelBarY:Number;
		private var labelBarWidth:Number;
		private var labelBarHeight:Number;

		private var bufferPercentage:Number;
		private var bufferBar:Sprite;
		private var bufferBarBackColor:Number;
		private var bufferBarX:Number;
		private var bufferBarY:Number;
		private var bufferBarWidth:Number;
		private var bufferBarHeight:Number;
		private var isDisplayBufferBar:Boolean;


		private var playingHeadPin:Sprite;
		private var playingHeadPinX:Number;
		private var playingHeadPinY:Number;

		//private var labelData:Array;// array with each item contains label name, start time, and end time.
		
		private var labelPinDefaultWidth:Number;
		private var labelStartPin:Sprite;
		private var labelStartPinX:Number;
		private var labelStartPinY:Number;
		private var labelStartPinWidth:Number;
		private var labelStartPinHeight:Number;
		private var labelStartPinColor:Number;
		private var isDisplayingStartPin:Boolean;
		private var labelStartPinTime:Number;

		private var labelEndPin:Sprite;
		private var labelEndPinX:Number;
		private var labelEndPinY:Number;
		private var labelEndPinWidth:Number;
		private var labelEndPinHeight:Number;
		private var labelEndPinColor:Number;
		private var isDisplayingEndPin:Boolean;
		private var labelEndPinTime:Number;

		private var labelBlock:LabelBox;
		private var labelBlockX:Number;
		private var labelBlockY:Number;
		private var labelBlockWidth:Number;
		private var labelBlockHeight:Number;
		private var labelBlockColor:Number;
		private var labelBlockLabelName:String;
		private var isDisplayingLabelBlock:Boolean;
		private var labelBlockStartTime:Number;
		private var labelBlockEndTime:Number;
		
		private var playingPinX:Number;
		private var	playingPinY:Number;
		private var	playingPinWidth:Number;
		private var	playingPinHeight:Number;
		private var	playingPinColor:Number;
		private var playingPin:Sprite;
		private var	playingPinTime:Number;
		
		private var playButtonX:Number;
		private var playButtonY:Number;
		private var playButtonWidth:Number;
		private var playButtonHeight:Number;
		private var playButtonColor:Number;
		private var isPlaying:Boolean;
		private var playButton:Button;
		
		private var labelStartButtonX:Number;
		private var labelStartButtonY:Number;
		private var labelStartButtonWidth:Number;
		private var labelStartButtonHeight:Number;
		private var labelStartButtonColor:Number;
		private var labelStartButton:Button;

		private var labelEndButtonX:Number;
		private var labelEndButtonY:Number;
		private var labelEndButtonWidth:Number;
		private var labelEndButtonHeight:Number;
		private var labelEndButtonColor:Number;
		private var labelEndButton:Button;

		private var labelSelBoxX:Number;
		private var labelSelBoxY:Number;
		private var labelSelBoxWidth:Number;
		private var labelSelBoxHeight:Number;
		private var labelSelBox: ComboBox;
		
		private var insertButtonX:Number;
		private var insertButtonY:Number;
		private var insertButtonWidth:Number;
		private var insertButtonHeight:Number;
		private var insertButtonColor:Number;
		private var insertButton:Button;		
		
		private var deleteButtonX:Number;
		private var deleteButtonY:Number;
		private var deleteButtonWidth:Number;
		private var deleteButtonHeight:Number;
		private var deleteButtonColor:Number;
		private var deleteButton:Button;	
		
		private var downloadButtonX:Number;
		private var downloadButtonY:Number;
		private var downloadButtonWidth:Number;
		private var downloadButtonHeight:Number;
		private var downloadButtonColor:Number;
		private var downloadButton:Button;	
		
		private var stopButtonX:Number;
		private var stopButtonY:Number;
		private var stopButtonWidth:Number;
		private var stopButtonHeight:Number;
		private var stopButton:Sprite;
		
		private var totalTime:Number;
		private var playingHeadTime:Number;


		public function ControlBar(w:Number, h:Number, tt:Number, labelnames:DataProvider)
		{
			// constructor code
			//get video player info.
			totalTime = tt;
			//labelData = labels;

			/* Draw bar background */
			colorBack = 0xFFFFFF;
			colorBorder = 0x000000;
			barWidth = w;
			barHeight = h;
			scrollBarX = 0;
			scrollBarY = 0.8 * h;
			scrollBarWidth = w;
			scrollBarHeight = 0.2 * h;
			scrollBarBackColor = 0xCCCCCC;
			timeBarX = 0;
			timeBarY = 0.2 * h;
			timeBarWidth = w;
			timeBarHeight = 0.2 * h;
			timeBarBackColor = 0xCCCCCC;
			buttonBarX = 0;
			buttonBarY = 0;
			buttonBarWidth = w;
			buttonBarHeight = 0.2 * h;
			buttonBarBackColor = 0xFFFFFF;
			labelBarX = 0;
			labelBarY = 0.4 * h;
			labelBarWidth = w;
			labelBarHeight = 0.4 * h;
			labelBarBackColor = 0xFFFFCC;
			drawBack();
			/* End of drawing bar background */
			
			/* Initialize timeBar */
			maxTimeBarScale = totalTime / 5;
			timeBarScale = maxTimeBarScale;
			timeBarStartTime = 0;
			timeBarEndTime = totalTime;
			timeMarker = new Array();
			this.timeBar = new Sprite();
			this.addChild(timeBar);
			timeBar.x = timeBarX,
			timeBar.y = timeBarY;
			timeLineShort = 0.2 * h * 0.2;
			timeLineLong = 0.2 * h * 0.5;
			drawTimeBar();
			/*End of initialize timeBar */
			
			/* Initialize scale bar*/
			buttonBar = new Sprite();
			buttonBar.x = buttonBarX;
			buttonBar.y = buttonBarY;
			this.addChild(buttonBar);
			scaleButtonWidth = 0.2 * h;
			scaleButtonHeight = 0.2 * h;
			scaleUpButtonX = 0;
			scaleUpButtonY = 0;
			scaleDownButtonX = scaleButtonWidth;
			scaleDownButtonY = 0;
			scaleButtonColor = 0x66CCFF;
			scaleUpButton = new Button();
			scaleDownButton = new Button();
			drawScaleUpButton();
			drawScaleDownButton();
			scaleUpButton.x = scaleUpButtonX;
			scaleUpButton.y = scaleUpButtonY;
			scaleDownButton.x = scaleDownButtonX;
			scaleDownButton.y = scaleDownButtonY;
			buttonBar.addChild(scaleUpButton);
			buttonBar.addChild(scaleDownButton);
			scaleUpButton.addEventListener(MouseEvent.CLICK, scaleUp);
			scaleDownButton.addEventListener(MouseEvent.CLICK, scaleDown);
			/*End of initialize scale bar*/
			
			/* Initialize playButton */
			playButtonX = scaleButtonWidth*2;
			playButtonY = 0;
			playButtonWidth = 0.2*h;
			playButtonHeight = 0.2*h;
			playButtonColor = 0x66CCFF;
			isPlaying = false;
			playButton = new Button();
			playButton.x = playButtonX;
			playButton.y = playButtonY;
			buttonBar.addChild(playButton);
			playButton.addEventListener(MouseEvent.MOUSE_OVER, playButtonMouseOver);
			playButton.addEventListener(MouseEvent.CLICK, playButtonClicked);
			drawPlayButton();
			
			/* Initialize label start button */
			labelStartButtonX = scaleButtonWidth*3;
			labelStartButtonY = 0;
			labelStartButtonWidth = 0.2*h;
			labelStartButtonHeight = 0.2*h;
			labelStartButtonColor = 0x66CCFF;
			labelStartButton = new Button();
			labelStartButton.x = labelStartButtonX;
			labelStartButton.y = labelStartButtonY;
			buttonBar.addChild(labelStartButton);
			labelStartButton.addEventListener(MouseEvent.MOUSE_OVER, labelStartButtonMouseOver);
			labelStartButton.addEventListener(MouseEvent.CLICK, labelStartButtonClicked);
			drawLabelStartButton();
			
			/* Initialize label End button */
			labelEndButtonX = scaleButtonWidth*4;
			labelEndButtonY = 0;
			labelEndButtonWidth = 0.2*h;
			labelEndButtonHeight = 0.2*h;
			labelEndButtonColor = 0x66CCFF;
			labelEndButton = new Button();
			labelEndButton.x = labelEndButtonX;
			labelEndButton.y = labelEndButtonY;
			buttonBar.addChild(labelEndButton);
			labelEndButton.addEventListener(MouseEvent.MOUSE_OVER, labelEndButtonMouseOver);
			labelEndButton.addEventListener(MouseEvent.CLICK, labelEndButtonClicked);
			drawLabelEndButton();		
		
			/* Initialize Label Selection Button */
			labelSelBoxX = scaleButtonWidth*5;
			labelSelBoxY = 0;
			labelSelBoxWidth = 0.8*h;
			labelSelBoxHeight = 0.2*h;
			labelSelBox = new ComboBox();
			labelSelBox.x = labelSelBoxX;
			labelSelBox.y = labelSelBoxY;
			labelSelBox.width = labelSelBoxWidth;
			labelSelBox.height = labelSelBoxHeight;
			labelSelBox.dataProvider = labelnames;
			labelSelBox.addEventListener(Event.CHANGE, labelSelBoxItemChange);
			buttonBar.addChild(labelSelBox);
		
			/* Initialize insert Button */
			insertButtonX = scaleButtonWidth*9;
			insertButtonY = 0;
			insertButtonWidth = 0.2*h;
			insertButtonHeight = 0.2*h;
			insertButtonColor = 0x66CCFF;
			insertButton = new Button();
			insertButton.x = insertButtonX;
			insertButton.y = insertButtonY;
			buttonBar.addChild(insertButton);
			insertButton.addEventListener(MouseEvent.MOUSE_OVER, insertButtonMouseOver);
			insertButton.addEventListener(MouseEvent.CLICK, insertButtonClicked);
			drawInsertButton();


			/* Initialize delete Button */
			deleteButtonX = scaleButtonWidth*10;
			deleteButtonY = 0;
			deleteButtonWidth = 0.2*h;
			deleteButtonHeight = 0.2*h;
			deleteButtonColor = 0x66CCFF;
			deleteButton = new Button();
			deleteButton.x = deleteButtonX;
			deleteButton.y = deleteButtonY;
			buttonBar.addChild(deleteButton);
			deleteButton.addEventListener(MouseEvent.MOUSE_OVER, deleteButtonMouseOver);
			deleteButton.addEventListener(MouseEvent.CLICK, deleteButtonClicked);
			drawDeleteButton();
			
			/* Initialize download Button*/
			downloadButtonX = scaleButtonWidth*11;
			downloadButtonY = 0;
			downloadButtonWidth = 0.2*h;
			downloadButtonHeight = 0.2*h;
			downloadButtonColor = 0x66CCFF;
			downloadButton = new Button();
			downloadButton.x = downloadButtonX;
			downloadButton.y = downloadButtonY;
			buttonBar.addChild(downloadButton);
			downloadButton.addEventListener(MouseEvent.MOUSE_OVER, downloadButtonMouseOver);
			downloadButton.addEventListener(MouseEvent.CLICK, downloadButtonClicked);
			drawDownloadButton();
			
			
			
			/* Initialize buffer bar*/
			bufferPercentage = 0;
			bufferBar = new Sprite();
			bufferBarBackColor = 0x00CB00;
			bufferBarX = 1;
			bufferBarY = 0.35 * h;
			bufferBarWidth = 0;
			bufferBarHeight = 0.05 * h;
			isDisplayBufferBar = false;
			this.addChild(bufferBar);
			/* End of initialize buffer bar */

			//label bar
			labelBar = new Sprite();
			labelBar.x = labelBarX;
			labelBar.y = labelBarY;
			this.addChild(labelBar);
			
			labelPinDefaultWidth = 0.01*w;
			labelStartPinX = 0;
			labelStartPinY = 0;
			labelStartPinHeight = 0.4 * h;
			labelStartPinWidth = labelPinDefaultWidth;
			labelStartPinColor = 0x000000;
			labelStartPin = new Sprite();
			isDisplayingStartPin = false;
			labelStartPinTime = 0;
			drawLabelStartPin();
			labelStartPin.addEventListener(MouseEvent.MOUSE_DOWN, labelStartPinMouseDown);
			labelStartPin.addEventListener(MouseEvent.MOUSE_OVER, labelStartPinMouseOver);
			
			labelEndPinX = 0;
			labelEndPinY = 0;
			labelEndPinHeight = 0.4 * h;
			labelEndPinWidth = labelPinDefaultWidth;
			labelEndPinColor = 0x000000;
			labelEndPin = new Sprite();
			isDisplayingEndPin = false;
			labelEndPinTime = 0;
			drawLabelEndPin();
			labelEndPin.addEventListener(MouseEvent.MOUSE_DOWN, labelEndPinMouseDown);
			labelEndPin.addEventListener(MouseEvent.MOUSE_OVER, labelEndPinMouseOver);
			
			labelBlockX = 0;
			labelBlockY = 0;
			labelBlockWidth = 0;
			labelBlockHeight = 0.4*h;
			labelBlockColor = 0xFFFFFF;
			labelBlockLabelName = "";
			labelBlock = new LabelBox(labelBlockWidth, labelBlockHeight, labelBlockColor, labelBlockLabelName);
			isDisplayingLabelBlock = false;
			labelBlockStartTime = 0;
			labelBlockEndTime = 0;
			
			//playing pin
			playingPinX = 0;
			playingPinY = 0.4*h;
			playingPinWidth = 0.02*w;
			playingPinHeight = 0.5*h;
			playingPinColor = 0x00CC00;
			playingPin = new Sprite();
			drawPlayingPin();
			placePlayingPin(0);
			trace(playingPinTime);
			playingPin.addEventListener(MouseEvent.MOUSE_DOWN, playingPinMouseDown);
			
			
			/* Initialize scroll bar */
			scrollBar = new Sprite();
			scrollBar.x = scrollBarX;
			scrollBar.y = scrollBarY;
			this.addChild(scrollBar);
			/*End of initilizing scroll bar*/
			
			/* Initialize scroll button */
			moveScrollBrickLeftButtonX = 0;
			moveScrollBrickLeftButtonY = 0;
			moveScrollBrickRightButtonX = scrollBarWidth - 0.2 * h;
			moveScrollBrickRightButtonY = 0;
			scrollButtonHeight = 0.2 * h;
			scrollButtonWidth = scrollButtonHeight;
			scrollButtonColor = 0xFFFFFF;
			scrollDistance = scrollBarWidth / 10;
			this.moveScrollBrickLeftButton = new Button();
			this.moveScrollBrickRightButton = new Button();
			scrollBar.addChild(moveScrollBrickLeftButton);
			scrollBar.addChild(moveScrollBrickRightButton);
			drawMoveScrollBrickLeftButton();
			drawMoveScrollBrickRightButton();
			moveScrollBrickLeftButton.x = moveScrollBrickLeftButtonX;
			moveScrollBrickLeftButton.y = moveScrollBrickLeftButtonY;
			moveScrollBrickRightButton.x = moveScrollBrickRightButtonX;
			moveScrollBrickRightButton.y = moveScrollBrickRightButtonY;
			moveScrollBrickLeftButton.addEventListener(MouseEvent.CLICK, scrollLeft);
			moveScrollBrickRightButton.addEventListener(MouseEvent.CLICK, scrollRight);
			/* End of initializing the scroll buttons */
			
			/* Initialize construct scroll brick */
			scrollBrickColor = 0xFFFFFF;
			scrollBrickX = scrollButtonWidth;
			scrollBrickY = 0;
			scrollBrickWidth = w - 2 * scrollButtonWidth;
			buttonBarHeight = 0.2 * h;
			scrollBrickLeftLimit = scrollButtonWidth;
			scrollBrickRightLimit = barWidth - scrollButtonWidth;
			this.scrollBrick = new Button();
			scrollBar.addChild(scrollBrick);
			scrollBrick.x = scrollBrickX;
			scrollBrick.y = scrollBrickY;
			drawScrollBrick(true);
			scrollBrick.addEventListener(MouseEvent.MOUSE_DOWN, startScrollBrickDragging);
			/* End of initializing the scroll brick */
			
		}


		/* Public functions */
		public function get barwidth(){
			return barWidth;
		}
		public function get timeBarST(){
			return timeBarStartTime;
		}
		
		public function get timeBarET(){
			return timeBarEndTime;
		}
		
		public function loadLabelNames(d:DataProvider){
			labelSelBox.dataProvider = d;
		}
		public function displayBufferBar(percent:Number)
		{
			isDisplayBufferBar = true;
			updateBufferBar(percent);
		}
		
		public function updateBufferBar(percent:Number){
			bufferPercentage = percent;
			drawBufferBar();
		}
		
		public function hideBufferBar()
		{
			isDisplayBufferBar = false;
			bufferBar.graphics.clear();
		}

		public function placePlayingPin(t:Number):void{
			playingPinTime = t;
			updatePlayingPin();
		}
		
		public function placeStartPin(t:Number)
		{
			labelStartPinTime = t;
			isDisplayingStartPin = true;
			updateLabelBar();
		}
		
		public function placeEndPin(t:Number)
		{
			labelEndPinTime = t;
			isDisplayingEndPin = true;
			updateLabelBar();
		}
		
		public function displayCurrentLabel(st:Number, et:Number, c:Number = 0xFF3300, n:String = "")
		{
			labelBlockStartTime = st;
			labelBlockEndTime = et;
			labelBlockLabelName = n;
			labelBlockColor = c;
			isDisplayingLabelBlock = true;
			updateLabelBar();
		}
		
		public function setCurrentLabel(s:String){
			for(var i:int = 0; i<labelSelBox.length; i++){
				if(labelSelBox.getItemAt(i).label ==s){
					labelSelBox.selectedIndex = i;
				}
			}
		}
		public function getCurrentLabelName():String{
			return labelSelBox.selectedLabel;
		}
		
		public function getCurrentLabelNameID():int{
			return labelSelBox.selectedItem.labelid;
		}
		
		public function hideStartPin()
		{
			isDisplayingStartPin = false;
			updateLabelBar();
		}
		
		public function hideEndPin()
		{
			isDisplayingEndPin = false;
			updateLabelBar();
		}
		
		public function hideCurrentLabel()
		{
			isDisplayingLabelBlock = false;
			updateLabelBar();

		}
		
		public function scaleTo(s:int){
			var preTimeBarScale:Number = timeBarScale;
			setTimeScale(s);
			scrollBrickWidth = scrollBrickWidth / preTimeBarScale * timeBarScale;
			if (Math.round(timeBarScale - maxTimeBarScale))
			{
				if (scrollBrick.x + scrollBrickWidth > scrollBrickRightLimit)
				{
					scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
					scrollBrick.x = scrollBrickX;
				}
				drawScrollBrick(false);
			}
			else
			{
				if (scrollBrick.x + scrollBrickWidth > scrollBrickRightLimit)
				{
					scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
					scrollBrick.x = scrollBrickX;
				}
				drawScrollBrick(true);
			}
			
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
		}
		
		public function moveTimeBarTo(t:Number){
			
			scrollBrickX = t/totalTime * (scrollBrickRightLimit - scrollBrickLeftLimit) + scrollBrickLeftLimit;
			if(scrollBrickX + scrollBrickWidth > scrollBrickRightLimit){
				scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
			}
			
			scrollBrick.x = scrollBrickX;
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
		}
		public function isInDisplayTimeRange(t:Number):Boolean{
			if(t>=timeBarStartTime && t<=timeBarEndTime){
				return true;
			}
			return false;
		}
		
		
		/*Listener dispatcher*/
		public function labelStartPinMouseDown(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(StartPinMouseDown));
		}
		
		public function labelEndPinMouseDown(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(EndPinMouseDown));
		}
		
		public function playingPinMouseDown(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(PlayingPinMouseDown));
		}
		
		public function labelStartPinMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(StartPinMouseOver));
		}
		
		public function labelEndPinMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(EndPinMouseOver));
		}

		public function playButtonMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(PlayPauseButtonMouseOver));
		}
		
		public function playButtonClicked(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(PlayPauseButtonClicked));
			if(!isPlaying){
				isPlaying = true;
				drawPlayButton();
			}else{
				isPlaying = false;
				drawPlayButton();
			}
		}
		
		public function labelStartButtonMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(LabelStartButtonMouseOver));
		}
		
		public function labelStartButtonClicked(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(LabelStartButtonClicked));
		}
		
		public function labelEndButtonMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(LabelEndButtonMouseOver));
		}
		
		public function labelEndButtonClicked(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(LabelEndButtonClicked));
		}
		
		public function insertButtonMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(InsertButtonMouseOver));
		}
		
		public function insertButtonClicked(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(InsertButtonClicked));
		}
		
		public function deleteButtonMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(DeleteButtonMouseOver));
		}
		
		public function deleteButtonClicked(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(DeleteButtonClicked));
		}
		
		public function downloadButtonMouseOver(e:MouseEvent):void{
			dispatchEvent(new ControlBarEvent(DownloadButtonMouseOver));1
		}
		
		public function downloadButtonClicked(e:MouseEvent){
			dispatchEvent(new ControlBarEvent(DownloadButtonClicked));
		}
		
		public function labelSelBoxItemChange(e:Event){
			dispatchEvent(new ControlBarEvent(LabelSelBoxItemChange));
		}
		
		
		

		
		/*Draw the buffer bar*/
		private function drawBufferBar():void
		{
			var currentBufferTime:Number = totalTime * bufferPercentage;
			bufferBar.graphics.clear();
			if (currentBufferTime > timeBarStartTime)
			{
				//bufferBar.graphics.lineStyle(1, colorBorder);
				bufferBar.graphics.beginFill(bufferBarBackColor, 0.5);
				if (currentBufferTime < timeBarEndTime)
				{
					bufferBarWidth = (currentBufferTime - timeBarStartTime) / (timeBarEndTime - timeBarStartTime) * timeBarWidth - 1;
					bufferBar.graphics.drawRect(bufferBarX, bufferBarY, bufferBarWidth, bufferBarHeight);
				}
				else
				{
					bufferBarWidth = timeBarWidth - 1;
					bufferBar.graphics.drawRect(bufferBarX, bufferBarY, bufferBarWidth, bufferBarHeight);
				}
				bufferBar.graphics.endFill();
			}
		}
		
		// Draw Playing Pin
		private function drawPlayingPin(){
			playingPin.graphics.clear();
			playingPin.graphics.lineStyle(1, 0x000000);
			playingPin.graphics.beginFill(playingPinColor, 1);
			playingPin.graphics.lineTo(-playingPinWidth/2, -playingPinHeight*0.2);
			playingPin.graphics.lineTo(playingPinWidth/2, -playingPinHeight*0.2);
			playingPin.graphics.lineTo(0, 0);
			playingPin.graphics.endFill();
			playingPin.graphics.lineTo(0, playingPinHeight*0.8);
		}
			
		
		private function updatePlayingPin(){
			//trace("Timebarleft:" + timeBarStartTime);
			
			if(isInDisplayTimeRange(playingPinTime)){
				if(!this.contains(playingPin)){
					this.addChild(playingPin);
				}
				playingPinX = convertTimeToPosition(playingPinTime);
				playingPin.x = playingPinX;
				playingPin.y = playingPinY;
			}else{
				
				if(this.contains(playingPin)){
					this.removeChild(playingPin);
				}
			}
		}
		

		
		/*Draw Label Bar*/
		private function updateLabelBar()
		{
			//displayLabelBlock
			///trace(isDisplayingLabelBlock);
			//trace(isLabelBlockInDisplayTimeRange());
			if(isDisplayingLabelBlock && isLabelBlockInDisplayTimeRange()){
				//trace("haha");
				if(!labelBar.contains(labelBlock)){
					labelBar.addChild(labelBlock);
				}
				if(labelBlockStartTime<timeBarStartTime){
					labelBlockX = 0;
				}else{
					labelBlockX = convertTimeToPosition(labelBlockStartTime);
				}
				if(labelBlockEndTime > timeBarEndTime){
					labelBlockWidth = timeBarWidth - labelBlockX;
				}else{
					labelBlockWidth = convertTimeToPosition(labelBlockEndTime) - labelBlockX;
				}
				labelBlock.updateLabelBox(labelBlockWidth, labelBlockHeight, labelBlockColor, labelBlockLabelName);
				labelBlock.x = labelBlockX;
				labelBlock.y = labelBlockY;
			}else{
				if(labelBar.contains(labelBlock)){
					labelBar.removeChild(labelBlock);
				}
			}
			
			//display labelStartPin
			if(isDisplayingStartPin && isInDisplayTimeRange(labelStartPinTime)){
				if(!labelBar.contains(labelStartPin)){
					labelBar.addChild(labelStartPin);
				}
				//trace(labelStartPinWidth);
				//trace(labelBlockWidth/2);
				//trace(labelPinDefaultWidth);
				if(!labelBar.contains(labelBlock)){
					labelStartPinWidth = labelPinDefaultWidth;
					drawLabelStartPin();
				}else if(labelStartPinWidth > labelBlockWidth/2){
					labelStartPinWidth = labelBlockWidth/2.1;
					drawLabelStartPin();
				}else if((labelBlockWidth/2 > labelPinDefaultWidth || approxEqual(labelBlockWidth/2, labelPinDefaultWidth))&& (!approxEqual(labelStartPinWidth, labelPinDefaultWidth))){
					labelStartPinWidth = labelPinDefaultWidth;
					drawLabelStartPin();
				}
				
				labelStartPinX = convertTimeToPosition(labelStartPinTime);
				labelStartPin.x = labelStartPinX;
				labelStartPin.y = labelStartPinY;
			}else{
				if(labelBar.contains(labelStartPin)){
					labelBar.removeChild(labelStartPin);
				}
			}
			//display labelEndPin
			if(isDisplayingEndPin && isInDisplayTimeRange(labelEndPinTime)){
				if(!labelBar.contains(labelEndPin)){
					labelBar.addChild(labelEndPin);
				}
				
				if(!labelBar.contains(labelBlock)){
					labelEndPinWidth = labelPinDefaultWidth;
					drawLabelEndPin();
				}else if(labelEndPinWidth > labelBlockWidth/2){
					labelEndPinWidth = labelBlockWidth/2.1;
					drawLabelEndPin();
				}else if((labelBlockWidth/2 > labelPinDefaultWidth || approxEqual(labelBlockWidth/2, labelPinDefaultWidth)) && (!approxEqual(labelEndPinWidth, labelPinDefaultWidth))){
					labelEndPinWidth = labelPinDefaultWidth;
					drawLabelEndPin();
				}
				
				labelEndPinX = convertTimeToPosition(labelEndPinTime);
				labelEndPin.x = labelEndPinX;
				labelEndPin.y = labelEndPinY;
			}else{
				if(labelBar.contains(labelEndPin)){
					labelBar.removeChild(labelEndPin);
				}
			}
		}
		
		private function approxEqual(a:Number, b:Number):Boolean{
			if(Math.abs(a-b) < 0.01){
				return true;
			}
			return false;
		}
		
		private function isLabelBlockInDisplayTimeRange():Boolean
		{
			if(labelBlockStartTime >= timeBarStartTime && labelBlockStartTime <= timeBarEndTime){
				return true;
			}
			if(labelBlockEndTime <= timeBarEndTime && labelBlockEndTime >= timeBarStartTime){
				return true;
			}
			if(labelBlockEndTime >= timeBarEndTime && labelBlockStartTime <= timeBarStartTime){
				return true;
			}
			return false;
		}
		

		
		private function convertTimeToPosition(t:Number):Number{
			return (t - timeBarStartTime) / (timeBarEndTime - timeBarStartTime) * timeBarWidth;
		}

		
		
		private function scaleUp(e:MouseEvent)
		{
			var preTimeBarScale:Number = timeBarScale;
			getNextTimeScale(false);
			//trace("timeBarScale: " + timeBarScale);
			scrollBrickWidth = scrollBrickWidth / preTimeBarScale * timeBarScale;
			if (Math.round(timeBarScale - maxTimeBarScale))
			{
				if (scrollBrick.x + scrollBrickWidth > scrollBrickRightLimit)
				{
					scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
					scrollBrick.x = scrollBrickX;
				}
				drawScrollBrick(false);
			}
			else
			{
				if (scrollBrick.x + scrollBrickWidth > scrollBrickRightLimit)
				{
					scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
					scrollBrick.x = scrollBrickX;
				}
				drawScrollBrick(true);
			}
			
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
		}

		private function scaleDown(e:MouseEvent)
		{
			var preTimeBarScale:Number = timeBarScale;
			getNextTimeScale(true);
			//trace("timeBarScale: " + timeBarScale);
			scrollBrickWidth = scrollBrickWidth / preTimeBarScale * timeBarScale;
			if (Math.round(timeBarScale - maxTimeBarScale))
			{
				if (scrollBrick.x + scrollBrickWidth > scrollBrickRightLimit)
				{
					scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
					scrollBrick.x = scrollBrickX;
				}
				drawScrollBrick(false);
			}
			else
			{
				if (scrollBrick.x + scrollBrickWidth > scrollBrickRightLimit)
				{
					scrollBrickX = scrollBrickRightLimit - scrollBrickWidth;
					scrollBrick.x = scrollBrickX;
				}
				drawScrollBrick(true);
			}
			
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
		}
		/* Time Bar implementation */
		private function drawTimeBar()
		{

			var t:TextField;
			while (timeMarker.length)
			{
				t = timeMarker.pop();
				timeBar.removeChild(t);
			}
			timeBar.graphics.clear();
			timeBar.graphics.lineStyle(1, colorBorder);

			var timeBarScale10 = timeBarScale / 10;
			var idx_s:int = Math.ceil(timeBarStartTime/timeBarScale10);
			var offsetT1:Number = idx_s * timeBarScale10 - timeBarStartTime;
			var idx_e:int = Math.floor(timeBarEndTime/timeBarScale10);
			var offsetT2:Number = timeBarEndTime - idx_e * timeBarScale10;

			var spaceSmall:Number = timeBarWidth/(idx_e - idx_s + offsetT1/timeBarScale10 + offsetT2/timeBarScale10);
			var offsetX1:Number = spaceSmall * offsetT1 / timeBarScale10;
			var offsetX2:Number = spaceSmall * offsetT2 / timeBarScale10;

			var count:int = 0;
			for (var i:int = 0; i<=idx_e-idx_s; i++)
			{
				timeBar.graphics.moveTo(i*spaceSmall+offsetX1, timeBarHeight);
				if ((i+idx_s)%10)
				{
					timeBar.graphics.lineTo(i*spaceSmall+offsetX1, timeBarHeight - timeLineShort);
				}
				else
				{
					timeBar.graphics.lineTo(i*spaceSmall+offsetX1, timeBarHeight - timeLineLong);
					var timeMark:Number = (idx_s + i) * timeBarScale10;
					timeMarker[count] = new TextField  ;
					timeMarker[count].text = formatTime(timeMark);
					timeMarker[count].selectable = false;
					timeMarker[count].x = i * spaceSmall + offsetX1;
					timeMarker[count].y = 0;
					timeBar.addChild(timeMarker[count]);
					count++;
				}
			}
		}

		private function formatTime(t:Number):String
		{
			var subsecond:String = Math.round(t*100)%100>=10 ? String(Math.round(t*100)%100): "0" + String(Math.round(t*100)%100);
			var second:String = Math.floor(t) % 60 >= 10 ? String(Math.floor(t) % 60):"0" + String(Math.floor(t) % 60);
			var minute:String = Math.floor(t/60) > 10 ? String(Math.floor(t/60)): "0" + String(Math.floor(t/60));
			return minute + ":" + second + ":" + subsecond;
		}

		/* The function gets the next scale during scaling. Smaller = 1, scales down. Smaller = 0, scales up.*/
		private function getNextTimeScale(smaller:Boolean)
		{
			for (var i:int = 1; i< timeScales.length; i++)
			{
				if (timeBarScale < timeScales[i])
				{
					if (smaller)
					{
						if(timeBarScale == timeScales[i-1] && timeBarScale!=timeScales[0]){
							timeBarScale = timeScales[i-2];
						}else{
							timeBarScale = timeScales[i - 1];
						}
					}
					else if (timeScales[i] < maxTimeBarScale) //larger
					{
						//trace("timeScale: "+timeBarScale + " " + timeScales[i+1]);
						timeBarScale = timeScales[i];
					}
					else
					{
						timeBarScale = maxTimeBarScale;
					}
					return;
				}
			}
			if (smaller)
			{
				timeBarScale = timeScales[timeScales.length - 1];
			}
		}

		/* The function set time scale*/
		private function setTimeScale(s:int)
		{
			if(s>maxTimeBarScale){
				s = maxTimeBarScale;
			}else if(s<timeScales[0]){
				s = timeScales[0];
			}
			timeBarScale = s;
		}


		private function scrollLeft(e:MouseEvent)
		{
			var space:Number = Math.min(scrollBrickWidth/4, scrollDistance);
			scrollBrickX = scrollLimit(scrollBrickX - space);
			scrollBrick.x = scrollBrickX;
			
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
			e.updateAfterEvent();
		}

		private function scrollRight(e:MouseEvent)
		{
			var space:Number = Math.min(scrollBrickWidth/4, scrollDistance);
			scrollBrickX = scrollLimit(scrollBrickX + space);
			scrollBrick.x = scrollBrickX;
			
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
			e.updateAfterEvent();
		}



		private function startScrollBrickDragging(e:MouseEvent):void
		{
			scrollBrickOffsetX = this.mouseX - scrollBrickX;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateScrollBrickDragging);
			//stage.addEventListener(MouseEvent.ROLL_OUT, stopScrollBrickDragging);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopScrollBrickDragging);
		}

		private function updateScrollBrickDragging(e:MouseEvent):void
		{
			scrollBrickX = scrollLimit(this.mouseX - scrollBrickOffsetX);
			scrollBrick.x = scrollBrickX;
			
			//update label bar, time bar and buffer bar.
			updateTimeBar();
			updateLabelBar();
			updatePlayingPin();
			if (isDisplayBufferBar)
			{
				drawBufferBar();
			}
			e.updateAfterEvent();
		}

		private function stopScrollBrickDragging(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateScrollBrickDragging);
			//stage.removeEventListener(MouseEvent.ROLL_OUT, stopScrollBrickDragging);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopScrollBrickDragging);
		}
		private function scrollLimit(a:Number):Number
		{
			if (a<scrollBarX + scrollButtonWidth)
			{
				return scrollBarX + scrollButtonWidth;
			}
			else if (a > (scrollBarX + scrollBarWidth - scrollButtonWidth - scrollBrickWidth))
			{
				return (scrollBarX + scrollBarWidth - scrollButtonWidth- scrollBrickWidth);
			}
			else
			{

			}
			return a;
		}

		private function updateTimeBar()
		{
			var percent1:Number = (scrollBrickX - scrollBrickLeftLimit) / (scrollBrickRightLimit - scrollBrickLeftLimit);
			var percent2:Number = (scrollBrickX + scrollBrickWidth - scrollBrickLeftLimit)/(scrollBrickRightLimit - scrollBrickLeftLimit);
			timeBarStartTime = percent1 * totalTime;
			//trace(timeBarStartTime);
			timeBarEndTime = percent2 * totalTime;
			//trace(timeBarEndTime);
			drawTimeBar();
		}
		
		
		/************************************************************************************/
		/************************************************************************************/
		/*************************drawing functions******************************************/
		/************************************************************************************/
		/************************************************************************************/
		/************************************************************************************/
		private function drawBack()
		{
			this.graphics.clear();
			this.graphics.lineStyle(1, colorBorder);
			this.graphics.beginFill(colorBack);
			this.graphics.drawRect(0, 0, barWidth, barHeight);
			this.graphics.endFill();

			//scrollbar background;
			this.graphics.lineStyle(1, colorBorder);
			this.graphics.beginFill(scrollBarBackColor);
			this.graphics.drawRect(scrollBarX, scrollBarY, scrollBarWidth, scrollBarHeight);
			this.graphics.endFill();

			//timebar background;
			this.graphics.lineStyle(1, colorBorder);
			this.graphics.beginFill(timeBarBackColor, 0.5);
			this.graphics.drawRect(timeBarX, timeBarY, timeBarWidth, timeBarHeight);
			this.graphics.endFill();

			//scale bar background;
			this.graphics.lineStyle(1, colorBorder);
			this.graphics.beginFill(buttonBarBackColor);
			this.graphics.drawRect(buttonBarX, buttonBarY, buttonBarWidth, buttonBarHeight);
			this.graphics.endFill();

			//label bar background;
			this.graphics.lineStyle(1, colorBorder);
			this.graphics.beginFill(labelBarBackColor);
			this.graphics.drawRect(labelBarX, labelBarY, labelBarWidth, labelBarHeight);
			this.graphics.endFill();
		}

		private function drawLabelStartPin()
		{
			labelStartPin.graphics.clear();
			labelStartPin.graphics.lineStyle(2, labelStartPinColor);
			labelStartPin.graphics.moveTo(labelStartPinWidth, -1);
			labelStartPin.graphics.lineTo(0, -1);
			labelStartPin.graphics.lineTo(0, labelStartPinHeight);
			labelStartPin.graphics.lineTo(labelStartPinWidth, labelStartPinHeight);
			labelStartPin.graphics.lineStyle(1, 0, 0);
			labelStartPin.graphics.beginFill(0x000000, 0);
			labelStartPin.graphics.drawRect(0, 0, labelStartPinWidth, labelStartPinHeight);
			labelStartPin.graphics.endFill();
		}
		
		private function drawLabelEndPin()
		{
			labelEndPin.graphics.clear();
			labelEndPin.graphics.lineStyle(2, labelEndPinColor);
			labelEndPin.graphics.moveTo(-labelEndPinWidth, -1);
			labelEndPin.graphics.lineTo(0, -1);
			labelEndPin.graphics.lineTo(0, labelEndPinHeight);
			labelEndPin.graphics.lineTo(-labelEndPinWidth, labelEndPinHeight);			
			labelEndPin.graphics.lineStyle(1, 0, 0);
			labelEndPin.graphics.beginFill(0x000000, 0);
			labelEndPin.graphics.drawRect(0, 0, -labelEndPinWidth, labelEndPinHeight);
			labelEndPin.graphics.endFill();
		}
		
		/* Scroll Brick is a sprite. we can move it to the left and right with in the range*/
		private function drawScrollBrick(cl:Boolean)
		{
			scrollBrick.graphics.clear();
			if (cl == false)
			{
				scrollBrick.graphics.lineStyle(1, colorBorder);
				scrollBrick.graphics.beginFill(scrollBrickColor);
				scrollBrick.graphics.drawRect(0, 0, scrollBrickWidth, buttonBarHeight);
				scrollBrick.graphics.endFill();
				scrollBrick.filters = [new BevelFilter(1)];
			}
		}
		
		/* two move-scroll-brick buttons implementation*/
		private function drawMoveScrollBrickLeftButton()
		{
			moveScrollBrickLeftButton.graphics.clear();
			moveScrollBrickLeftButton.graphics.lineStyle(1,colorBorder);
			moveScrollBrickLeftButton.graphics.beginFill(scrollButtonColor);
			moveScrollBrickLeftButton.graphics.drawRect(0, 0, scrollButtonWidth, scrollButtonHeight);
			moveScrollBrickLeftButton.graphics.endFill();
			moveScrollBrickLeftButton.graphics.beginFill(scrollButtonColor);
			moveScrollBrickLeftButton.graphics.moveTo(scrollButtonWidth*7/8, scrollButtonHeight/8);
			moveScrollBrickLeftButton.graphics.lineTo(scrollButtonWidth/8, scrollButtonHeight/2);
			moveScrollBrickLeftButton.graphics.lineTo(scrollButtonWidth*7/8, scrollButtonHeight*7/8);
			moveScrollBrickLeftButton.graphics.lineTo(scrollButtonWidth*7/8, scrollButtonHeight/8);
			moveScrollBrickLeftButton.graphics.endFill();
		}

		private function drawMoveScrollBrickRightButton()
		{
			moveScrollBrickRightButton.graphics.clear();
			moveScrollBrickRightButton.graphics.lineStyle(1,colorBorder);
			moveScrollBrickRightButton.graphics.beginFill(scrollButtonColor);
			moveScrollBrickRightButton.graphics.drawRect(0, 0, scrollButtonWidth, scrollButtonHeight);
			moveScrollBrickRightButton.graphics.endFill();
			moveScrollBrickRightButton.graphics.beginFill(scrollButtonColor);
			moveScrollBrickRightButton.graphics.moveTo(scrollButtonWidth/8, scrollButtonHeight/8);
			moveScrollBrickRightButton.graphics.lineTo(scrollButtonWidth*7/8, scrollButtonHeight/2);
			moveScrollBrickRightButton.graphics.lineTo(scrollButtonWidth/8, scrollButtonHeight*7/8);
			moveScrollBrickRightButton.graphics.lineTo(scrollButtonWidth/8, scrollButtonHeight/8);
			moveScrollBrickRightButton.graphics.endFill();
		}
		
		/* Scale bar and scale Button Implementation */
		private function drawScaleUpButton()
		{
			scaleUpButton.graphics.clear();
			scaleUpButton.graphics.lineStyle(1, colorBorder);
			scaleUpButton.graphics.drawRect(0, 0, scaleButtonWidth, scaleButtonHeight);
			scaleUpButton.graphics.beginFill(scaleButtonColor);
			scaleUpButton.graphics.drawCircle(0.5*scaleButtonWidth, 0.5*scaleButtonHeight, 0.4*Math.min(scaleButtonWidth, scaleButtonHeight));
			scaleUpButton.graphics.endFill();
			scaleUpButton.graphics.moveTo(0.2*scaleButtonWidth, 0.5*scaleButtonHeight);
			scaleUpButton.graphics.lineTo(0.8*scaleButtonWidth, 0.5*scaleButtonHeight);
		}

		private function drawScaleDownButton()
		{
			scaleDownButton.graphics.clear();
			scaleDownButton.graphics.lineStyle(1, colorBorder);
			scaleDownButton.graphics.drawRect(0, 0, scaleButtonWidth, scaleButtonHeight);
			scaleDownButton.graphics.beginFill(scaleButtonColor);
			scaleDownButton.graphics.drawCircle(0.5*scaleButtonWidth, 0.5*scaleButtonHeight, 0.4*Math.min(scaleButtonWidth, scaleButtonHeight));
			scaleDownButton.graphics.endFill();
			scaleDownButton.graphics.moveTo(0.2*scaleButtonWidth, 0.5*scaleButtonHeight);
			scaleDownButton.graphics.lineTo(0.8*scaleButtonWidth, 0.5*scaleButtonHeight);
			scaleDownButton.graphics.moveTo(0.5*scaleButtonWidth, 0.2*scaleButtonHeight);
			scaleDownButton.graphics.lineTo(0.5*scaleButtonWidth, 0.8*scaleButtonHeight);
		}
		
		private function drawPlayButton(){
			if(!isPlaying){
				playButton.graphics.clear();
				playButton.graphics.lineStyle(1, colorBorder);
				playButton.graphics.beginFill(buttonBarBackColor);
				playButton.graphics.drawRect(0, 0, playButtonWidth, playButtonHeight);
				playButton.graphics.endFill();
				playButton.graphics.beginFill(playButtonColor);
				playButton.graphics.moveTo(0.1*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.lineTo(0.9*playButtonWidth, 0.5*playButtonHeight);
				playButton.graphics.lineTo(0.1*playButtonWidth, 0.9*playButtonHeight);
				playButton.graphics.lineTo(0.1*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.endFill();
			}else{
				playButton.graphics.clear();
				playButton.graphics.lineStyle(1, colorBorder);
				playButton.graphics.beginFill(buttonBarBackColor);
				playButton.graphics.drawRect(0, 0, playButtonWidth, playButtonHeight);
				playButton.graphics.endFill();
				playButton.graphics.beginFill(playButtonColor);
				playButton.graphics.moveTo(0.1*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.lineTo(0.4*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.lineTo(0.4*playButtonWidth, 0.9*playButtonHeight);
				playButton.graphics.lineTo(0.1*playButtonWidth, 0.9*playButtonHeight);
				playButton.graphics.lineTo(0.1*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.endFill();
				playButton.graphics.beginFill(playButtonColor);
				playButton.graphics.moveTo(0.6*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.lineTo(0.9*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.lineTo(0.9*playButtonWidth, 0.9*playButtonHeight);
				playButton.graphics.lineTo(0.6*playButtonWidth, 0.9*playButtonHeight);
				playButton.graphics.lineTo(0.6*playButtonWidth, 0.1*playButtonHeight);
				playButton.graphics.endFill();
			}
		}
		
		private function drawLabelStartButton(){
			labelStartButton.graphics.clear();
			labelStartButton.graphics.lineStyle(1, colorBorder);
			labelStartButton.graphics.beginFill(buttonBarBackColor);
			labelStartButton.graphics.drawRect(0, 0, labelStartButtonWidth, labelStartButtonHeight);
			labelStartButton.graphics.endFill();
			labelStartButton.graphics.beginFill(labelStartButtonColor);
			labelStartButton.graphics.moveTo(0.9*labelStartButtonWidth, 0.1*labelStartButtonHeight);
			labelStartButton.graphics.lineTo(0.1*labelStartButtonWidth, 0.1*labelStartButtonHeight);
			labelStartButton.graphics.lineTo(0.1*labelStartButtonWidth, 0.9*labelStartButtonHeight);
			labelStartButton.graphics.lineTo(0.9*labelStartButtonWidth, 0.9*labelStartButtonHeight);
			labelStartButton.graphics.lineTo(0.5*labelStartButtonWidth, 0.5*labelStartButtonHeight);
			labelStartButton.graphics.lineTo(0.9*labelStartButtonWidth, 0.1*labelStartButtonHeight);
			labelStartButton.graphics.endFill();
		}
		
		private function drawLabelEndButton(){
			labelEndButton.graphics.clear();
			labelEndButton.graphics.lineStyle(1, colorBorder);
			labelEndButton.graphics.beginFill(buttonBarBackColor);
			labelEndButton.graphics.drawRect(0, 0, labelEndButtonWidth, labelEndButtonHeight);
			labelEndButton.graphics.endFill();
			labelEndButton.graphics.beginFill(labelEndButtonColor);
			labelEndButton.graphics.moveTo(0.1*labelEndButtonWidth, 0.1*labelEndButtonHeight);
			labelEndButton.graphics.lineTo(0.9*labelEndButtonWidth, 0.1*labelEndButtonHeight);
			labelEndButton.graphics.lineTo(0.9*labelEndButtonWidth, 0.9*labelEndButtonHeight);
			labelEndButton.graphics.lineTo(0.1*labelEndButtonWidth, 0.9*labelEndButtonHeight);
			labelEndButton.graphics.lineTo(0.5*labelEndButtonWidth, 0.5*labelEndButtonHeight);
			labelEndButton.graphics.lineTo(0.1*labelEndButtonWidth, 0.1*labelEndButtonHeight);
			labelEndButton.graphics.endFill();
		}
		
		private function drawInsertButton(){
			insertButton.graphics.clear();
			insertButton.graphics.lineStyle(1, colorBorder);
			insertButton.graphics.beginFill(buttonBarBackColor);
			insertButton.graphics.drawRect(0, 0, insertButtonWidth, insertButtonHeight);
			insertButton.graphics.endFill();
			insertButton.graphics.beginFill(insertButtonColor);
			insertButton.graphics.moveTo(0.1*insertButtonWidth, 0.5*insertButtonHeight);
			insertButton.graphics.lineTo(0.2*insertButtonWidth, 0.3*insertButtonHeight);
			insertButton.graphics.lineTo(0.5*insertButtonWidth, 0.5*insertButtonHeight);
			insertButton.graphics.lineTo(0.9*insertButtonWidth, 0.1*insertButtonHeight);
			insertButton.graphics.lineTo(0.5*insertButtonWidth, 0.9*insertButtonHeight);
			insertButton.graphics.endFill();
		}
		
		
		private function drawDeleteButton(){
			deleteButton.graphics.clear();
			deleteButton.graphics.lineStyle(1, colorBorder);
			deleteButton.graphics.beginFill(buttonBarBackColor);
			deleteButton.graphics.drawRect(0, 0, deleteButtonWidth, deleteButtonHeight);
			deleteButton.graphics.endFill();
			deleteButton.graphics.beginFill(deleteButtonColor);
			deleteButton.graphics.moveTo(0.1*deleteButtonWidth, 0.3*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.3*deleteButtonWidth, 0.1*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.5*deleteButtonWidth, 0.3*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.7*deleteButtonWidth, 0.1*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.9*deleteButtonWidth, 0.3*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.7*deleteButtonWidth, 0.5*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.9*deleteButtonWidth, 0.7*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.7*deleteButtonWidth, 0.9*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.5*deleteButtonWidth, 0.7*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.3*deleteButtonWidth, 0.9*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.1*deleteButtonWidth, 0.7*deleteButtonHeight);
			deleteButton.graphics.lineTo(0.3*deleteButtonWidth, 0.5*deleteButtonHeight);
			deleteButton.graphics.endFill();
		}
		
		private function drawDownloadButton(){
			downloadButton.graphics.clear();
			downloadButton.graphics.lineStyle(1, colorBorder);
			downloadButton.graphics.beginFill(buttonBarBackColor);
			downloadButton.graphics.drawRect(0, 0, downloadButtonWidth, downloadButtonHeight);
			downloadButton.graphics.endFill();
			downloadButton.graphics.beginFill(downloadButtonColor);
			downloadButton.graphics.moveTo(0.3*downloadButtonWidth, 0.1*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.7*downloadButtonWidth, 0.1*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.7*downloadButtonWidth, 0.5*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.9*downloadButtonWidth, 0.5*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.5*downloadButtonWidth, 0.9*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.1*downloadButtonWidth, 0.5*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.3*downloadButtonWidth, 0.5*downloadButtonHeight);
			downloadButton.graphics.lineTo(0.3*downloadButtonWidth, 0.1*downloadButtonHeight);
			downloadButton.graphics.endFill();
		}
		

	}

}


