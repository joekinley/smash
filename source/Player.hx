package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

class Player extends FlxSprite {

  private var pJump:Float = 0;
  private var inAirTime:Float = 0;

  public var fetchedFriend:Friend = null;
  private var fetchTimer:Float = -1;
  private var fetchParticles:FetchParticles;

  public function new( x:Int, y:Int ) {
    super( x, y );

    this.init( );
  }

  private function init( ):Void {
    this.acceleration.y = Reg.game_gravity;
    this.maxVelocity.y = Reg.game_gravity * 2;

    this.init_graphics( );
    this.init_particles( );
  }

  private function init_graphics( ):Void {
    this.makeGraphic( Reg.player_width, Reg.player_height, 0xFFFF00FF );
  }

  private function init_particles( ):Void {
    this.fetchParticles = new FetchParticles( );
    Reg.layer_particles.add( this.fetchParticles );
  }

  override public function update( ):Void {
    this.update_movement( );
    this.update_fetch( );
    // just go final update after everything else, otherwise we can't have proper tile collision
    super.update( );
  }

  public function fetch( friend:Friend ):Void {
    // first release currently holding one
    if( this.fetchedFriend != null ) {
      this.fetchedFriend.release( );
    }

    this.fetchedFriend = friend;
  }

  private function update_fetch( ):Void {
    if( this.fetchTimer >= 0 ) this.fetchTimer += FlxG.elapsed;

    if( this.fetchedFriend == null && FlxG.keys.anyJustPressed( ['C'] ) && this.fetchTimer == -1 ) {
      this.fetchTimer = 0;
      // cast particles
      this.spawn_particles( );
    }

    if( FlxG.keys.anyJustReleased( ['C' ] ) || this.fetchTimer > Reg.player_fetch_timer ) {
      this.fetchParticles.kill( );
      this.fetchTimer = -1;
    }

    if( this.fetchedFriend != null && FlxG.keys.anyJustPressed( ['C'] ) ) {
      this.fetchedFriend.release( );
      this.fetchedFriend = null;
    }

  }

  private function spawn_particles( ):Void {
    // first we cast a ray right underneath the player
    var start:FlxPoint = this.getMidpoint( );
    start.y += this.height + Reg.tile_height;
    var end:FlxPoint = this.getMidpoint( );
    end.y = Reg.current_level.height;

    // cast the ray
    var result:FlxPoint = Reg.current_level.rayHit( start, end, 2 );
    if( result != null ) {
      this.fetchParticles.spawnAt( result );
    }
  }

  private function update_movement( ):Void {
    this.inAirTime += FlxG.elapsed;

    // deceleration
    if( this.velocity.x != 0 && !FlxG.keys.anyPressed( ['LEFT','RIGHT'] ) ) {
      if( this.velocity.x > 0 ) {
        this.velocity.x -= Reg.player_deceleration;
      } else if( this.velocity.x < 0 ) {
        this.velocity.x += Reg.player_deceleration;
      }
      if ( Math.abs( this.velocity.x ) < Reg.player_deceleration ) {
        this.velocity.x = 0;
      }
    }

    if ( FlxG.keys.anyPressed( ['LEFT'] ) ) {
      this.facing = FlxObject.LEFT;
      this.velocity.x -= Reg.player_acceleration;
      //if ( this.pJump <= 0 ) play( 'run_left' );

      if ( this.pJump > 0 && this.velocity.x < -Reg.player_speed_jump ) {
        this.velocity.x = -Reg.player_speed_jump;
      } else if ( this.velocity.x < -Reg.player_speed ) {
        this.velocity.x = -Reg.player_speed;
      }
    }
    if ( FlxG.keys.anyPressed( ['RIGHT'] ) ) {
      this.facing = FlxObject.RIGHT;
      this.velocity.x += Reg.player_acceleration;
      //if ( this.pJump <= 0 ) play( 'run_right' );

      if ( this.pJump > 0 && this.velocity.x > Reg.player_speed_jump ) {
        this.velocity.x = Reg.player_speed_jump;
      } else if ( this.velocity.x > Reg.player_speed ) {
        this.velocity.x = Reg.player_speed;
      }
    }

    if ( FlxG.keys.anyPressed( ['UP','X','SPACE' ] ) && this.pJump >= 0 ) {
      this.pJump += FlxG.elapsed;
      if ( this.pJump > Reg.player_jump_max ) this.pJump = -1;
    } else if ( this.inAirTime > Reg.player_overledge_max ) {
      this.pJump = -1;
    }

    if ( this.pJump > 0 ) {
      //if ( this.facing == FlxObject.LEFT ) play( 'jump_left' );
      //else play( 'jump_right' );
      if ( this.pJump < Reg.player_jump_min ) this.velocity.y = -Reg.player_jump;
    } else if( !isTouching( FlxObject.FLOOR ) ) {
      this.velocity.y += Reg.game_gravity*1.5;
    }

    if ( isTouching( FlxObject.FLOOR ) ) {
      this.pJump = 0;
      this.inAirTime = 0;
    }
  }
}