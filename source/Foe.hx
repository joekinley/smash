package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxMath;

class Foe extends FlxSprite {

  private var _mode:FoeMode = FoeMode.Walking;

  private var attackTimer:Float = Reg.foe_attack_timer;
  private var attackFriend:Friend = null;

  private var speed:Float = 100;

  public function new( x:Float, y:Float ) {
    super( x, y );
    this.init( );
  }

  private function init( ):Void {
    this.health = 3;
    this.acceleration.y = Reg.game_gravity;
    this.init_graphics( );
  }

  private function init_graphics( ):Void {
    this.makeGraphic( Reg.foe_width, Reg.foe_height, 0xFFFF0000 );
  }

  override public function update( ):Void {
    if( this._mode == FoeMode.Walking ) this.update_movement( );
    if( this._mode == FoeMode.Attacking ) this.update_attack( );
    super.update( );
  }

  private function update_movement( ):Void {
    if( !this.isTouching( FlxObject.DOWN ) ) return;

    if( this.facing == FlxObject.RIGHT ) this.velocity.x = this.speed;
    if( this.facing == FlxObject.LEFT ) this.velocity.x = -this.speed;

    if( this.isTouching( FlxObject.RIGHT ) && this._mode == FoeMode.Walking ) {
      this.facing = FlxObject.LEFT;
    }
    if( this.isTouching( FlxObject.LEFT ) && this._mode == FoeMode.Walking ) {
      this.facing = FlxObject.RIGHT;
    }
  }

  private function update_attack( ):Void {
    if( this.attackFriend != null && this.attackFriend.health <= 0 ) this.attackFriend = null;

    if( this.attackFriend == null ) {
      this.attackTimer = Reg.foe_attack_timer;
      this._mode = FoeMode.Walking;
      return;
    }

    this.attackTimer -= FlxG.elapsed;

    if( this.attackTimer < 0 ) {
      this.attackFriend.hit( );
      this.attackTimer = Reg.foe_attack_timer;
    }

    // check for proper distance
    if( FlxMath.distanceBetween( this, this.attackFriend ) > this.width + Reg.max_distance ) this.attackFriend = null;
  }

  public function attack( friend:Friend ):Void {
    if( this._mode == FoeMode.Attacking ) return;

    this._mode = FoeMode.Attacking;
    this.attackFriend = friend;
  }

  public function hit( ):Void {
    Reg.particleManager.spawnAttackAt( this );
    this.health -= 1;
  }
}