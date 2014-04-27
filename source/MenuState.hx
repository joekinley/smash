package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		var bg:FlxSprite = new FlxSprite( 0, 0 );
		bg.loadGraphic( "assets/images/background.png", false, false, 640, 480 );
		this.add( bg );

		var text3:FlxText = new FlxText( 640 / 2 - 130, 480 / 2 + 50 , 300, "Smash Red with Blue", 20 );
		this.add( text3 );

		var text:FlxText = new FlxText( 640 / 2 - 80, 480 / 2 + 100, 200, "Hit any key", 20 );
		this.add( text );

		var text2:FlxText = new FlxText( 640 / 2 - 110, 480 / 2 + 150, 250, "Cursors and [C]", 20 );
		this.add( text2 );

		FlxG.mouse.visible = false;
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
		if( FlxG.keys.pressed.ANY ) FlxG.switchState( new PlayState( ) );
	}
}