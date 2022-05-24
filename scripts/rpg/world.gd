# world.gd
# Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net> and contributors.
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or
# modify it under the terms of the CNPLv7+ as found in the LICENSE file in the
# source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted
# by applicable law. See the CNPL for details.
class_name GameWorld
extends Node2D
# A class that represents a game world per chapter.

onready var _player := find_node("Player", true)

var _enemies = []


func _ready() -> void:
    # Called when the node enters the scene tree for the first time.
    setup()


func get_enemies() -> Array:
    # Returns the list of enemies currently present in the game world.
    return _enemies


func free_dead_enemies() -> void:
    # Frees the enemies that have died from memory.
    var new_enemies = _enemies.duplicate()
    for enemy in _enemies:
        if enemy.get_health() != 0.0:
            continue

        remove_child(enemy)
        enemy.queue_free()
        new_enemies.erase(enemy)
    _enemies = new_enemies


func setup() -> void:
    # Sets up the scene.
    # This is generally called by _ready and does not need to be called by
    # itself unless in a unit test.
    _enemies = Utils.filter_children(self, "_is_enemy", self)
    for enemy in _enemies:
        if enemy.has_player_attached():
           continue
        if enemy.PLAYER_PATH != null:
            enemy.attach_player_from_path()
            continue
        enemy.attach_player(_player)


func _is_enemy(node: Node2D) -> bool:
    return node is Enemy
