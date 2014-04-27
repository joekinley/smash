package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRect;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	private var level:Level;
	private var player:Player;

	private var friendManager:FriendManager;
	private var foeManager:FoeManager;
	private var particleManager:ParticleManager;

	private var layer_background:FlxGroup;
	private var layer_level:FlxGroup;
	private var layer_player:FlxGroup;
	private var layer_friends:FlxGroup;
	private var layer_foes:FlxGroup;
	private var layer_particles:FlxGroup;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		this.init_layers( );
		this.init_level( );
		this.init_background( );
		this.init_player( );
		this.init_particleManager( );
		this.init_friendManager( );
		this.init_foeManager( );

		FlxG.mouse.visible = false;
	}

	private function init_layers( ):Void {
		this.layer_background = new FlxGroup( );
		this.layer_level = new FlxGroup( );
		this.layer_player = new FlxGroup( );
		this.layer_friends = new FlxGroup( );
		this.layer_foes = new FlxGroup( );
		this.layer_particles = new FlxGroup( );

		this.add( this.layer_background );
		this.add( this.layer_level );
		this.add( this.layer_player );
		this.add( this.layer_friends );
		this.add( this.layer_foes );
		this.add( this.layer_particles );

		// also register global layers
		Reg.layer_particles = this.layer_particles;
	}

	private function init_background( ):Void {
		var bg:FlxTilemap = new FlxTilemap( );
		bg.loadMap( Levels.level1bg( ), "assets/images/tiles.png", Reg.tile_width, Reg.tile_height, 0, 1, 1 );
		this.layer_background.add( bg );
	}

	private function init_level( ):Void {
		this.level = new Level( );
		this.layer_level.add( this.level );
		Reg.current_level = this.level;
		Reg.level = 1;
	}

	private function init_player( ):Void {
		this.player = new Player( Reg.tile_width*2, Reg.tile_height+5 );
		this.layer_player.add( this.player );
		Reg.player = this.player;

		FlxG.camera.follow( this.player, FlxCamera.STYLE_PLATFORMER );
		FlxG.camera.setBounds( 0, 0, this.level.width, this.level.height );
		FlxG.worldBounds.set( 0, 0, this.level.width, this.level.height );
	}

	private function init_friendManager( ):Void {
		this.friendManager = new FriendManager( this.layer_friends );
	}

	private function init_foeManager( ):Void {
		this.foeManager = new FoeManager( this.layer_foes );
	}

	private function init_particleManager( ):Void {
		this.particleManager = new ParticleManager( this.layer_particles );
		Reg.particleManager = this.particleManager;
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		// player collides with level
		FlxG.collide( this.player, this.layer_level );
		// friends shall collide with particles
		FlxG.overlap( this.layer_friends, this.layer_particles, this.friend_particle_collision );
		// also friends shall collide with the level themselves
		FlxG.collide( this.layer_friends, this.layer_level );
		// now check for collision with player and friends
		FlxG.overlap( this.layer_friends, this.player, this.friend_player_collision );
		// friends shall also collide with each other
		FlxG.collide( this.layer_friends, this.layer_friends, this.friend_friend_collision );
		// foes shall also collide with the level
		FlxG.collide( this.layer_foes, this.layer_level );
		// foes shall also collide with friends
		FlxG.collide( this.layer_friends, this.layer_foes, this.friend_foe_collision );
		// also foes shall collide with each other
		FlxG.collide( this.layer_foes );

		this.particleManager.update( );
		this.friendManager.update( );
		this.foeManager.update( );
	}

	private function friend_foe_collision( fr:FlxObject, fo:FlxObject ):Void {
		var friend:Friend = cast( fr, Friend );
		var foe:Foe = cast( fo, Foe );
		// foe attacking friend
		//foe.attack( friend );
		//friend.attack( foe );
		if( !foe.isTouching( FlxObject.UP ) ) return;
		if( Std.is( fo, Foe3 ) ) foe.health = 0;
		else if( Std.is( fo, Foe2 ) ) this.foeManager.spawn_foes_3( foe );
		else if( Std.is( fo, Foe ) ) this.foeManager.spawn_foes_2( foe );
	}

	private function friend_particle_collision( fr:FlxObject, part:FlxObject ):Void {
		if( !Std.is( part, FetchParticle ) ) return;

		var friend:Friend = cast( fr, Friend );
		friend.catchMe( );
	}

	private function friend_player_collision( fr:FlxObject, pl:FlxObject ):Void {
		var friend:Friend = cast( fr, Friend );
		friend.caught( );
	}

	private function friend_friend_collision( fr1:FlxObject, fr2:FlxObject ):Void {
		var friend:Friend = cast( fr2, Friend );
		if( Std.is( fr1, Reactor ) ) {
			friend.heal( cast( fr1, Reactor ) );
		}
	}
}