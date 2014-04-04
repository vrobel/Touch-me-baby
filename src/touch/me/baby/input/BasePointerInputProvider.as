package touch.me.baby.input
{
import touch.me.baby.vo.Finger;

public class BasePointerInputProvider
{
	//our system supports max two fingers
	public var fingers : Vector.<Finger> = new <Finger>[new Finger(0), new Finger(1)];

	public function get activeFingersCount() : int {
		var countActiveFingers : int = 0;
		for ( var i : int = 0; i < fingers.length; i++ ) {
			if ( fingers[i].isDown )
				countActiveFingers++;
		}
		return countActiveFingers;
	}

	public function Update() : void {
		for ( var i : int = 0; i < fingers.length; i++ ) {
			fingers[i].Update();
		}
	}

	public function FindFirstActiveFinger() : Finger {
		for ( var i : int = 0; i < fingers.length; i++ ) {
			var finger : Finger = fingers[i];
			if ( finger.isDown )
				return finger;
		}
		return null;
	}

	protected function GetFingerAt( index : int ) : Finger {
		return index >= fingers.length ? null : fingers[index];
	}

	public function Destroy() : void {

	}
}
}
