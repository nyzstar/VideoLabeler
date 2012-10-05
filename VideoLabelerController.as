package  {
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
	
	public class VideoLabelerController {
		
		private var controlBar:ControlBar;
		private var player:FLVPlayback;
		private var labelData:LabelDataModel;
		private var labelList:DataGrid;
		private var videoID:int;
		
		public function VideoLabelerController(vid:int, cb:ControlBar, pl:FLVPlayback, dg:DataGrid) {
			// constructor code
			controlBar = cb;
			player = pl;
			labelList = dg;
			labelData = new LabelDataModel();
			videoID = vid;
			
			
			// read video file.
			

			//initialize labels.
			labelData.addEventListener(LabelDataModel.LabelNameLoadingComplete, labelNameLoadingComplete);
			labelData.addEventListener(LabelDataModel.LabelDataLoadingComplete, labelDataLoadingComplete);
			//player.visible = false;
			

		}
		
		
/*		private function initVideoPlay(){
			//initialize video players.
			player = new FLVPlayback();
			player.x = 10;
			player.y = 120;
			player.width = 550;
			player.height = 400;
			player.seekBarScrubTolerance = 1;
			player.source = "videos/mice1.flv";
			player.autoPlay = true;
		}*/
		
		
		
		private function labelNameLoadingComplete(e:LabelDataModelEvent):void{
			labelData.loadData(videoID);
		}
		
		private function labelDataLoadingComplete(e:LabelDataModelEvent):void{
			/*load data to datagrid*/
			var colN:DataGridColumn = new DataGridColumn("N");
			var colLabelName:DataGridColumn = new DataGridColumn("LabelName");
			var colFrom:DataGridColumn = new DataGridColumn("From");
			var colTo:DataGridColumn = new DataGridColumn("To");
			
			colN.sortOptions = Array.NUMERIC;
			colFrom.sortOptions = Array.NUMERIC;
			colTo.sortOptions = Array.NUMERIC;
			
			labelList.addColumn(colN);
			labelList.addColumn(colLabelName);
			labelList.addColumn(colFrom);
			labelList.addColumn(colTo);
			labelList.dataProvider = labelData.labeldata;
		}

	}
	
}

