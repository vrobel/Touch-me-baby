package touch.me.baby.utils
{
import flash.system.Capabilities;
import flash.ui.Multitouch;

public class DeviceInfo
{
	public static function isAndroid() : Boolean {
		return Capabilities.version.substr( 0, 3 ) == "AND" && Capabilities.cpuArchitecture == "ARM";
	}

	public static function isIOS() : Boolean {
		return Capabilities.version.substr( 0, 3 ) == "IOS" && Capabilities.cpuArchitecture == "ARM";
	}

	public static function isMobile() : Boolean {
		var value : Boolean = isAndroid() || isIOS() && Multitouch.supportsTouchEvents;
		trace( "isMobile " + value + ": " + Capabilities.version );
		return value;
	}
}
}
