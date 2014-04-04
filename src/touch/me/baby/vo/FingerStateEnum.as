/**
 * Created with IntelliJ IDEA.
 * User: wrobel221
 * Date: 03.04.14
 * Time: 23:27
 * To change this template use File | Settings | File Templates.
 */
package touch.me.baby.vo
{
public class FingerStateEnum
{
	public static const NONE : FingerStateEnum = new FingerStateEnum( "NONE" );
	public static const JUST_STARTED : FingerStateEnum = new FingerStateEnum( "JUST_STARTED" );
	public static const MOVING : FingerStateEnum = new FingerStateEnum( "MOVING" );
	public static const STILL : FingerStateEnum = new FingerStateEnum( "STILL" );

	private var _name : String;

	function FingerStateEnum( name : String ) {
		this._name = name;
	}

	public function toString() : String {
		return "FingerState{name=" + String( _name ) + "}";
	}
}
}
