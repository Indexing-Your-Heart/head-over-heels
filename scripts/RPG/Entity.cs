// Entity.cs
// Copyright (C) 2021 Marquis Kurt <software@marquiskurt.net>
// This file is part of Indexing Your Heart.
//
// Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
// CNPLv7+ as found in the LICENSE file in the source code root directory or at 
// <https://git.pixie.town/thufie/npl-builder>.
//
// Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
// details.

using Godot;

namespace HeadOverHeels.RPG
{
    /// <summary>The base class for all entities in the game, which contain health properties. </summary>
    public class Entity : KinematicBody2D
    {
        #region Signals
        /// <summary> A signal emitted when the entity has been damaged. </summary>
        [Signal]
        public delegate void EntityDamaged();

        /// <summary> A signal emitted when the entity has died. </summary>
        [Signal]
        public delegate void EntityDied();
        #endregion

        /// <summary> The default maximum health to assign the entity at generation time. </summary>
        [Export]
        public double DefaultHealth = 100.0;

        /// <summary> A double that represents the entity's health. </summary>
        /// <remarks> This is a read-only property. To damage the entity, use <c>Entity.damage</c>. </remarks>
        public double Health { get => _health; }
        private double _health;

        /// <summary> Damage the entity's health by a given amount. </summary>
        /// <remarks> The <c>Entity.EntityDamaged</c> signal will emit when the entity is damaged. If the entity
        /// has died, the <c>Entity.EntityDied signal will also emit.</c> </remarks>
        /// <param name="amount">The amount of damage to subtract from the entity's health.</param>
        public void Damage(double amount)
        {
            _health -= amount;
            if (_health < 0)
                _health = 0;
            EmitSignal(nameof(EntityDamaged));
            if (_health == 0)
                EmitSignal(nameof(EntityDied));
        }

        /// <summary> Heal the entity's health by a given amount. </summary>
        /// <param name="amount"> The amount to heal the entity by. </param>
        public void Heal(double amount)
        {
            _health += amount;
            if (_health > 100)
                _health = 100;
        }
    }

}
