/**
 * Created with IntelliJ IDEA.
 * User: wrobel221
 * Date: 04.04.14
 * Time: 03:14
 * To change this template use File | Settings | File Templates.
 */
package
{
import away3d.cameras.Camera3D;
import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Vector3D;

import touch.me.baby.TouchMeBaby;
import touch.me.baby.gesture.DragGestureTracker;
import touch.me.baby.gesture.PinchGestureTracker;
import touch.me.baby.gesture.data.DragGestureData;
import touch.me.baby.gesture.data.PinchGestureData;

public class Object3DRotator
{
	private var _touch : TouchMeBaby;
	private var _view : Sprite;
	private var _target : Mesh;
	private var _camera : Camera3D;

	private var _dragGestureTracker : DragGestureTracker;
	private var _pinchGestureTracker : PinchGestureTracker;
	private var _cameraContainer : ObjectContainer3D;

	private var _minDistance : Number = -200;
	private var _maxDistance : Number = -1000;
	private var _targetDistance : Number = -300;
	private var _zoomProgress : Number = 0;

	private var _rotationForce : Point;
	private const ZeroTargetForce : Point = new Point();

	public function Object3DRotator( touch : TouchMeBaby, view : Sprite, target : Mesh, camera : Camera3D, cameraContainer : ObjectContainer3D ) {
		_touch = touch;
		_view = view;
		_target = target;
		_camera = camera;
		_cameraContainer = cameraContainer;

		_targetDistance = _camera.z;
		_zoomProgress = LerpAmount( _targetDistance, _minDistance, _maxDistance );

		_rotationForce = new Point();

		view.addEventListener( Event.ENTER_FRAME, Update, false, 0, true );

		_dragGestureTracker = new DragGestureTracker();
		_dragGestureTracker.onDragSignal.add( OnDrag );
		_touch.RegisterGestureTracker( _dragGestureTracker );

		_pinchGestureTracker = new PinchGestureTracker();
		_pinchGestureTracker.onPinchSignal.add( OnZoom );
		_touch.RegisterGestureTracker( _pinchGestureTracker );
	}

	public function Destroy() : void {
		if ( _view )
			_view.removeEventListener( Event.ENTER_FRAME, Update );

		_touch.RemoveGestureTracker( _dragGestureTracker );
	}

	private function Update( event : Event = null ) : void {
		_camera.z = Lerp( 0.1, _camera.z, _targetDistance );

		_cameraContainer.rotate( Vector3D.Y_AXIS, _rotationForce.x );
		_cameraContainer.rotate( Vector3D.X_AXIS, _rotationForce.y );
		LerpPoint( 0.1, _rotationForce, ZeroTargetForce, _rotationForce );
	}

	private function OnDrag( dragData : DragGestureData ) : void {
		_rotationForce.offset( dragData.deltaPos.x / 20, dragData.deltaPos.y / 20 );
	}

	private function OnZoom( data : PinchGestureData ) : void {
		_zoomProgress += data.deltaZoom / 5;
		_zoomProgress = Clamp01( _zoomProgress );
		_targetDistance = Lerp( _zoomProgress, _maxDistance, _minDistance );
	}

	private function Clamp01( value : Number ) : Number {
		return Clamp( value, 0, 1 );
	}

	private function Clamp( value : Number, min : Number, max : Number ) : Number {
		return Math.max( Math.min( value, max ), min );
	}

	private function LerpPoint( amount : Number, start : Point, end : Point, result : Point ) : void {
		result.x = Lerp( amount, start.x, end.x );
		result.y = Lerp( amount, start.y, end.y );
	}

	private function Lerp( amount : Number, start : Number, end : Number ) : Number {
		if ( start == end ) {
			return start;
		}
		return ( ( 1 - amount ) * start ) + ( amount * end );
	}

	private function LerpAmount( value : Number, start : Number, end : Number ) : Number {
		if ( start == end ) {
			return NaN;
		}
		return (start - value) / (start - end);
	}
}
}
