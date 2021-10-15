using Godot;
using Katorin.RPG;

namespace Katorin.UI
{
    public class HeadsUpDisplay : Control
    {
        [Export]
        public NodePath TargetPlayer = null;

        private Label _CurrentInformation;
        private Player _PlayerOrNull;

        public override void _Ready()
        {
            _CurrentInformation = GetNode<Label>("Label");
            _PlayerOrNull = GetNodeOrNull<Player>(TargetPlayer);
            if (_PlayerOrNull != null) _PlayerOrNull.Connect(nameof(Entity.EntityDamaged), this, nameof(_Render));
            else GD.PushWarning("Instantiated player for HUD is null.");
        }

        private void _Render()
        {
            _CurrentInformation.Text = $"Player Health: {_PlayerOrNull.Health} / {_PlayerOrNull.DefaultHealth}\n"
                + $"Player DXP: {_PlayerOrNull.DevExperience} (Level {_PlayerOrNull.DevLevel})";
        }
    }
}