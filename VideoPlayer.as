package 
{
	import fl.video.*;
	import flash.display.Sprite;
	import fl.controls.Label;
	import fl.data.DataProvider;
	import fl.controls.ComboBox;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.text.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	
	public class VideoPlayer extends Sprite
	{
		var vidPlayer:FLVPlayback;
		public function VideoPlayer()
		{
			// constructor code
			vidPlayer = new FLVPlayback();
		}
	}


}