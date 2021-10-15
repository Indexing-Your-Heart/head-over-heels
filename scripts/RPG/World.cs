using Godot;
using System;
using Katorin.UI;
using System.Collections.Generic;

namespace Katorin.RPG
{
    public class World : Node2D
    {
        private HashSet<Enemy> _Enemies;

        private HeadsUpDisplay _HUD;

        private Player _Player;
        private HashSet<Node2D> _Robots; // TODO: Change the type of this to HashSet<Robot>

        public override void _Ready()
        {
            _Player = GetNode<Player>("Player");
            _HUD = GetNode<HeadsUpDisplay>("HUD");
            _Enemies = new HashSet<Enemy>();
            foreach (var child in GetChildren())
            {
                if (!(child is Enemy)) continue;
                var enemy = (Enemy)child;
                enemy.Connect(nameof(Entity.EntityDied), this, nameof(CleanUpDeadEnemies));
                _Enemies.Add(enemy);
            }
            _Robots = new HashSet<Node2D>();
        }

        public Enemy ClosestEnemyToPlayerOrNull()
        {
            Enemy closest = null;
            Double minDistance = Double.PositiveInfinity;
            foreach (Enemy enemy in _Enemies)
            {
                if (enemy.Position.DistanceTo(_Player.Position) >= minDistance) continue;
                minDistance = enemy.Position.DistanceTo(_Player.Position);
                closest = enemy;
            }
            return closest;
        }

        public override void _UnhandledInput(InputEvent @event)
        {
            if (@event.GetActionStrength("attack") > 0) ProcessPlayerAttack();
        }

        private void ProcessPlayerAttack()
        {
            Enemy closest = ClosestEnemyToPlayerOrNull();
            if (closest == null) return;
            if (closest.Position.DistanceTo(_Player.Position) > 100) return;
            closest.Damage(5.0);
            closest.Attack();
        }

        private void CleanUpDeadEnemies()
        {
            foreach (Enemy enemy in _Enemies)
            {
                if (enemy.Health != 0.0) continue;
                RemoveChild(enemy);
                enemy.QueueFree();
                _Enemies.Remove(enemy);
            }
        }

    }
}