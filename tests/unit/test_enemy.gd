# test_enemy.gd
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
# A test suite for the Enemy class.


func test_enemy_cast() -> void:
    # Test that the Enemy class is available for type casting.
    var enemy = add_child_autofree(Enemy.new())
    assert_not_null(enemy)
    assert_true(enemy is Enemy)


func test_enemy_attack() -> void:
    # Test that the enemy can attack a player.
    var enemy = add_child_autofree(Enemy.new())
    var player = add_child_autofree(Player.new())

    enemy.attach_player(player)
    assert_true(enemy.has_player_attached())

    enemy.damage(12.0)
    enemy.attack()

    assert_true(enemy.get_health() > 0)
    assert_ne(player.get_health(), 100.0)


func test_enemy_heals_over_time() -> void:
    # Test that the enemy will heal over time.
    var enemy = add_child_autofree(Enemy.new())
    enemy.damage(42)
    var before = enemy.get_health()
    yield(yield_for(5.0), YIELD)
    assert_ne(enemy.get_health(), before)
