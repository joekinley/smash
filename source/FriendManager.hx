package;

import flixel.group.FlxGroup;
import flixel.util.FlxRandom;

class FriendManager {
  private var layer_friends:FlxGroup;

  public function new( lf:FlxGroup ) {
    this.layer_friends = lf;
    this.init( );
  }

  private function init( ):Void {
    this.init_friends( );
  }

  private function init_friends( ):Void {
    // currently we only have one level so we immediately work on that one
    var f1:Friend = new LWalkerFriend( 200, 200 );
    this.layer_friends.add( f1 );

    f1 = new RWalkerFriend( 200, 200 );
    this.layer_friends.add( f1 );

    //this.init_reactors( );
  }

  private function init_reactors( ) {
    var reactor:Reactor;
    for( i in 0...3 ) {
      reactor = new Reactor( FlxRandom.floatRanged( 50, Reg.current_level.width - 50 ), 400 );
      this.layer_friends.add( reactor );
    }
  }

  public function update( ):Void {
    this.check_health( );
  }

  private function check_health( ):Void {
    var friend:Friend;
    for( f in this.layer_friends.members ) {
      friend = cast( f, Friend );
      if( friend.health <= 0 ) {
        this.layer_friends.remove( f, true );
      }
    }
  }
}