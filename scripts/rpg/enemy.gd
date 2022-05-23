# enemy.gd
# Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net> and contributors.
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or
# modify it under the terms of the CNPLv7+ as found in the LICENSE file in the
# source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted
# by applicable law. See the CNPL for details.
class_name Enemy
extends Entity
# An entity that represents an enemy.

export(NodePath) var PLAYER_PATH = null
export var REGENERATION_RATE = 0.01
export var DAMAGE_MODIFIER = 1.0

var _player: Player

func _ready() -> void:
    if PLAYER_PATH != null:
        _player = get_node(PLAYER_PATH) as Player


func _process(delta: float) -> void:
    heal(REGENERATION_RATE * delta)


func attach_player(player: Player) -> void:
    # Attaches a player to this enemy as its target.
    _player = player


func attack() -> void:
    # Attacks the attached player.
    if _player == null:
        push_error("Cannot attack a null instance of player.")
        return
    var natural_attack = 5 - (5 * (get_health() / DEFAULT_HEALTH))
    _player.damage(max(1, natural_attack * DAMAGE_MODIFIER))
