package touch.me.baby
{
import flash.display.Sprite;
import flash.events.Event;

import touch.me.baby.gesture.IGestureTracker;
import touch.me.baby.input.BasePointerInputProvider;
import touch.me.baby.input.MouseInputProvider;
import touch.me.baby.input.TouchInputProvider;
import touch.me.baby.utils.DeviceInfo;

public class TouchMeBaby
{
	public function TouchMeBaby( view : Sprite ) {
		if ( view == null )
			throw new ArgumentError( "Touch requires view" );

		_view = view;

		_view.addEventListener( Event.ENTER_FRAME, Update, false, 0, true );

		_inputProvider = DeviceInfo.isMobile() ? new TouchInputProvider( view ) : new MouseInputProvider( view );
	}

	private var _view : Sprite;
	private var _inputProvider : BasePointerInputProvider;
	private var _gestureTrackers : Vector.<IGestureTracker> = new <IGestureTracker>[];

	private var exclusiveActive : IGestureTracker;

	public function Update( event : Event = null ) : void {
		_inputProvider.Update();

		//update all gesture trackers.
		//if exclusiveActive gesture then ignore others.
		for ( var i : int = 0; i < _gestureTrackers.length; i++ ) {
			var gestureTracker : IGestureTracker = _gestureTrackers[i];

			if(exclusiveActive == null || exclusiveActive == gestureTracker)
			{
				gestureTracker.Update( _inputProvider );
				if(exclusiveActive == null && gestureTracker.IsExclusive && gestureTracker.IsActive)
					exclusiveActive = gestureTracker;
				if(exclusiveActive == gestureTracker && (!gestureTracker.IsActive || !gestureTracker.IsExclusive))
					exclusiveActive = null;
			}
		}

		if(exclusiveActive != null)
		{
			for ( i = 0; i < _gestureTrackers.length; i++ ) {
				gestureTracker = _gestureTrackers[i];
				if(gestureTracker != exclusiveActive)
					gestureTracker.Interrupt();
			}
		}
	}

	public function Destroy() : void {
		if ( _view )
			_view.removeEventListener( Event.ENTER_FRAME, Update );
		_view = null;

		for each ( var input : BasePointerInputProvider in _inputProvider ) {
			input.Destroy();
		}

		for each ( var gestureTracker : IGestureTracker in _gestureTrackers ) {
			gestureTracker.Destroy();
		}
	}

	public function RegisterGestureTracker( gestureTracker : IGestureTracker ) : void {
		_gestureTrackers.push( gestureTracker );
	}

	public function RemoveGestureTracker( gesture : IGestureTracker ) : void {
		var index : Number = _gestureTrackers.indexOf( gesture );
		if ( index >= 0 )
			_gestureTrackers.splice( index, 1 );

		if(gesture == exclusiveActive)
			exclusiveActive = null;
	}
}

}




