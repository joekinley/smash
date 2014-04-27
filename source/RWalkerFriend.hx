package;

import flixel.FlxObject;

class RWalkerFriend extends LWalkerFriend {
  override private function init( ):Void {
    this.maxVelocity.x = 200;
    super.init( );
  }

  override private function update_act( ):Void {
    super.update_act( );
    // just walk left
    //if( this.touching == FlxObject.DOWN )this.velocity.x = 80;
  }
}