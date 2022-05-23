# utils.gd
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
# A test suite for utilities.

onready var _children_scene = preload("res://tests/scenes/test_children.tscn").instance()


func test_filter_children() -> void:
    # Test that the filter_children method can successfully return children.
    var result = Utils.filter_children(_children_scene, "_filter", self)
    assert_not_null(result)
    assert_false(result.empty())
    assert_true(len(result) == 3)

    for child in result:
        assert_true(child.name.begins_with("Child"))
        child.queue_free()


func test_filter_children_throws_on_invalid() -> void:
    # Test that the filter_children method can successfully return children.
    var result = Utils.filter_children(_children_scene, "_filter_failure", self)
    assert_not_null(result)
    assert_true(result.empty())



func _filter(node: Node) -> bool:
    # A sample filter function for use in filter tests.
    return node.name.begins_with("Child")


func _filter_failure(_node: Node) -> int:
    # A sample filter function for use in filter tests.
    return 42

func test_get_version() -> void:
    assert_not_null(Utils.get_short_version())
    assert_not_null(Utils.get_bundle_version())
