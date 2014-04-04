/**
 * Created with IntelliJ IDEA.
 * User: wrobel221
 * Date: 03.04.14
 * Time: 03:33
 * To change this template use File | Settings | File Templates.
 */
package touch.me.baby.gesture
{
import org.osflash.signals.Signal;

import touch.me.baby.gesture.data.PinchGestureData;
import touch.me.baby.gesture.enum.GestureState;
import touch.me.baby.input.BasePointerInputProvider;
import touch.me.baby.vo.Finger;

public class PinchGestureTracker implements IGestureTracker
{
	public var exclusive : Boolean = true;
	public var onPinchSignal : Signal = new Signal( PinchGestureData );

	//todo: add fingerCount to allow 2,3 or more finger drag
	public var _activeGesture : PinchGestureData;

	public function get IsExclusive() : Boolean {
		return exclusive;
	}

	public function get IsActive() : Boolean {
		return _activeGesture != null;
	}

	public function Update( input : BasePointerInputProvider ) : void {
		if ( CanBegin( input ) ) {
			var f1 : Finger = input.fingers[0];
			var f2 : Finger = input.fingers[1];

			_activeGesture = new PinchGestureData( f1, f2 );
			onPinchSignal.dispatch( _activeGesture );
		} else if ( _activeGesture != null ) {
			_activeGesture.Update();
			if ( _activeGesture.state != GestureState.PAUSED )
				onPinchSignal.dispatch( _activeGesture );
			if ( _activeGesture.state == GestureState.END )
				_activeGesture = null;
		}
	}

	public function Destroy() : void {
	}

	public function Interrupt() : void {
		if ( _activeGesture ) {
			_activeGesture.state = GestureState.END;
			_activeGesture = null;
		}
	}

	private function CanBegin( input : BasePointerInputProvider ) : Boolean {
		var value : Boolean = input.activeFingersCount == 2 &&
				_activeGesture == null;
		return value;
	}
}
}
