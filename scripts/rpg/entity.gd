# entity.gd
# Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net> and contributors.
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or
# modify it under the terms of the CNPLv7+ as found in the LICENSE file in the
# source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted
# by applicable law. See the CNPL for details.

class_name Entity
extends KinematicBody2D
# A basic entity with health properties.

export var DEFAULT_HEALTH = 100.0

signal entity_damaged()
signal entity_died()

var _health = DEFAULT_HEALTH


func get_health() -> float:
    return _health


func damage(amount: float) -> void:
    # Subtracts the entity's health by a given amount and emits the
    # entity_damaged signal.
    # If the entity had died, the entity_died signal will be emitted.
    _health = clamp(_health - amount, 0, 100)
    emit_signal("entity_damaged")
    if _health == 0:
        emit_signal("entity_died")
