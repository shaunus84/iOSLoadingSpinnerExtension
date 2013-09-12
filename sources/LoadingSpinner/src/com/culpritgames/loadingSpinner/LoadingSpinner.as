package com.culpritgames.loadingSpinner
{
	import flash.external.ExtensionContext;
	import flash.events.EventDispatcher;

	public class LoadingSpinner extends EventDispatcher
	{
		private var extensionContext:ExtensionContext;
		
		public function LoadingSpinner():void
		{
			extensionContext = ExtensionContext.createExtensionContext("com.tombola.loadingSpinner", "");
			
			if(!extensionContext)
			{
				throw(new Error("context null"));
			}
		}
		
		public function showSpinnerWithLabel(label:String):void
		{
			extensionContext.call("showSpinnerWithLabel", label);
		}
		
		public function hideSpinner():void
		{
			extensionContext.call("hideSpinner");
		}
		
		public function dispose():void
		{
			extensionContext.call("dispose");
			extensionContext = null;
		}
	}
}

