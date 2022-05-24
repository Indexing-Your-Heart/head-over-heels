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

extends Node
# An autoload class containing utilities.
# These utilities have been ported from the C# equivalents in older versions.


func get_short_version() -> String:
    # Returns the human-readable version of the game.
    return ProjectSettings.get_setting("application/config/short_version")


func get_bundle_version() -> int:
    # Returns the game's bundle version.
    return ProjectSettings.get_setting("application/config/version")


func filter_children(
        node: Node, predicate: String, _reference: Node = null) -> Array:
    # Returns an array of children that meet a specified criteria.
    var children = []
    var predicate_ref = funcref(node, predicate) if _reference == null else \
        funcref(_reference, predicate)

    for child in node.get_children():
        var matcher = predicate_ref.call_func(child)
        if !(matcher is bool):
            _report_filter_error(matcher)
            return []
        if matcher == true:
            children.append(child)
    return children


func _report_filter_error(value) -> void:
    var variant_type = typeof(value)
    var actual_type = "Variant.Type(%d)" % (variant_type)
    if value is Spatial:
        actual_type = value.get_class()

    var error_msg = "Predicate return type 'bool' expected, " + \
        "got %s instead." % (actual_type)
    push_error(error_msg)


func todo(message: String = "") -> void:
    # Marks a given function or method as to be done, with an optional message.
    if !message.empty():
        push_warning("TODO: %s" % (message))
