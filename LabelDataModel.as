package  {
	import flashx.textLayout.elements.ListElement;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	import fl.data.DataProvider;
	import flash.text.*;
	
	public class LabelDataModel extends Sprite{
		
		
		public static var LabelNameLoadingComplete:String = "LabelNameLoadingComplete";
		public static var LabelDataLoadingComplete:String = "LabelDataLoadingComplete";
		public static var LabelDataInsertComplete:String = "LabelDataInsertComplete";
		public static var LabelDataDeleteComplete:String = "LabelDataDeleteComplete";
		public static var LabelDataUpdateComplete:String = "LabelDataUpdateComplete";
		
		//private variables
		private var numLabels			:int;
		private var videoID				:int;
		private var userID				:int;
		private var labelName			:Array;
		private var labelNameData		:DataProvider;
		private var labelData			:DataProvider;
		
		private var labelNamePath		:String;
		private var labelDataPath		:String;
		private var insertLabelPath		:String;
		private var deleteLabelPath		:String;
		private var updateLabelPath		:String;
		
		private var loader1				:URLLoader;
		private var loader2				:URLLoader;
		private var xmlData				:XML;
		private var isLabelNameLoaded 	:Boolean;
		private var isLabelDataLoaded 	:Boolean;
		
		
		private var currentLabelName	:int;
		private var currentStartTime	:Number;
		private var currentEndTime		:Number;
		private var	prevStartTime		:Number;
		private var prevEndTime			:Number;
		
		private var insertStartTime		:Number;
		private var insertEndTime 		:Number;
		private var insertLabelName		:String;
		private var insertLabelID		:int;
		
		private var deleteN				:int;
		private var deleteStartTime		:Number;
		private var deleteEndTime 		:Number;
		private var deleteLabelName		:String;
		private var deleteLabelID		:int;
		
		private var updateN				:int;
		private var	updateLabelName		:String;
		private var updateStartTime		:Number;
		private var updateEndTime		:Number;
		private var updateLabelID		:int;
		public function get numlabels():int{
			return numLabels;
		}
		
		public function get videoid():int{
			return videoID;
		}
		
		public function get labelname():Array{
			return labelName;
		}
		
		public function get labeldata():DataProvider{
			return labelData;
		}
		
		public function get labelnamedata():DataProvider{
			return labelNameData;
		}
		
		public function LabelDataModel(v:int, u:int) {
			isLabelNameLoaded = false;
			isLabelDataLoaded = false;
			labelDataPath = "getlabellist.php";
			labelNamePath = "getlabelname.php";
			insertLabelPath = "insertlabel.php";
			deleteLabelPath = "deletelabel.php";
			updateLabelPath = "updatelabel.php";
			videoID = v;
			userID = u;
			trace(userID);
			labelData = new DataProvider();
			labelNameData = new DataProvider();
			labelName = new Array();
			loadLabelName();
			
			this.addEventListener(LabelDataModel.LabelDataInsertComplete, loadLabel);
			this.addEventListener(LabelDataModel.LabelDataDeleteComplete, loadLabel);
			this.addEventListener(LabelDataModel.LabelDataUpdateComplete, loadLabel);
		}
		
		public function loadData(){
			var sendVariables:URLVariables = new URLVariables();
			sendVariables.videoID = videoID;
			sendVariables.user_id = userID;
			
			var sendRequest:URLRequest = new URLRequest(labelDataPath);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = sendVariables
			
			loader2 = new URLLoader();
			loader2.addEventListener(Event.COMPLETE,getLabelData);
			loader2.load(sendRequest);
		}
		
		public function  insertLabel(label_name_id:int, video_id:int, st:Number, et:Number){
			
			currentLabelName = labelName[label_name_id-1];
			currentStartTime = st;
			currentEndTime = et;
			var insertVariables:URLVariables = new URLVariables();
			var sendRequest:URLRequest = new URLRequest(insertLabelPath);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = insertVariables;
			
			// Build the varLoader variable
			var insertLoader:URLLoader = new URLLoader;
			insertLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			insertLoader.addEventListener(Event.COMPLETE, insertLabelComplete);
			if(numLabels){
				trace(labelData.getItemAt(numLabels-1));
				insertVariables.label_id = labelData.getItemAt(numLabels-1).Label_ID + 1;
			}else{
				insertVariables.label_id = 1;
			}
			insertVariables.label_name_id = label_name_id;
			insertVariables.video_id = video_id;
			insertVariables.start_time = st;
			insertVariables.end_time = et;
			insertVariables.user_id = userID;
			insertStartTime = st;
			insertEndTime = et;
			insertLabelName = labelName[label_name_id-1];
			insertLabelID = insertVariables.label_id;
			
			// Send the data to the php file
			insertLoader.load(sendRequest);
		}
		
		private function insertLabelComplete(e:Event){
			numLabels++;
			var new_item:Object = {N: numLabels, LabelName: insertLabelName, From: insertStartTime, To: insertEndTime, Label_ID: insertLabelID};
			labelData.addItem(new_item);
			dispatchEvent(new LabelDataModelEvent(LabelDataInsertComplete));
		}
		
		public function deleteLabel(n:int, label_name:String, st:Number, et:Number, video_id:int, label_id:int){
			
			var deleteVariables:URLVariables = new URLVariables();
			//  Build the varSend URL variable
			var sendRequest:URLRequest = new URLRequest(deleteLabelPath);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = deleteVariables;
			// Build the varLoader variable
			var deleteLoader:URLLoader = new URLLoader;
			deleteLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			deleteLoader.addEventListener(Event.COMPLETE, deleteLabelComplete);
		
			deleteVariables.label_id = label_id;
			deleteVariables.video_id = video_id;
			
			deleteN = n;
			deleteLabelID = label_id;
			deleteLabelName = label_name;
			deleteStartTime = st;
			deleteEndTime = et;
			// Send the data to the php file
			deleteLoader.load(sendRequest);
		}
		
		public function deleteLabelComplete(e:Event){
			trace("delete complete!");
			numLabels--;
			var index = deleteN-1;
			labelData.removeItemAt(index);
			for(var i:int = index; i<labelData.length; i++){
				var temp_item:Object = labelData.getItemAt(i);
				temp_item.N--;
				labelData.replaceItemAt(temp_item, index);
			}
			dispatchEvent(new LabelDataModelEvent(LabelDataDeleteComplete));
		}
		
		public function updateLabel(n:int, label_name_id:int, video_id:int, st:Number, et:Number, label_id:int){

			// Assign a variable name for our URLVariables object
			var updateVariables:URLVariables = new URLVariables();
			//  Build the varSend URL variable
			var sendRequest:URLRequest = new URLRequest(updateLabelPath);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = updateVariables;
			// Build the varLoader variable
			var updateLoader:URLLoader = new URLLoader;
			updateLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			updateLoader.addEventListener(Event.COMPLETE, updateLabelComplete);
			
			updateVariables.label_id = label_id;
			updateVariables.video_id = video_id;
			updateVariables.label_name_id = label_name_id;
			updateVariables.start_time = st;
			updateVariables.end_time = et;
			
			updateN = n;
			updateLabelName = labelName[label_name_id-1];
			updateStartTime = st;
			updateEndTime = et;
			updateLabelID = label_id;
			
			// Send the data to the php file
			updateLoader.load(sendRequest);
		}
		
		public function updateLabelComplete(e:Event){
			var index:int = updateN -1;
			var update_item:Object = labelData.getItemAt(index);
			//trace(update_item);
			update_item.LabelName = updateLabelName;
			update_item.From = updateStartTime;
			update_item.To = updateEndTime;
			labelData.replaceItemAt(update_item, index);
			dispatchEvent(new LabelDataModelEvent(LabelDataUpdateComplete));
		}
		
		private function loadLabelName():void{
			var sendVariables:URLVariables = new URLVariables();
			var sendRequest:URLRequest = new URLRequest(labelNamePath);
			sendVariables.sendRequest = "get_home_text";
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = sendVariables;
			loader1 = new URLLoader();
			loader1.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader1.addEventListener(Event.COMPLETE,getLabelName);
			loader1.load(sendRequest);
		}
		
		private function getLabelName(event:Event):void{
			var data:URLVariables = event.target.data as URLVariables;
			for(var fieldName:String in data) {
				var index:int = parseInt(fieldName.substr(6));
				labelName[index] = data[fieldName];
				//trace(labelName[index]);
			}
			labelNameData.removeAll();
			for( var i:Number = 0; i<labelname.length; i++){
				labelNameData.addItem({label: labelname[i], labelid: i+1});
			}
			isLabelNameLoaded = true;
			dispatchEvent(new LabelDataModelEvent(LabelNameLoadingComplete));
		}
		
		private function loadLabel(event:Event):void{
			var sendVariables:URLVariables = new URLVariables();
			sendVariables.videoID = videoID;
			//trace('user_id= ' + userID);
			sendVariables.user_id = userID;
			
			var sendRequest:URLRequest = new URLRequest(labelDataPath);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = sendVariables
			
			loader2 = new URLLoader();
			loader2.addEventListener(Event.COMPLETE,getLabelData);
			loader2.load(sendRequest);
		}
		
		private function getLabelData(event:Event):void{
			//read XML data from php file.
			xmlData = new XML(loader2.data);
			var totallength = xmlData.label.length();
			numLabels = totallength;
			labelData.removeAll();
			for (var n:uint = 0; n<totallength; n++)
			{
				var lbn_id:int = xmlData.label[n].label_name_id;
				var st:Number = xmlData.label[n].start_time;
				var et:Number = xmlData.label[n].end_time;
				var lb_id:int = xmlData.label[n].label_id;
				labelData.addItem({N: n+1, LabelName:labelName[lbn_id-1], From: st, To: et, Label_ID: lb_id});
			}
			isLabelDataLoaded = true;
			dispatchEvent(new LabelDataModelEvent(LabelDataLoadingComplete));
		}

	}
	
}
