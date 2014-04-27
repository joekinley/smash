package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.util.FlxRandom;

class FoeManager {

  public static var MAX_FOES:Int = 50;

  private var nextFoeTimer:Float = 0;

  private var layer_foes:FlxGroup;

  public function new( lf:FlxGroup ) {
    this.layer_foes = lf;
    this.init( );
  }

  private function init( ):Void {

  }

  private function check_foe_spawn( ):Void {
    this.nextFoeTimer -= FlxG.elapsed;
    if( this.nextFoeTimer < 0 && this.layer_foes.length < FoeManager.MAX_FOES ) {
      this.spawn_foe( );
    }
  }

  private function spawn_foe( ):Void {
    var foe:Foe = new Foe( FlxRandom.floatRanged( 50, Reg.current_level.width - 50 ), 300 );
    if( foe.x > Reg.current_level.width / 2 ) foe.facing = FlxObject.LEFT;
    else foe.facing = FlxObject.RIGHT;
    this.layer_foes.add( foe );
    this.nextFoeTimer = Reg.foe_spawn_timer;
  }

  public function spawn_foes_2( f:Foe ):Void {
    var foe:Foe2 = new Foe2( f.x - (f.width*2), f.y );
    foe.facing = FlxObject.LEFT;
    this.layer_foes.add( foe );

    foe = new Foe2( f.x+(f.width*2), f.y );
    foe.facing = FlxObject.RIGHT;
    this.layer_foes.add( foe );

    this.layer_foes.remove( f, true );
  }

  public function spawn_foes_3( f:Foe ):Void {
    var foe:Foe3 = new Foe3( f.x - (f.width*2), f.y );
    foe.facing = FlxObject.LEFT;
    this.layer_foes.add( foe );

    foe = new Foe3( f.x+(f.width*2), f.y );
    foe.facing = FlxObject.RIGHT;
    this.layer_foes.add( foe );

    this.layer_foes.remove( f, true );
  }

  public function update( ):Void {
    this.check_foe_spawn( );
    this.check_health( );
  }

  private function check_health( ):Void {
    var foe:Foe;
    for( f in this.layer_foes.members ) {
      foe = cast( f, Foe );
      if( foe.health <= 0 ) this.layer_foes.remove( f, true );
    }
  }
}