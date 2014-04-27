package;

import flixel.effects.particles.FlxParticle;

class FetchParticle extends FlxParticle {
  public function new( ) {
    super( );
    this.init( );
  }

  private function init( ):Void {
    this.makeGraphic( 2, 2, 0xFF777777 );
    this.visible = false;
  }
}