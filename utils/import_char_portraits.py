#!/bin/python3

# import_char_portraits.py
# Copyright (C) 2021 Marquis Kurt <software@marquiskurt.net>
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
# CNPLv7+ as found in the LICENSE file in the source code root directory or at
# <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
# details.

# This script is used to re-import portraits that are located in the assets/characters folders into Dialogic, so that
# any subsequent updates are automatically handled. This is intended to speed up production of scripts.

from os import path
from copy import deepcopy
import os
import json
import sort_dialogic_imports

CHARACTER_PORT_PATH = path.join("assets", "characters")
CHARACTER_JSON_PATH = path.join("dialogic", "characters")


def make_portait_definition(character: str, file: str) -> dict:
    """Returns a portrait definition compatible with Dialogic

    Args:
        character (str): The name of the character the portait originates from
        file (str): The file name of the portrait to include

    Returns:
        portrait: The portrait definition that contains the name and the path
    """
    return {
        "name": file.removesuffix(".png"),
        path: f"res://{CHARACTER_PORT_PATH}/{character}/{file}"
    }


def make_character_portraits(character: str) -> list:
    """Returns a list of portraits for the specified character

    Args:
        character (str): The name of the character to fetch the portaits of

    Returns:
        portraits: The list of portrait definitions for Dialogic
    """
    stripped_char = character.lower().removeprefix("the ")
    if stripped_char not in os.listdir(CHARACTER_PORT_PATH):
        return [{"name": "Default", "path": ""}]
    portrait_files = [
        f for f in os.listdir(path.join(CHARACTER_PORT_PATH, stripped_char))
        if f.endswith("png")
    ]
    return [make_portait_definition(stripped_char, f) for f in portrait_files]


def replace_portraits(character_data: dict) -> dict:
    new_character_data = deepcopy(character_data)
    new_character_data["portaits"] = make_character_portraits(
        new_character_data["name"])
    return sort_dialogic_imports.sort_portraits_by_key(new_character_data)


if __name__ == "__main__":
    for file in os.listdir(CHARACTER_JSON_PATH):
        if not file.endswith(".json"):
            continue

        with open(path.join(CHARACTER_JSON_PATH, file), "r") as char_file:
            char_data = json.load(char_file)
        new_char_data = replace_portraits(char_data)
        with open(path.join(CHARACTER_JSON_PATH, file), "w") as char_file:
            json.dump(new_char_data, char_file, indent=4)
