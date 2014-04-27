package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxObject;

class AttackParticles extends FlxEmitter {
  public static var MAX:Int = 10;
  public static var LIFETIME:Float = 3;

  public function new( ) {
    super( 0, 0, AttackParticles.MAX );
    this.init( );
  }

  private function init( ):Void {
    this.setXSpeed( -10, 10 );
    this.setYSpeed( -25, -75 );
    this.xPosition.min = -Reg.friend_width/2;
    this.xPosition.max = Reg.friend_width/2;
    this.yPosition.max = Reg.friend_height/2;

    this.init_particles( );
  }

  private function init_particles( ):Void {
    var part:FlxParticle;
    for( i in 0...AttackParticles.MAX ) {
      part = new FlxParticle( );
      part.makeGraphic( 2, 2, 0xFFFF0000 );
      part.visible = false;
      this.add( part );
    }
  }

  public function spawnAt( obj:FlxObject ):Void {
    this.at( obj );
    this.start( true, AttackParticles.LIFETIME, 0.1 );
  }
}