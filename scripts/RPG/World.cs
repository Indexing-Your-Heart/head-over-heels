using Godot;
using System;
using Katorin.UI;
using System.Collections.Generic;

namespace Katorin.RPG
{
    public class World : Node2D
    {
        private HashSet<Enemy> _enemies;

        private HeadsUpDisplay _HUD;

        private Player _player;
        private HashSet<Node2D> _robots; // TODO: Change the type of this to HashSet<Robot>

        public override void _Ready()
        {
            _player = GetNode<Player>("Player");
            _HUD = GetNode<HeadsUpDisplay>("HUD");
            _enemies = new HashSet<Enemy>();
            foreach (var child in GetChildren())
            {
                if (!(child is Enemy))
                    continue;
                var enemy = (Enemy)child;
                enemy.Connect(nameof(Entity.EntityDied), this, nameof(CleanUpDeadEnemies));
                _enemies.Add(enemy);
            }
            _robots = new HashSet<Node2D>();
        }

        public Enemy ClosestEnemyToPlayerOrNull()
        {
            Enemy closest = null;
            Double minDistance = Double.PositiveInfinity;
            foreach (Enemy enemy in _enemies)
            {
                if (enemy.Position.DistanceTo(_player.Position) >= minDistance)
                    continue;
                minDistance = enemy.Position.DistanceTo(_player.Position);
                closest = enemy;
            }
            return closest;
        }

        public override void _UnhandledInput(InputEvent @event)
        {
            if (@event.GetActionStrength("attack") > 0)
                ProcessPlayerAttack();
        }

        private void ProcessPlayerAttack()
        {
            Enemy closest = ClosestEnemyToPlayerOrNull();
            if (closest == null || closest.Position.DistanceTo(_player.Position) > 100)
                return;
            closest.Damage(5.0);
            closest.Attack();
        }

        private void CleanUpDeadEnemies()
        {
            foreach (Enemy enemy in _enemies)
            {
                if (enemy.Health != 0.0)
                    continue;
                RemoveChild(enemy);
                enemy.QueueFree();
                _enemies.Remove(enemy);
            }
        }

    }
}