# This script is used to rename files in Katorin's character assets folder from the export names in
# Mannequin so that it becomes easier to recognize which image names correspond to which expressions,
# and which positions/clothing styles. This also makes it easier to find in Godot/Dialogic.

import os
import logging

# Set up logging facilities.
logging.basicConfig(filename='rename.log',
                    encoding='utf-8',
                    level=logging.DEBUG)

# List all of the possible positions for this character.
POSITION_INDICES = {
    "armgrab_pigeontilted-": 1,
    "armsbehind_contrapposto-": 2,
    "armsbehind_knockkneed-": 3,
    "crossedarms_contrapposto-": 4,
    "doubleraisedloosegrasp_pigeon-": 5
}

# List all of the clothing styles, including hairstyles.
CLOTHING_STYLES = {
    "Default_Clothing_Style_No_Shoes-Default_Hairstyle": "a",
    "Default_Clothing_Style_No_Shoes-No_Ponytail": "b",
    "Default_Clothing_Style-Default_Hairstyle": "c",
    "Default_Clothing_Style-No_Ponytail": "d",
}

# Grab the relative path of the assets directory.
ASSET_PREFIX = os.path.join("assets", "characters", "katorin")

# Iterate through all of the files in the assets directory.
for file in os.listdir(ASSET_PREFIX):
    logging.info(f"Renaming {os.path.join(ASSET_PREFIX, file)}...")

    # Skip import files and non-PNG files.
    if not file.endswith(".png"):
        continue

    # Create a new copy of the filename to prevent mutability problems later.
    new_filename = file

    # Replace positions with their indicies.
    for position in POSITION_INDICES:
        if position not in new_filename:
            continue
        new_filename = new_filename.replace("Proto-" + position,
                                            str(POSITION_INDICES[position]))

    # Replace styles with their corresponding letters.
    for style in CLOTHING_STYLES:
        if style not in new_filename:
            continue
        new_filename = new_filename.replace(style, CLOTHING_STYLES[style])

    # Strip unnecessary information.
    if "Default_Expression" in new_filename:
        new_filename = new_filename.replace("Default_Expression", "default")
    if "Lipsync___" in new_filename:
        new_filename = new_filename.replace("Lipsync___", "")

    logging.info(
        f"{os.path.join(ASSET_PREFIX, file)} -> {os.path.join(ASSET_PREFIX, new_filename)}"
    )

    # Rename the file.
    os.rename(os.path.join(ASSET_PREFIX, file),
              os.path.join(ASSET_PREFIX, new_filename))
