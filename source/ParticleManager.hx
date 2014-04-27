package;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class ParticleManager {
  private var healParticles:HealParticles;
  private var attackParticles:AttackParticles;

  private var layer_particles:FlxGroup;

  public function new( lp:FlxGroup ) {
    this.layer_particles = lp;
    this.init( );
  }

  private function init( ):Void {
    this.init_healParticles( );
    this.init_attackParticles( );
  }

  private function init_healParticles( ):Void {
    this.healParticles = new HealParticles( );
    this.layer_particles.add( this.healParticles );
  }

  private function init_attackParticles( ):Void {
    this.attackParticles = new AttackParticles( );
    this.layer_particles.add( this.attackParticles );
  }

  public function spawnHealAt( obj:FlxObject ):Void {
    this.healParticles.spawnAt( obj );
  }

  public function spawnAttackAt( obj:FlxObject ):Void {
    this.attackParticles.spawnAt( obj );
  }

  public function update( ):Void {

  }
}