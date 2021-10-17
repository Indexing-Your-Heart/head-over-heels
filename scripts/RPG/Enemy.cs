using System;
using Godot;

namespace Katorin.RPG
{
    /// <summary> A class that represents an enemy in the RPG world. </summary>
    public class Enemy : Entity
    {

        /// <summary> The path to the player in the scene tree, relative to the enemy. </summary>
        [Export]
        public NodePath PlayerObject = null;
        private Player _target;

        public override void _Ready()
        {
            if (PlayerObject == null)
                GD.PushWarning("Path to player is null.");
            _target = GetNodeOrNull<Player>(PlayerObject);
        }

        /// <summary> Attacks the player with a specified amount of damage. </summary>
        public void Attack()
        {
            if (_target == null)
            {
                GD.PushWarning("Target was not initialized or the path was null.");
                return;
            }
            // FIXME: Perhaps this should have more consideration besides the health factor alone?
            Double weakPoint = Health / DefaultHealth;
            _target.Damage(5 - (5 * weakPoint));
        }
    }
}
