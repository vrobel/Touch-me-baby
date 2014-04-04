package touch.me.baby.input
{
import flash.display.Sprite;
import flash.events.TouchEvent;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

import touch.me.baby.vo.Finger;

public class TouchInputProvider extends BasePointerInputProvider
{
	public function TouchInputProvider( view : Sprite ) {
		trace("Initializing TouchInputProvider")
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		view.addEventListener( TouchEvent.TOUCH_BEGIN, onTouchBegin );
		view.addEventListener( TouchEvent.TOUCH_MOVE, onTouchMove );
		view.addEventListener( TouchEvent.TOUCH_END, onTouchEnd );
	}

	private function onTouchBegin( event : TouchEvent ) : void {
		var finger : Finger = GetFingerAt( event.touchPointID );
		if ( finger == null ) return;
		finger.Start( event.stageX, event.stageY );
	}

	private function onTouchMove( event : TouchEvent ) : void {
		var finger : Finger = GetFingerAt( event.touchPointID );
		if ( finger == null ) return;
		finger.SetPosition( event.stageX, event.stageY );
	}

	private function onTouchEnd( event : TouchEvent ) : void {
		var finger : Finger = GetFingerAt( event.touchPointID );
		if ( finger == null ) return;
		finger.EndTouch();
	}
}
}
