package touch.me.baby.gesture
{
import org.osflash.signals.Signal;

import touch.me.baby.gesture.data.DragGestureData;
import touch.me.baby.gesture.enum.GestureState;
import touch.me.baby.input.BasePointerInputProvider;
import touch.me.baby.vo.Finger;

public class DragGestureTracker implements IGestureTracker
{
	public var activationDistance : Number = 10.0;
	public var onDragSignal : Signal = new Signal( DragGestureData );

	//todo: add more slots for multiple simultaneous gestures, currently only one supported
	public var _activeGesture : DragGestureData;

	public function get IsExclusive() : Boolean {
		return false;
	}

	public function get IsActive() : Boolean {
		return _activeGesture != null;
	}

	public function Update( input : BasePointerInputProvider ) : void {
		var activeFinger : Finger = input.FindFirstActiveFinger();

		//begin when no activeDragGesture and some finger is down
		if ( CanBegin( activeFinger, input ) ) {
			_activeGesture = new DragGestureData( activeFinger );
			onDragSignal.dispatch( _activeGesture );
		} else if ( _activeGesture != null ) {
			_activeGesture.Update();
			if ( _activeGesture.state != GestureState.PAUSED )
				onDragSignal.dispatch( _activeGesture );
			if ( _activeGesture.state == GestureState.END )
				_activeGesture = null;
		}
	}

	public function Destroy() : void {
		onDragSignal.removeAll();
	}

	public function Interrupt() : void {
		if ( _activeGesture) {
			_activeGesture.state = GestureState.END;
			_activeGesture = null;
		}
	}

	private function CanBegin( activeFinger : Finger, input : BasePointerInputProvider ) : Boolean {
		return activeFinger != null &&
				activeFinger.totalPositionChange.length > activationDistance &&
				_activeGesture == null &&
				input.activeFingersCount == 1;
	}
}
}

