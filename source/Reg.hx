package;

import flixel.group.FlxGroup;
import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	static public var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	static public var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	static public var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	static public var score:Int = 0;
	/**
	 * Generic bucket for storing different <code>FlxSaves</code>.
	 * Especially useful for setting up multiple save slots.
	 */
	static public var saves:Array<FlxSave> = [];

	//
	// GAME CONFIGURATION
	//

	static public var game_gravity:Float = 115;

	static public var layer_particles:FlxGroup = null;

	static public var current_level:Level = null;

	static public var player:Player = null;

	static public var max_distance:Float = 5;

	static public var particleManager:ParticleManager = null;

	//
	// PLAYER CONFIGURATION
	//

	static public var player_width:Int = 24;
	static public var player_height:Int = 24;

	static public var player_jump:Float = 250;
	static public var player_jump_min:Float = 0.0325;
	static public var player_jump_max:Float = 0.3;
	static public var player_speed:Float = 235;
	static public var player_speed_jump:Float = 350;
	static public var player_overledge_max:Float = 0.105;

	static public var player_acceleration:Float = Reg.player_speed / 5;
	static public var player_deceleration:Float = Reg.player_speed / 10;

	static public var player_fetch_timer:Float = 1.5;

	//
	// FRIEND CONFIGURATION
	//

	static public var friend_heal_timer:Float = 2;
	static public var friend_attack_timer:Float = 2;
	static public var friend_width:Int = 30;
	static public var friend_height:Int = 30;

	// other objects
	static public var reactor_width:Int = 30;
	static public var reactor_height:Int = 30;

	//
	// FOE CONFIGURATION
	//

	static public var foe_attack_timer:Float = 2;
	static public var foe_spawn_timer:Float = 25;
	static public var foe_width:Int = 30;
	static public var foe_height:Int = 30;
	static public var foe_width_2:Int = 20;
	static public var foe_height_2:Int = 20;
	static public var foe_width_3:Int = 10;
	static public var foe_height_3:Int = 10;

	//
	// TILE CONFIGURATION
	//

	static public var tile_width:Int = 32;
	static public var tile_height:Int = 32;

}