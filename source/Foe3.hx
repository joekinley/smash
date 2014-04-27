package;

class Foe3 extends Foe {
  override private function init( ):Void {
    super.init( );
    this.speed = 200;
  }

  override private function init_graphics( ):Void {
    this.makeGraphic( Reg.foe_width_3, Reg.foe_height_3, 0xFFFF0000 );
  }
}