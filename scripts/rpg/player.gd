# Entity.gd
# Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net> and contributors.
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or
# modify it under the terms of the CNPLv7+ as found in the LICENSE file in the
# source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted
# by applicable law. See the CNPL for details.
class_name Player
extends Entity
# The player controller class.

export var STARTING_EXPERIENCE = 0

signal leveled_up(level)

var _experience = STARTING_EXPERIENCE


func get_exp() -> int:
    # Returns the experience amount the player has.
    return _experience


func get_level() -> int:
    # Returns the player's current level.
    return _experience / 25


func grant(amount: int) -> void:
    # Increases the player's experience by the amount given. If the amout given
    # causes the player to level up, the leveled_up signal is emitted.
    var _current_level = get_level()
    _experience += amount
    if (_current_level < get_level()):
        emit_signal("leveled_up", get_level())


func grant_on(reference: Node, predicate: String) -> void:
    # Increases the player's experience by the amount given from a predicate.
    # The predicate must return a positive integer and be referentiable from the
    # reference node.
    var call = funcref(reference, predicate)
    grant(call.call_func())


func get_movement() -> Vector2:
    return Vector2(
        Input.get_axis("move_left", "move_right"),
        Input.get_axis("move_up", "move_down")
    )
