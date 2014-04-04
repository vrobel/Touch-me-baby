package touch.me.baby.gesture.data
{
import flash.geom.Point;

import touch.me.baby.gesture.enum.GestureState;
import touch.me.baby.vo.Finger;
import touch.me.baby.vo.FingerStateEnum;

public class PinchGestureData
{
	public function PinchGestureData( finger1 : Finger, finger2 : Finger ) {
		if ( finger1 == null || finger2 == null )
			throw new ArgumentError( "Missing activeFinger" );
		this.finger1 = finger1;
		this.finger2 = finger2;
		var distance : Number = Point.distance( finger1.currentPoint, finger2.currentPoint );
		currentFingerDistance = startFingerDistance = Math.max(10, distance);
		state = GestureState.BEGIN;
		_deltaZoom = 0;
	}

	public var state : GestureState = GestureState.NONE;
	private var finger1 : Finger;
	private var finger2 : Finger;
	private var startFingerDistance : Number;
	private var currentFingerDistance : Number;
	private var _deltaZoom : Number;

	public function get currentZoom() : Number {
		return currentFingerDistance / startFingerDistance;
	}

	public function get deltaZoom() : Number {
		return _deltaZoom;
	}

	public function Update() : void {
		var prevZoom : Number = Math.log(currentZoom);
		currentFingerDistance = Point.distance( finger1.currentPoint, finger2.currentPoint );
		_deltaZoom = Math.log(currentZoom) - prevZoom;

		switch ( true ) {
			case !finger1.isDown || !finger2.isDown ||
					finger1.state == FingerStateEnum.NONE ||
					finger2.state == FingerStateEnum.NONE:
				state = GestureState.END;
				break;
			case finger1.state == FingerStateEnum.STILL && finger2.state == FingerStateEnum.STILL:
				state = GestureState.PAUSED;
				break;
			default :
				state = GestureState.UPDATE;
				break;
		}
	}
}
}