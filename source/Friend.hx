package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxMath;
import flixel.util.FlxVelocity;

class Friend extends FlxSprite {

  public static var MAX_HEALTH:Int = 5;

  private var _mode:FriendMode;
  private var justChangedMode:Bool = false;

  private var attackTimer:Float = Reg.friend_attack_timer;
  private var attackFoe:Foe;

  private var healTimer:Float = Reg.friend_heal_timer;
  private var healReactor:Friend = null;

  public function new( x:Float, y:Float ) {
    super( x, y );
    this.mode = FriendMode.Act;
    this.acceleration.y = Reg.game_gravity;
    this.init( );
  }

  private function init( ):Void {
    this.health = Friend.MAX_HEALTH;
    this.init_graphics( );
  }

  private function init_graphics( ):Void {
    this.makeGraphic( Reg.friend_width, Reg.friend_height, 0xFF0000FF );
  }

  override public function update( ):Void {
    this.update_mode( );
    super.update( );
  }

  private function update_mode( ):Void {
    // depending on our current mode we do different things
    switch ( this._mode ) {
      case FriendMode.Act:      this.update_act( );
      case FriendMode.Attack:   this.update_attack( );
      case FriendMode.Catching: this.update_catching( );
      case FriendMode.Caught:   this.update_caught( );
      case FriendMode.Healing:  this.update_healing( );
      default: // nothing
    }
    this.justChangedMode = false;
  }

  private function update_act( ):Void {
    // see child classes
    this.acceleration.y = Reg.game_gravity;
  }

  private function update_attack( ):Void {
    // see child classes
  }

  private function update_catching( ):Void {
    // see child classes - tho usually nothing has to be done
    // only - if we are in catching mode and above the player, we better start back acting
    if( this.y < Reg.player.y ) {
      this.mode = FriendMode.Act;
    }
  }

  private function update_caught( ):Void {
    // in caught mode, gravity shall not aply
    // also we wanna follow the player
    this.x = Reg.player.x;
    this.y = Reg.player.y - this.height;
    //this.animation.play( "caught" );
  }

  private function update_healing( ):Void {
    if( this.health >= Friend.MAX_HEALTH || this.healReactor == null ) this.mode = FriendMode.Act;
    this.healTimer -= FlxG.elapsed;

    this.velocity.set( 0, 0 );
    if( this.healTimer < 0 ) {
      Reg.particleManager.spawnHealAt( this );
      this.health++;
      this.healTimer = Reg.friend_heal_timer;
    }

    if( FlxMath.distanceBetween( this, this.healReactor ) > this.width + Reg.max_distance ) this.healReactor = null;
  }

  public function catchMe( ):Void {
    if( this._mode == FriendMode.Catching ) return;

    this.mode = FriendMode.Catching;

    // start tweening towards player
    //FlxVelocity.moveTowardsObject( this, Reg.player, 850 );
    FlxVelocity.accelerateTowardsObject( this, Reg.player, 1350, 1350, 1350 );
  }

  public function caught( ):Void {
    if( this.mode == FriendMode.Caught ) return;
    if( this.mode == FriendMode.Act ) return;

    this.velocity.set( 0, 0 );
    this.acceleration.set( 0, 0 );
    this.mode = FriendMode.Caught;
    Reg.player.fetch( this );
  }

  // releases the friend at it's current position downwards
  public function release( ):Void {
    this.mode = FriendMode.Act;
    this.y = Reg.player.y + Reg.player.height + 1;
    this.velocity.y = Reg.game_gravity*3;
  }

  public function attack( foe:Foe ):Void {
    if( this._mode == FriendMode.Attack ) return;

    this.mode = FriendMode.Attack;
    this.attackFoe = foe;
  }

  public function heal( friend:Reactor ):Void {
    if( this.mode == FriendMode.Healing ) return;

    this.mode = FriendMode.Healing;
    this.healReactor = friend;
  }

  public var mode( get_mode, set_mode ):FriendMode;

  public function get_mode( ):FriendMode {
    return this._mode;
  }

  public function set_mode( mode:FriendMode ):FriendMode {
    this.justChangedMode = true;
    return this._mode = mode;
  }

  public function hit( ):Void {
    Reg.particleManager.spawnAttackAt( this );
    this.health -= 1;
  }
}