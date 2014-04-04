package touch.me.baby.input
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import touch.me.baby.vo.Finger;

public class MouseInputProvider extends BasePointerInputProvider
{
	public function MouseInputProvider( view : Sprite ) {
		trace( "Initializing MouseInputProvider" );
		view.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		view.stage.addEventListener( Event.MOUSE_LEAVE, OnMouseLeave, false, 0, true );
		view.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		view.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
	}

	private function onMouseDown( event : MouseEvent ) : void {
		var finger : Finger = GetFingerAt( 0 );
		if ( finger == null ) return;
		finger.Start( event.stageX, event.stageY );
	}

	private function onMouseMove( event : MouseEvent ) : void {
		var finger : Finger = GetFingerAt( 0 );
		if ( finger == null ) return;
		finger.SetPosition( event.stageX, event.stageY );
	}

	private function onMouseUp( event : MouseEvent ) : void {
		var finger : Finger = GetFingerAt( 0 );
		if ( finger == null ) return;
		finger.EndTouch();
	}

	private function OnMouseLeave( event : Event ) : void {
		var finger : Finger = GetFingerAt( 0 );
		if ( finger == null ) return;
		finger.EndTouch();
	}
}
}
