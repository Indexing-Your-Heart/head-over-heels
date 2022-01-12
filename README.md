# Indexing Your Heart (Codename "Head Over Heels")

**Indexing Your Heart** is an upcoming visual novel/RPG mashup where you play as a software
engineer who has a secret admirer that you're actively dating who wears a hammer costume. The game
is a re-implementation of _Codename Katorin_ and _Codename Coyote Hammer_, using native Godot tools
à la C# and the Dialogic library. The primary objective of this project is to continue developing
the game without worrying about smaller developer details that could be easily re-implemented with
an addon.

> :warning: This project is still in its infancy, so some details and mechanics may not work as
> intended. If you'd like to support the project,
> [consider supporting the developers on Ko-fi][kofi].

[kofi]: https://ko-fi.com/marquiskurt

## Getting started: Build from source

**Required Tools**

- Godot 3.4 (Mono) or later
- .NET SDK 6 or later

**Optional Tools**

- Salmon 9 font family
- Swift 5.5 (or later) toolchain (or Xcode 13 or later)

Start by cloning the repository with `gh repo clone` and then open the project in Godot. Click
"Build" to build the solution and then click the Play button to run the game from within the Godot
editor.

### Building on Apple Silicon

To facilitate the build process for Apple Silicon Macs, the SDK build should be set to use the
dotnet CLI. Go to **Editor > Editor Settings > Mono > Builds** and change the build tool to
**dotnet CLI**. Godot will now build the project using the .NET SDK instead of Mono.

### Using Salmon 9 Fonts

By default, this project does _not_ include the Salmon 9 font family per its license agreement.
Instead, great open-source equivalents are provided so that the project builds and renders
correctly.

If you have purchased the Salmon 9 font family and want to use those fonts in the game, replace the
following files with the corresponding family variants:

- **Monospace** (`assets/fonts/mono.ttf`): Salmon Mono 9 Regular
- **Sans-serif** (`/assets/fonts/sans.ttf`): Salmon Sans 9 Regular
- **Serif** (`/assets/fonts/serif.ttf`): Salmon Serif 9 Regular

If you have not purchased the font and would like to do so, you can find the font on Phildjii's page
on Itch.io at https://phildjii.itch.io/salmon-family.

### Using the utilities package (Marteau)

The Marteau package (`utils`) includes utilities for handling helper functions such as:

- Updating build configurations
- Converting Markdown documents to Dialogic timelines
- Importing portraits into Dialogic quickly

More information how to build Marteau and its usage can be found in the documentation at
[utils/README.md](./utils/README.md).

> Note: You will need either a developer toolchain for Swift or Xcode as described in
> "Optional Tools" to build and run Marteau.

## Found an issue?

If you've found a bug or want to submit feedback to the project, it is encouraged that you submit a
report on our bug reporter on YouTrack. For sensitive information or security vulnerability reports,
email hello at indexingyourhe.art directly.

[File a bug report on YouTrack &rsaquo;][youtrack]

## Licensing

This project is licensed under the Cooperative Non-Violent Public License, v7 or later. You can
learn more about what your rights are by reading the [LICENSE.md](./LICENSE.md) file in full.

## Contributions

**Indexing Your Heart (Codename "Head Over Heels")** includes libraries and projects under
open-source licenses:

- Dialogic: MIT License
- Godot: MIT License
- .NET Core: MIT License

You can also view the full list of contributors in the [CONTRIBUTORS.md](./CONTRIBUTORS.md) file.

[youtrack]: https://youtrack.marquiskurt.net/youtrack/newIssue?project=HOH
