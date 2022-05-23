# GutTest.gd
# Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net> and contributors.
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or
# modify it under the terms of the CNPLv7+ as found in the LICENSE file in the
# source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted
# by applicable law. See the CNPL for details.

extends GutTest
# A test suite for the Player class.

onready var _scene_player = preload("res://tests/scenes/test_player.tscn")
onready var _world = autofree(_scene_player.instance())


func before_each() -> void:
    # Ran before each test.
    _world = autofree(_scene_player.instance())


func test_player_cast() -> void:
    var player = _world.get_child(0) as Player
    assert_not_null(player)


func test_level_up() -> void:
    var player = _world.get_child(0) as Player
    player.connect("leveled_up", self, "_on_player_leveled")
    player.grant(25)


func test_experience_gain() -> void:
    var player = _world.get_child(0) as Player
    player.grant(1)
    assert_eq(player.get_exp(), 1)


func test_experience_gain_func() -> void:
    var player = _world.get_child(0) as Player
    player.grant_on(self, "_grant_type")
    assert_eq(player.get_exp(), 42)


func test_player_movement() -> void:
    var player = _world.get_child(0) as Player
    InputFactory.action_down("move_left")
    var vector = player.get_movement()
    assert_ne(vector, Vector2.ZERO)


func _grant_type() -> int:
    return 42


func _on_player_leveled(level: int) -> void:
    pass_test(
        "Player leveled up [%s] (signal connected and activated)." % (level))

