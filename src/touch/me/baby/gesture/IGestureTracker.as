package touch.me.baby.gesture
{
import touch.me.baby.input.BasePointerInputProvider;

public interface IGestureTracker
{
	function get IsExclusive() : Boolean;

	function get IsActive() : Boolean;

	function Update( input : BasePointerInputProvider ) : void;

	function Destroy() : void;

	function Interrupt() : void;
}
}
