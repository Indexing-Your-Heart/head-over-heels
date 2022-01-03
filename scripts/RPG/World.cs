// World.cs
// Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net>
// This file is part of Indexing Your Heart.
//
// Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
// CNPLv7+ as found in the LICENSE file in the source code root directory or at 
// <https://git.pixie.town/thufie/npl-builder>.
//
// Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
// details.

using System;
using System.Collections.Generic;
using Godot;
using HeadOverHeels.Extensions;
using HeadOverHeels.UI;

namespace HeadOverHeels.RPG
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
            foreach (var child in this.GetChildren(e => e is Enemy))
            {
                var enemy = (Enemy)child;
                enemy.Connect(nameof(Entity.EntityDied), this, nameof(CleanUpDeadEnemies));
                _enemies.Add(enemy);
            }
            _robots = new HashSet<Node2D>();
        }

        public Enemy ClosestEnemyToPlayerOrNull()
        {
            Enemy closest = null;
            var minDistance = double.PositiveInfinity;
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