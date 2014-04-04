package
{

import away3d.cameras.Camera3D;
import away3d.containers.ObjectContainer3D;
import away3d.containers.Scene3D;
import away3d.containers.View3D;
import away3d.entities.Mesh;
import away3d.materials.TextureMaterial;
import away3d.primitives.CubeGeometry;
import away3d.utils.Cast;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Vector3D;

import touch.me.baby.TouchMeBaby;

[SWF(backgroundColor="#000000", frameRate="60")]
public class RunTest extends Sprite
{

	[Embed(source="/../embeds/air.png")]
	public static var CubeTexture : Class;

	public function RunTest() {
		init();
	}

	private var scene : Scene3D;
	private var camera : Camera3D;
	private var cameraContainer : ObjectContainer3D;
	private var view : View3D;
	private var cube : Mesh;
	private var touch : TouchMeBaby;
	private var rotator : Object3DRotator;

	private function init() : void {
		initEngine();
		initObjects();
		initListeners();
		initTouch();
	}

	private function initTouch() : void {
		touch = new TouchMeBaby( view );
		rotator = new Object3DRotator( touch, view, cube, camera, cameraContainer );
	}

	private function initListeners() : void {
		addEventListener( Event.ENTER_FRAME, onEnterFrame );
		stage.addEventListener( Event.RESIZE, onResize );
		onResize();
	}

	private function initObjects() : void {
		cube = new Mesh( new CubeGeometry( 100, 100, 100, 1, 1, 1, false ), new TextureMaterial( Cast.bitmapTexture( CubeTexture ) ) );
		cube.visible = true;
		cube.mouseEnabled = false;
		cube.mouseChildren = false;
		scene.addChild( cube );
	}

	private function initEngine() : void {
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		view = new View3D();
		view.antiAlias = 8;
		view.camera.z = -300;
		view.camera.y = 0;
		view.camera.lookAt( new Vector3D() );
		scene = view.scene;
		camera = view.camera;

		//set container for camera so it can orbit around center
		//changing only rotation of container
		cameraContainer = new ObjectContainer3D();
		scene.addChild( cameraContainer );
		cameraContainer.addChild( camera );
		addChild( view );
	}

	private function onResize( event : Event = null ) : void {
		view.width = stage.stageWidth;
		view.height = stage.stageHeight;
	}

	private function onEnterFrame( event : Event ) : void {
		view.render();
	}
}
}

















