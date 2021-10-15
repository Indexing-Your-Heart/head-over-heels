using Godot;
using System;

namespace Katorin.RPG
{
    using ASMPlayback = AnimationNodeStateMachinePlayback;

    /// <summary> The class that is associated with the player character in the RPG section of the game. </summary>
    public class Player : Entity
    {
        /// <summary> A signal emitted when the player has leveled up, which also provides the level of experience
        /// they are at. </summary>
        ///<param name="level"> The level that the player has leveled up to. </param>
        [Signal]
        public delegate void LeveledUp(int level);

        /// <summary> The number of developer experience points the player has. </summary>
        /// <see cref="DevLevel" />
        public int DevExperience { get { return _DevExperience; } }

        /// <summary> The player's current level with respect to developer experience points. </summary>
        /// <remarks> A level is the equivalent to 25 developer experience points. </remarks>
        /// <see cref="DevExperience" />
        public int DevLevel { get { return _DevExperience / 25; } }
        private int _DevExperience = 0;
        private Vector2 _Velocity = Vector2.Zero;

        #region Node Instance Fields
        private AnimationTree _AnimationStateMachine;
        private ASMPlayback _AnimationPlayback;
        #endregion

        public override void _Ready()
        {
            base._Ready();
            _AnimationStateMachine = GetNode<AnimationTree>("ASM");
            _AnimationPlayback = (ASMPlayback)_AnimationStateMachine.Get("parameters/playback");
        }

        /// <summary> Adds an arbitrary amount of developer experience points to the player. </summary>
        /// <remarks> If they level up in the process, the signal <c>LeveledUp</c> will be emitted with the new
        /// level. </remarks>
        /// <param name="amount"> The amount of experience to add to the player. </param>
        public void Grant(int amount)
        {
            int currentLevel = DevLevel;
            _DevExperience += amount;
            if (currentLevel < DevLevel) EmitSignal(nameof(LeveledUp), DevLevel);
        }

        /// <summary> Adds an arbitrary amount of developer experience points to the player based on a given
        /// predicate. </summary>
        /// <remarks> This method can be used for more complex scenarios when the number of points to grant the
        /// player is based on complex conditional logic.This is intended to be a convenience function for the
        /// standard <c>Player.Grant</c> which only accepts a single integer.If they level up in the process, the
        /// signal <c>LeveledUp</c> will be emitted with the new level. </remarks>
        /// <example> For example:
        /// <code>
        /// public int GrantOnTimeOfDay(Day time) => time switch
        /// {
        ///     Day.Morning     => 2
        ///     Day.Afternoon   => 5
        ///     Day.Evening     => 3
        /// };
        /// </code>
        /// </example>
        /// <param name="predicate"> The closure that will return the amount of experience to give to the player.
        /// </param>
        public void Grant(Func<int> predicate) => Grant(predicate());

        public override void _PhysicsProcess(float delta)
        {
            Vector2 movementVector = GetMovementVector();
            const int acceleration = 250;
            const int friction = 100;
            const int maxSpeed = 1000;
            const int speed = 500;

            SetAnimationPlaybackState(movementVector);
            if (movementVector != Vector2.Zero)
            {
                SetAnimationBlendPosition(movementVector);
                _Velocity += movementVector * acceleration * delta;
                _Velocity = _Velocity.Clamped(maxSpeed * delta);
            }
            else _Velocity = _Velocity.MoveToward(Vector2.Zero, friction * delta);
            MoveAndSlide(_Velocity * delta * speed);
        }

        private Vector2 GetMovementVector()
        {
            return new Vector2(
                Input.GetActionStrength("move_right") - Input.GetActionStrength("move_left"),
                Input.GetActionStrength("move_down") - Input.GetActionStrength("move_up")
            );
        }

        private void SetAnimationBlendPosition(Vector2 blendVector)
        {
            _AnimationStateMachine.Set("parameters/idle/blend_position", blendVector);
            _AnimationStateMachine.Set("parameters/walk/blend_position", blendVector);
        }

        private void SetAnimationPlaybackState(Vector2 fromPositionState)
        {
            if (fromPositionState != Vector2.Zero) _AnimationPlayback.Travel("walk");
            else _AnimationPlayback.Travel("idle");
        }

    }
}

