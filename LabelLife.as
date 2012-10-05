package  {
	import flash.display.Sprite;
	import fl.video.*;
	import fl.controls.Label;
	import fl.data.DataProvider;
	import fl.controls.ComboBox;
	import flash.events.*
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.text.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.text.engine.TabAlignment;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;	
	import flash.external.*;
	
	
	public class LabelLife extends Sprite{
		private const CONTROLBAR_WIDTH:int = 1120;
		private const CONTROLBAR_HEIGHT:int = 200;
		private const EDIT:int = 0;
		private const UPDATE:int = 1;
		private var controlBar:ControlBar;
		private var vidPlayer : FLVPlayback;
		private var labelPanel: DataGrid;
		private var labelerBrain: LabelDataModel;
		private var video_id:int;
		private var user_id:int;
		private var currentN:int;
		private var currentLabelName:String;
		private var currentLabelNameID:int;
		private var isPlaying:Boolean;
		private var startPinTime:Number;
		private var startPinTime_old:Number;
		private var endPinTime:Number;
		private var endPinTime_old:Number;
		private var currentLabelID:int;
		private var isStartPinInserted:Boolean;
		private var isEndPinInserted:Boolean;
		private var labelerState:int; 
		private var playingPinTime:Number;
		private var videoURL:String;
		private var videoLength:Number;
		private var videoName:String;
		
		public function LabelLife() {
			readInputs();
			vidPlayer = new FLVPlayback();
			vidPlayer.x = 30;
			vidPlayer.y = 150;
			vidPlayer.width = 660;
			vidPlayer.height = 480;
			vidPlayer.seekBarScrubTolerance = 1;
			vidPlayer.playheadUpdateInterval = 10;
			vidPlayer.source = videoURL;
			vidPlayer.autoPlay = false;
			vidPlayer.play();
			isPlaying = false;
			vidPlayer.pause();
			this.addChild(vidPlayer);
			
			//initialize the datagrid.
			labelPanel = new DataGrid();
			labelPanel.width = 440;
			labelPanel.height = 480;
			labelPanel.x = 720;
			labelPanel.y = 150;
			this.addChild(labelPanel);
			
			var temp:DataProvider = new DataProvider();
			initializeControlBar(videoLength, temp);
			initializeLabelPanel();
			labelerBrain = new LabelDataModel(video_id, user_id);
			initializeEventListener();
			
			//current label
			isStartPinInserted = false;
			isEndPinInserted = false;
			labelerState = EDIT;
		}
		
		private function readInputs():void {
        	var inputs:Object;
			if (ExternalInterface.available) {
			   var wrapperFunction:String = "readInputs";
			   inputs = ExternalInterface.call(wrapperFunction);
			   trace(inputs);
			   user_id = inputs.user_id;
			   video_id = inputs.video_id;
			   videoURL = inputs.video_url;
			   videoLength = inputs.video_length;
			   videoName = inputs.video_name;
			} else {
			   inputs = {};
			}
        	//trace(inputs); 
     	}
		
		
		
		private function initializeLabelPanel():void{
			/*load data to datagrid*/
			var colN:DataGridColumn = new DataGridColumn("N");
			var colLabelName:DataGridColumn = new DataGridColumn("LabelName");
			var colFrom:DataGridColumn = new DataGridColumn("From");
			var colTo:DataGridColumn = new DataGridColumn("To");
			
			colN.sortOptions = Array.NUMERIC;
			colFrom.sortOptions = Array.NUMERIC;
			colTo.sortOptions = Array.NUMERIC;
			
			labelPanel.addColumn(colN);
			labelPanel.addColumn(colLabelName);
			labelPanel.addColumn(colFrom);
			labelPanel.addColumn(colTo);
		}
		
		private function initializeControlBar(t:Number, labelnames:DataProvider):void{
			//initialize controlBar
			controlBar = new ControlBar(CONTROLBAR_WIDTH, CONTROLBAR_HEIGHT, t, labelnames); //Time need to change.
			controlBar.x = 40;
			controlBar.y = 640;
			controlBar.displayBufferBar(0);
			//controlBar.displayCurrentLabel(4, 8, 0xFF3300, "cat");
			//controlBar.placeStartPin(20);
			//controlBar.placeEndPin(22);
			//controlBar.placePlayingPin(0);
			//controlBar.scaleTo(5);
			//controlBar.moveTimeBarTo(10);
			this.addChild(controlBar);			
		}
		private function initializeEventListener():void{
			labelerBrain.addEventListener(LabelDataModel.LabelNameLoadingComplete, labelNameLoadingComplete);
			labelerBrain.addEventListener(LabelDataModel.LabelDataLoadingComplete, labelDataLoadingComplete);			
			labelerBrain.addEventListener(LabelDataModel.LabelDataInsertComplete, labelDataInsertComplete);
			labelerBrain.addEventListener(LabelDataModel.LabelDataUpdateComplete, labelDataUpdateComplete);
			labelerBrain.addEventListener(LabelDataModel.LabelDataDeleteComplete, labelDataDeleteComplete);
			vidPlayer.addEventListener(VideoEvent.PLAYHEAD_UPDATE, updatePlayingPin);
			vidPlayer.addEventListener(VideoProgressEvent.PROGRESS, updateBuffer);
			controlBar.addEventListener(ControlBar.PlayPauseButtonClicked, playOrPauseVideo);
			controlBar.addEventListener(ControlBar.LabelStartButtonClicked, insertLabelStartPin);
			controlBar.addEventListener(ControlBar.LabelEndButtonClicked, insertLabelEndPin);
			controlBar.addEventListener(ControlBar.LabelSelBoxItemChange, selectLabel);
			controlBar.addEventListener(ControlBar.InsertButtonClicked, saveLabel);
			controlBar.addEventListener(ControlBar.DeleteButtonClicked, deleteLabel);
			controlBar.addEventListener(ControlBar.PlayingPinMouseDown, enablePlayingPinDragging);
			labelPanel.addEventListener(Event.CHANGE, getSelectedLabel);
			//controlBar.addEventListener();
		}
		
		private function updateBuffer(e:VideoProgressEvent){
			var percent:int = Math.floor(vidPlayer.bytesLoaded/vidPlayer.bytesTotal*100);
			controlBar.updateBufferBar(percent);
		}
		private function enablePlayingPinDragging(e:ControlBarEvent){
			stage.addEventListener(MouseEvent.MOUSE_UP, disablePlayingPinDragging);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movePlayingPin);
		}
		
		private function disablePlayingPinDragging(e:MouseEvent){
			vidPlayer.seek(playingPinTime);
			stage.removeEventListener(MouseEvent.MOUSE_UP, disablePlayingPinDragging);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePlayingPin);			
		}
		
		private function movePlayingPin(e:MouseEvent){
			if(mouseX>controlBar.x + controlBar.barwidth){
				trace("ET:" +controlBar.timeBarET);
				controlBar.placePlayingPin(controlBar.timeBarET);
				//playingPin.x = controlBar.x + controlBar.width;
			}else if(mouseX<controlBar.x){
				trace("ST:" +controlBar.timeBarST);
				controlBar.placePlayingPin(controlBar.timeBarST);
				//playingPin.x = controlBar.x;
			}else{
				playingPinTime = controlBar.timeBarST + (mouseX - controlBar.x)/controlBar.barwidth*(controlBar.timeBarET - controlBar.timeBarST);
				controlBar.placePlayingPin(playingPinTime);
				//playingPin.x = mouseX;
			}
			if(controlBar.mouseX < -20 || controlBar.mouseX>controlBar.barwidth+20){
				disablePlayingPinDragging(e);
			}
		}
		
		private function labelDataInsertComplete(e:LabelDataModelEvent){
			//var new_item:Object = {N: labelPanel.rowCount + 1, LabelName: currentLabelName, From: startPinTime, To: endPinTime};
			//labelPanel.addItem(new_item);
			//trace("insert");
			//labelerBrain.loadData();
			labelPanel.dataProvider = labelerBrain.labeldata;
		}
		
		private function labelDataUpdateComplete(e:LabelDataModelEvent){
			//trace("update!");
			labelPanel.dataProvider = labelerBrain.labeldata;
		}
		
		private function labelDataDeleteComplete(e:LabelDataModelEvent){
			//trace("Delete!");
			labelPanel.dataProvider = labelerBrain.labeldata;
		}
		
		private function getSelectedLabel(e:Event):void{
			currentN = e.target.selectedItem.N;
			currentLabelName = e.target.selectedItem.LabelName;
			controlBar.setCurrentLabel(currentLabelName);
			startPinTime = e.target.selectedItem.From;
			startPinTime_old = startPinTime;
			controlBar.placeStartPin(startPinTime);
			isStartPinInserted = true;			
			endPinTime = e.target.selectedItem.To;
			endPinTime_old = endPinTime;
			controlBar.placeEndPin(endPinTime);
			isEndPinInserted = true;
			currentLabelID = e.target.selectedItem.Label_ID;
			updateLabelBox();
			controlBar.moveTimeBarTo(startPinTime);
			labelerState = UPDATE;
		}
		
		private function selectLabel(e:ControlBarEvent){
			updateLabelBox();
		}
		
		private function saveLabel(e:ControlBarEvent){
			switch(labelerState){
				case EDIT:
					if(isLabelReady()){
						currentLabelNameID = controlBar.getCurrentLabelNameID();
						labelerBrain.insertLabel(currentLabelNameID, video_id, startPinTime, endPinTime);
						break;
					}
				case UPDATE:
					//trace("update start!");
					currentLabelNameID = controlBar.getCurrentLabelNameID();
					labelerBrain.updateLabel(currentN, currentLabelNameID, video_id, startPinTime, endPinTime, currentLabelID);
					break;
			}
			removeLabel();
			labelerState = EDIT;
			//labelerBrain.loadData();//problem here.
		}
		
		private function isLabelReady():Boolean{
			return isStartPinInserted && isEndPinInserted;
		}
		
		private function deleteLabel(e:ControlBarEvent){
			//trace("DELETE");
			if(labelerState == EDIT){
				removeLabel();
			}else if(labelerState == UPDATE){
				trace("st" + startPinTime_old);
				trace("et" + endPinTime_old);
				labelerBrain.deleteLabel(currentN, currentLabelName, startPinTime, endPinTime, video_id, currentLabelID);
				removeLabel();
				labelerState = EDIT;
			}else{
				trace("unknown State!")
			}
			trace(labelerState);
		}
		
		private function removeLabel(){
			controlBar.hideStartPin();
			controlBar.hideEndPin();
			controlBar.hideCurrentLabel();
			startPinTime = 0;
			startPinTime_old = 0;
			endPinTime = 0;
			endPinTime_old = 0;
			currentLabelID = -1;
			isStartPinInserted = false;
			isEndPinInserted = false;
		}
		private function insertLabelStartPin(e:ControlBarEvent){
			startPinTime = vidPlayer.playheadTime;
			if(isEndPinInserted && (startPinTime>endPinTime)){
				startPinTime = endPinTime;
			}
			controlBar.placeStartPin(startPinTime);
			isStartPinInserted = true;
			updateLabelBox();
		}
		
		private function insertLabelEndPin(e:ControlBarEvent){
			endPinTime = vidPlayer.playheadTime;
			if(isStartPinInserted && (startPinTime>endPinTime)){
				endPinTime = startPinTime;
			}
			controlBar.placeEndPin(endPinTime);
			isEndPinInserted = true;
			updateLabelBox();
		}
		
		private function updateLabelBox(){
			currentLabelName = controlBar.getCurrentLabelName();
			currentLabelNameID = controlBar.getCurrentLabelNameID();
			if(isStartPinInserted && isEndPinInserted && (currentLabelName != null)){
				controlBar.displayCurrentLabel(startPinTime, endPinTime, 0xFF3300, currentLabelName);
			}
		}
		
		private function updatePlayingPin(e:VideoEvent):void{
			//trace(vidPlayer.playheadTime);
			controlBar.placePlayingPin(vidPlayer.playheadTime);
			if(!controlBar.isInDisplayTimeRange(vidPlayer.playheadTime)){
				controlBar.moveTimeBarTo(vidPlayer.playheadTime);
			}
		}
		
		private function playOrPauseVideo(e:ControlBarEvent){
			if(!isPlaying){
				vidPlayer.play();
				isPlaying = true;
			}else{
				vidPlayer.pause();
				isPlaying = false;
			}
		}
		
		
		// labelerBrain initialization.
		private function labelNameLoadingComplete(e:LabelDataModelEvent):void{
			labelerBrain.loadData();
		}
		
		private function labelDataLoadingComplete(e:LabelDataModelEvent):void{
			labelPanel.dataProvider = labelerBrain.labeldata;
			controlBar.loadLabelNames(labelerBrain.labelnamedata);
		}
		
	}
	
}