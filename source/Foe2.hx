package;

class Foe2 extends Foe {
  override private function init( ):Void {
    super.init( );
    this.speed = 150;
  }

  override private function init_graphics( ):Void {
    this.makeGraphic( Reg.foe_width_2, Reg.foe_height_2, 0xFFFF0000 );
  }
}