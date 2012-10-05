package  {
	import flashx.textLayout.elements.ListElement;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import fl.controls.List;
	import fl.video.*;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	import fl.data.DataProvider;
	import flash.text.*;
	
	public class labellist extends List{
		public var video_id			:int;
		public var labelname		:Array;
		
		//loader
		public var dataPath			:String = "getlabellist.php";
		public var loader			:URLLoader;
		public var xmlData			:XML;
		
		
		public function labellist() {

		}
		
		public function loadlabel():void{
			var sendVariables:URLVariables = new URLVariables();
			sendVariables.videoID = video_id;
			
			var sendRequest:URLRequest = new URLRequest(dataPath);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = sendVariables
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onDataHandler);
			loader.load(sendRequest);
		}
		
		protected function onDataHandler(event:Event):void{
			//read XML data from php file.
			xmlData = new XML(loader.data);
			var totallength = xmlData.label.length();
			var comboDP:DataProvider = new DataProvider();
			for (var n:uint = 0; n<totallength; n++)
			{
				var lb_id:int = xmlData.label[n].label_id;
				var st:Number = xmlData.label[n].start_time;
				var et:Number = xmlData.label[n].end_time;
				comboDP.addItem({label:labelname[lb_id-1], label_id: lb_id, start_time: st, end_time: et});
			}
			dataProvider = comboDP;
		}

	}
	
}
