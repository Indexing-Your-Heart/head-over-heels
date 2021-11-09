// HeadsUpDisplay.cs
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
using HeadOverHeels.RPG;

namespace HeadOverHeels.UI
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
                _playerOrNull.Connect(nameof(Entity.EntityDamaged), this, nameof(Render));
            else GD.PushWarning("Instantiated player for HUD is null.");
        }

        private void Render()
        {
            _currentInformation.Text = $"Player Health: {_playerOrNull.Health} / {_playerOrNull.DefaultHealth}\n"
                + $"Player DXP: {_playerOrNull.DevExperience} (Level {_playerOrNull.DevLevel})";
        }
    }
}