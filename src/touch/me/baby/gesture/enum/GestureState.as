package touch.me.baby.gesture.enum
{

public class GestureState
{
	public static const NONE : GestureState = new GestureState( "NONE" );
	public static const BEGIN : GestureState = new GestureState( "BEGIN" );
	public static const PAUSED : GestureState = new GestureState( "PAUSED" );
	public static const UPDATE : GestureState = new GestureState( "UPDATE" );
	public static const END : GestureState = new GestureState( "END" );

	function GestureState( name : String ) {
		_name = name;
	}

	private var _name : String;

	public function toString() : String {
		return "ContinuousGestureState{_name=" + String( _name ) + "}";
	}
}
}
