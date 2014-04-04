package touch.me.baby.vo
{
import flash.geom.Point;
import flash.utils.getTimer;

public class Finger
{
	public function Finger( index : int ) {
		this.index = index;
	}

	public var index : int;
	public var state : FingerStateEnum = FingerStateEnum.NONE;
	public var isDown : Boolean = false;
	public var startPoint : Point = new Point();
	public var deltaPoint : Point = new Point();
	public var currentPoint : Point = new Point();
	private var prevState : FingerStateEnum = FingerStateEnum.NONE;
	private var _prevPoint : Point = new Point();
	private var _startTimer : Number = 0.0;
	private var _endTimer : Number = 0.0;
	private var _moveFlag : Boolean = false;

	public function get moveFlag() : Boolean {
		return _moveFlag;
	}

	public function get totalPositionChange() : Point {
		return new Point( currentPoint.x - startPoint.x, currentPoint.y - startPoint.y );
	}

	public function get wasDown() : Boolean {
		return prevState != FingerStateEnum.NONE;
	}

	public function Start( x : Number, y : Number ) : void {
		isDown = true;
		startPoint.setTo( x, y );
		_prevPoint.setTo( x, y );
		deltaPoint.setTo( 0, 0 );
		currentPoint.setTo( x, y );
		_startTimer = getTimer();
	}

	public function SetPosition( x : Number, y : Number ) : void {
		_moveFlag = true;
		currentPoint.setTo( x, y );
	}

	public function EndTouch() : void {
		isDown = false;
		_endTimer = getTimer();
	}

	public function Update() : void {
		if ( !wasDown && isDown ) {
			SetState( FingerStateEnum.JUST_STARTED );
		} else if ( wasDown && !isDown ) {
			//just finished
			SetState( FingerStateEnum.NONE );
		} else if ( isDown ) {
			//todo: use squared distance for faster calculations
			var changedPosition : Boolean = Point.distance( currentPoint, _prevPoint ) > 1e-5;
			SetState( changedPosition ? FingerStateEnum.MOVING : FingerStateEnum.STILL );
		} else {
			SetState( FingerStateEnum.NONE );
		}

		deltaPoint.setTo( currentPoint.x - _prevPoint.x, currentPoint.y - _prevPoint.y );
		_prevPoint.copyFrom( currentPoint );
	}

	private function SetState( newState : FingerStateEnum ) : void {
		prevState = state;
		state = newState;
	}
}

}

