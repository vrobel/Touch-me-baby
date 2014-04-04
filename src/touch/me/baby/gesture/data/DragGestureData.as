package touch.me.baby.gesture.data
{
import flash.geom.Point;

import touch.me.baby.gesture.enum.GestureState;
import touch.me.baby.vo.Finger;
import touch.me.baby.vo.FingerStateEnum;

public class DragGestureData
{
	public function DragGestureData( activeFinger : Finger ) {
		if ( activeFinger == null )
			throw new ArgumentError( "Missing activeFinger" );
		finger = activeFinger;
		startPos = finger.currentPoint.clone();
		currentPos = finger.currentPoint.clone();
		deltaPos = new Point();
		state = GestureState.BEGIN;
	}

	public var finger : Finger;
	public var startPos : Point;
	public var deltaPos : Point;
	public var currentPos : Point;
	public var state : GestureState = GestureState.NONE;

	public function get totalPositionChange() : Point {
		return new Point( currentPos.x - startPos.x, currentPos.y - startPos.y );
	}

	public function Update() : void {
		var newPos : Point = finger.currentPoint;
		deltaPos.copyFrom( finger.deltaPoint );
		currentPos.copyFrom( newPos );
		switch ( true ) {
			case !finger.isDown || finger.state == FingerStateEnum.NONE:
				state = GestureState.END;
				break;
			case finger.state == FingerStateEnum.STILL:
				state = GestureState.PAUSED;
				break;
			default:
				state = GestureState.UPDATE;
				break;
		}
	}
}
}