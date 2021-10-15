using Godot;
using System;

namespace Katorin.RPG
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
        public Double DefaultHealth = 100.0;

        /// <summary> A double that represents the entity's health. </summary>
        /// <remarks> This is a read-only property. To damage the entity, use <c>Entity.damage</c>. </remarks>
        public Double Health { get { return _Health; } }
        private Double _Health;

        /// <summary> Damage the entity's health by a given amount. </summary>
        /// <remarks> The <c>Entity.EntityDamaged</c> signal will emit when the entity is damaged. If the entity
        /// has died, the <c>Entity.EntityDied signal will also emit.</c> </remarks>
        /// <param name="amount">The amount of damage to subtract from the entity's health.</param>
        public void Damage(Double amount)
        {
            _Health -= amount;
            if (_Health < 0) _Health = 0;
            EmitSignal(nameof(EntityDamaged));
            if (_Health == 0) EmitSignal(nameof(EntityDied));
        }
    }

}
