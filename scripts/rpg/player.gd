# player.gd
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
var _velocity = Vector2.ZERO
var _vctr = Vector2.ZERO

const _acceleration = 250
const _friction = 100
const _max_speed = 1000
const _speed = 500

func _physics_process(delta: float) -> void:
    var _move_vctr = get_movement()
    if (_move_vctr != Vector2.ZERO):
        _velocity += _move_vctr * _acceleration * delta
        _velocity = _velocity.clamped(_max_speed * delta)
    else: _velocity = _velocity.move_toward(Vector2.ZERO, _friction * delta)
    _vctr = move_and_slide(_velocity * delta * _speed)


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
    # Returns the movement vector based on player's input.
    return Vector2(
        Input.get_axis("move_right", "move_left"),
        Input.get_axis("move_down", "move_up")
    )
