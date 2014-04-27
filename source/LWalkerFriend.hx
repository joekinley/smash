package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxMath;

class LWalkerFriend extends Friend {
  override private function init( ):Void {
    this.maxVelocity.x = 200;
    super.init( );
  }

  override private function update_act( ):Void {
    super.update_act( );
    // just walk left
    //if( this.touching == FlxObject.DOWN )this.velocity.x = -80;
  }

  override private function update_attack( ):Void {
    if( this.attackFoe != null && this.attackFoe.health <= 0 ) this.attackFoe = null;
    super.update_attack( );

    if( this.attackFoe == null ) {
      this.attackTimer = Reg.friend_attack_timer;
      this.mode = FriendMode.Act;
      return;
    }

    this.attackTimer -= FlxG.elapsed;

    if( this.attackTimer < 0 ) {
      this.attackFoe.hit( );
      this.attackTimer = Reg.friend_attack_timer;
    }

    // check for proper distance
    if( FlxMath.distanceBetween( this, this.attackFoe ) > this.width + 5 ) this.attackFoe = null;
  }
}