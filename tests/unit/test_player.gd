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

var _sender = InputSender.new(Input)


func test_player_cast() -> void:
    # Test that the Player class is available for type casting.
    var player = add_child_autofree(Player.new())
    assert_not_null(player)


func test_level_up() -> void:
    # Test that the player can level up.
    var player = add_child_autofree(Player.new())
    player.connect("leveled_up", self, "_on_player_leveled")
    player.grant(25)


func test_experience_gain() -> void:
    # Test that the player can gain XP points.
    var player = add_child_autofree(Player.new())
    player.grant(1)
    assert_eq(player.get_exp(), 1)


func test_experience_gain_func() -> void:
    # Test that the player can gain XP points from a function return call.
    var player = add_child_autofree(Player.new())
    player.grant_on(self, "_grant_type")
    assert_eq(player.get_exp(), 42)


func test_player_movement() -> void:
    # Test that the player's movement works accordingly.
    var player = add_child_autofree(Player.new())
    _sender.action_down("move_left").hold_for(.1) \
        .action_down("move_up").hold_for(.2) \
        .action_down("move_down").hold_for(.5) \
        .action_down("move_right").hold_for(.8)
    yield(_sender, 'idle')
    assert_ne(player.position, Vector2.ZERO)


func _grant_type() -> int:
    # Dummy function to test player.grant_on.
    return 42


func _on_player_leveled(level: int) -> void:
    pass_test(
        "Player leveled up [%s] (signal connected and activated)." % (level))

