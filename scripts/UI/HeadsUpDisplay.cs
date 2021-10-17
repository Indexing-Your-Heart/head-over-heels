using Godot;
using Katorin.RPG;

namespace Katorin.UI
{
    public class HeadsUpDisplay : Control
    {
        [Export]
        public NodePath TargetPlayer = null;

        private Label _currentInformation;
        private Player _playerOrNull;

        public override void _Ready()
        {
            _currentInformation = GetNode<Label>("Label");
            _playerOrNull = GetNodeOrNull<Player>(TargetPlayer);
            if (_playerOrNull != null)
                _playerOrNull.Connect(nameof(Entity.EntityDamaged), this, nameof(_Render));
            else GD.PushWarning("Instantiated player for HUD is null.");
        }

        private void _Render()
        {
            _currentInformation.Text = $"Player Health: {_playerOrNull.Health} / {_playerOrNull.DefaultHealth}\n"
                + $"Player DXP: {_playerOrNull.DevExperience} (Level {_playerOrNull.DevLevel})";
        }
    }
}