# test_entity.gd
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
# A test suite for the Entity class.


func test_entity_cast() -> void:
    # Test that the child can be cast to the Entity class type.
    var entity = add_child_autofree(Entity.new())
    assert_not_null(entity)
    assert_true(entity is Entity)


func test_entity_damage() -> void:
    # Test that the entity can be damaged.
    var entity = add_child_autofree(Entity.new())
    entity.damage(42)
    assert_eq(entity.get_health(), (100.0 - 42.0))


func test_entity_died() -> void:
    # Test that the entity "dies" correctly.
    var entity = add_child_autofree(Entity.new())
    entity.connect("entity_died", self, "_on_entity_died")
    entity.damage(100)


func test_entity_health_stored() -> void:
    # Test that get_health returns the correct internal health meter.
    var entity = add_child_autofree(Entity.new())
    assert_eq(entity.get_health(), 100.0)


func _on_entity_died() -> void:
    pass_test("Entity died (signal was connected and activated).")
