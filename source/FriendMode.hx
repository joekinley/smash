package;

enum FriendMode {
  Act;       // just walking or whatever the NON-attack mode of the current friend is
  Attack;    // attack mode, or whatever the attack mode of the current friend is
  Caught;    // mode when the friend is caught, mostly it's just sitting upside down in wait sprite
  Catching;  // when the friend is currently being caught
  Releasing; // when the friend is currently being released
  Healing;   // when touching a reactor
}