# Indexing Your Heart (Codename "Head Over Heels")

**Indexing Your Heart** is an upcoming visual novel/RPG mashup where you play as a software
engineer who has a secret admirer that you're actively dating who wears a hammer costume. The game
is a re-implementation of _Codename Katorin_ and _Codename Coyote Hammer_, using native Godot tools
à la C# and the Dialogic library. The primary objective of this project is to continue developing
the game without worrying about smaller developer details that could be easily re-implemented with
an addon.

> :warning: This project is still in its infancy, so some details and mechanics may not work as
> intended.

## Getting started: Build from source

**Required Tools**

- Godot 3.4 (Mono) or later
- .NET SDK 6 or later

Start by cloning the repository with `gh repo clone` and then open the project in Godot. Click
"Build" to build the solution and then click the Play button to run the game from within the Godot
editor.

### Building on Apple Silicon

To facilitate the build process for Apple Silicon Macs, the SDK build should be set to use the
dotnet CLI. Go to **Editor > Editor Settings > Mono > Builds** and change the build tool to
**dotnet CLI**. Godot will now build the project using the .NET SDK instead of Mono.

## Found an issue?

If you've found a bug or want to submit feedback to the project, it is encouraged that you submit a
report on our bug reporter on YouTrack. For sensitive information or security vulnerability reports,
email hello at indexingyourhe.art directly.

[File a bug report on YouTrack &rsaquo][youtrack]

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

[youtrack]: https://youtrack.marquiskurt.net/youtrack/projects/a26473ae-6133-4a9a-98bb-e230ba982f25
