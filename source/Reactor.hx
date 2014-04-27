package;

class Reactor extends Friend {

  override private function init( ):Void {
    super.init( );
    this.acceleration.y = Reg.game_gravity;
    //this.moves = false;
    //this.immovable = true;
  }

  override private function init_graphics( ):Void {
    this.makeGraphic( Reg.reactor_width, Reg.reactor_height, 0xFFEA0079 );
  }

  override public function catchMe( ):Void {
    return;
  }

  override public function update( ):Void {
    this.velocity.x = 0;
    super.update( );
  }
}