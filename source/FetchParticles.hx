package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxPoint;

class FetchParticles extends FlxEmitter {

  private static inline var MAX:Int = 50;

  public function new( ) {
    super( 0, 0, FetchParticles.MAX );
    this.init( );
  }

  private function init( ):Void {
    this.init_emitter( );
    this.init_particles( );
  }

  private function init_emitter( ):Void {
    this.setXSpeed( 0, 0 );
    this.setYSpeed( -1, -20 );
    this.yVelocity.min = -5;
    this.yVelocity.max = -70;
    this.xPosition.min = -Reg.friend_width*2;
    this.xPosition.max = Reg.friend_width*2;
    this.startAlpha.min = 1;
    this.startAlpha.max = 0.8;
    this.endAlpha.min = 0.5;
    this.endAlpha.max = 0.2;
  }

  private function init_particles( ):Void {
    var part:FetchParticle = null;
    for( i in 0...FetchParticles.MAX ) {
      part = new FetchParticle( );
      this.add( part );
    }
  }

  public function spawnAt( p:FlxPoint ):Void {
    this.setPosition( p.x-Reg.player.width, p.y );
    this.start( false, 2, 0.1 );
  }

}