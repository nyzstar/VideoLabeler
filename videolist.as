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
	
	public class videolist extends List{
		
		//loader
		public var dataPath			:String = "getvideolist.php";
		public var loader			:URLLoader;
		public var xmlData			:XML;
		
		
		public function videolist() {

		}
		
		public function loadvideo():void{
			var sendVariables:URLVariables = new URLVariables();
			sendVariables.datarequest = "get_video";
			
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
			var totallength = xmlData.video.length();
			var comboDP:DataProvider = new DataProvider();
			for (var n:uint = 0; n<totallength; n++)
			{
				var v_id:int = xmlData.video[n].video_id;
				var v_name:String = xmlData.video[n].video_name;
				var v_url:String = xmlData.video[n].URL;
				comboDP.addItem({label:v_name, video_id: v_id, url: v_url});
			}
			dataProvider = comboDP;
		}

	}
	
}
