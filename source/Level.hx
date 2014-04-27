package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;

class Level extends FlxTilemap {
  public function new( ) {
    super( );

    this.init( );
  }

  private function init( ):Void {
    this.loadMap( Levels.level1( ), "assets/images/tiles.png", Reg.tile_width, Reg.tile_height, 0, 1, 1 );

    this.setTileProperties( 1, FlxObject.UP );
    this.setTileProperties( 2, FlxObject.ANY, this.player_die, Player );
  }

  private function player_die( tile:FlxObject, player:FlxObject ):Void {
    FlxG.switchState( new PlayState( ) );
  }
}