# test_world.gd
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
# A test suite for the game world.

onready var _world_scn = preload("res://tests/scenes/test_world.tscn")

func test_world_cast() -> void:
    # Test that the Gameworld class exists and can be casted to.
    var world = add_child_autofree(GameWorld.new())
    assert_not_null(world)


func test_enemies_initialized() -> void:
    # Test that enemies are initalized correctly in the game world.
    var world = autofree(_world_scn.instance() as GameWorld)
    world.setup()
    var enemies = world.get_enemies()
    assert_false(enemies.empty())
    for enemy in enemies:
        assert_true(enemy.has_player_attached())


func test_enemies_cleaned_up() -> void:
    # Test that dead enemies are freed when called.
    var world = autofree(_world_scn.instance() as GameWorld)
    world.setup()
    var enemies = world.get_enemies()
    var old_enemy_count = len(enemies)

    for idx in range(4):
        enemies[idx].damage(101)
    world.free_dead_enemies()

    var new_enemies = world.get_enemies()
    assert_true(len(new_enemies) < old_enemy_count)
    for enemy in new_enemies:
        assert_ne(enemy.get_health(), 0.0)
