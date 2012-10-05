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
	
	public class LabelDataLoader extends Sprite{
		public static var LabelNameLoadingComplete:String = "LabelNameLoadingComplete";
		public static var LabelDataLoadingComplete:String = "LabelDataLoadingComplete";
		private var videoID			:int;
		private var labelName		:Array;
		private var labelNameData	:DataProvider;
		private var labelData		:DataProvider;
		//loader
		private var labelNamePath	:String;
		private var labelDataPath	:String;
		private var loader1			:URLLoader;
		private var loader2			:URLLoader;
		private var xmlData			:XML;
		private var isLabelNameLoaded :Boolean;
		
		
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
		
		public function LabelDataLoader(dpl:String = "getlabellist.php", dpln: String = "getlabelname.php") {
			isLabelNameLoaded = false;
			labelDataPath = dpl;
			labelNamePath = dpln;
			videoID = 0;
			labelData = new DataProvider();
			labelNameData = new DataProvider();
			labelName = new Array();
			loadLabelName();
		}
		
		public function loadData(v:int){
			videoID = v;
			loadLabel();
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
			}
			labelNameData.removeAll();
			for( var i:Number = 0; i<labelname.length; i++){
				labelNameData.addItem({label: labelname[i], labelid: i+1});
			}
			isLabelNameLoaded = true;
			dispatchEvent(new LabelDataLoaderEvent(LabelNameLoadingComplete));
		}
		
		private function loadLabel():void{
			var sendVariables:URLVariables = new URLVariables();
			sendVariables.videoID = videoID;
			
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
			labelData.removeAll();
			for (var n:uint = 0; n<totallength; n++)
			{
				var lb_id:int = xmlData.label[n].label_id;
				var st:Number = xmlData.label[n].start_time;
				var et:Number = xmlData.label[n].end_time;
				labelData.addItem({N: n+1, LabelName:labelName[lb_id-1], label_id: lb_id, From: st, To: et});
			}
			dispatchEvent(new LabelDataLoaderEvent(LabelDataLoadingComplete));
		}

	}
	
}
