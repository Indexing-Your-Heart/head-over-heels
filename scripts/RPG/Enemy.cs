// Enemy.cs
// Copyright (C) 2021 Marquis Kurt <software@marquiskurt.net>
// This file is part of Indexing Your Heart.
//
// Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
// CNPLv7+ as found in the LICENSE file in the source code root directory or at 
// <https://git.pixie.town/thufie/npl-builder>.
//
// Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
// details.

using System;
using Godot;

namespace HeadOverHeels.RPG
{
    /// <summary> A class that represents an enemy in the RPG world. </summary>
    public class Enemy : Entity
    {

        /// <summary> The path to the player in the scene tree, relative to the enemy. </summary>
        [Export]
        public NodePath PlayerObject = null;

        /// <summary> The amount that the enemy regenerates by after every tick in the game lifecycle. </summary>
        [Export]
        public double RegenRate = 0.01;

        /// <summary> The modifier that will be appled when attacking the player. </summary>
        [Export]
        public double DamageModifier = 1.0;
        private Player _target;

        public override void _Ready()
        {
            if (PlayerObject == null)
                GD.PushWarning("Path to player is null.");
            _target = GetNodeOrNull<Player>(PlayerObject);
        }

        /// <summary> Attacks the player with a specified amount of damage. </summary>
        /// <remarks> The damage amount is determined by their health and damage modifiers. </remarks>
        public void Attack()
        {
            if (_target == null)
            {
                GD.PushWarning("Target was not initialized or the path was null.");
                return;
            }
            var naturalAttack = 5 - (5 * (Health / DefaultHealth));
            _target.Damage(naturalAttack + DamageModifier);
        }

        public override void _Process(float delta)
        {
            Heal(RegenRate / delta);
        }
    }
}
