# Marteau 🔨

Marteau is the utilities package used to automate development and build tasks for
_Indexing Your Heart_.

## What does Marteau do?

- **Markdown to Dialogic**: Convert an appropriately-formatted Markdown file into Dialogic JSON.
- **Easy Portrait Import**: Import a series of portraits into a Dialogic character sheet.

## Running from source

After cloning the main repository, run the following to build and run Marteau from the command line:

```
swift build
swift run marteau
```

> ⚠️ This has not been tested on Linux or Windows, though it should theoretically work on those
> platforms since Marteau is not directly relying on macOS-specific libraries such as Cocoa or
> AppKit.

## Command-line guide

Marteau contains several subcommands:

- `dialogue <markdown-path> <output-timeline-path>`: Convert a Markdown file into a Dialogic
  timeline. This does _not_ account for background image changes, sound changes, or signal
  emissions. This tool is designed to create a quick-start timeline where details can be added
  later.
    - Optional: `--characters <charpath>`: A path to a list of JSON files that contain character
      definitions in Dialogic format.
- `portraits <portraits-path>`: Import portrait definitions into Dialogic by reading from the
  portraits directory.

## Licensing

Marteau is a module contained in _Indexing Your Heart_ and is licensed under the Cooperative
Non-Violent Public License, v7 or later. You can read your rights in the provided LICENSE.md or at
https://git.pixie.town/thufie/npl-builder/src/branch/main/cnpl.md.
