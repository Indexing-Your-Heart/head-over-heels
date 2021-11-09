#!/bin/python3

# sort_dialogic_imports.py
# Copyright (C) 2021 Marquis Kurt <software@marquiskurt.net>
# This file is part of Indexing Your Heart.
#
# Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
# CNPLv7+ as found in the LICENSE file in the source code root directory or at
# <https://git.pixie.town/thufie/npl-builder>.
#
# Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
# details.

# This script is used to sort the character portrait names in the Dialogic character definitions. This should aid in
# finding a specified portait without having to scane the entire list. The default pose will remain at the top, but
# all other portraits will be sorted by the key's name.

from copy import deepcopy
import os
import json

# Set the directory to where the characters folder lies.
CHARACTER_PREFIX = os.path.join("dialogic", "characters")


def sort_portraits_by_key(character: dict) -> dict:
    """Returns a dictionary with the potraits sorted alphabetically."""
    new_dict = deepcopy(character)
    portraits: list = new_dict["portraits"]
    default = portraits.pop(0)
    new_dict["portraits"] = sorted(portraits, key=lambda por: por["name"])
    new_dict["portraits"].insert(0, default)
    return new_dict


# Iterate through all of the character files.
for file in os.listdir(CHARACTER_PREFIX):

    # Skip files not in the JSON format.
    if not file.endswith(".json"):
        continue

    # Open the character file and gran the JSON data as a dictionary.
    with open(os.path.join(CHARACTER_PREFIX, file), 'r') as char_file:
        char_dict = json.load(char_file)

    # Sort the dictionary.
    new_char_dict = sort_portraits_by_key(char_dict)

    # Overwrite the character file with the new dictionary.
    with open(os.path.join(CHARACTER_PREFIX, file), 'w') as char_file:
        json.dump(new_char_dict, char_file, indent=4)
