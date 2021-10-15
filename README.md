# Codename Katorin-Melrose

> Your colleague takes a week-long vacation, and she tasks you with taking over her work and
> watching over friend who's visiting. The challenges begin when her friend arrives at your doorstep
> in a candle costume, and she asks to date you. Are you able to keep up the work on your
> colleague's projects while fostering a romantic relationship with her friend?

**Codename Katorin-Melrose** is a re-implementation of _Codename Katorin_ using native Godot tools
à la C# and the Dialogic library. The primary objective of this project is to continue developing
the game without worrying about smaller developer details that could be easily re-implemented with
an addon.

> :warning: This project is still in its infancy, so some details and mechanics may not work as
> intended.

## Build from source

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

## Contributions

**Codename Katorin-Melrose** includes libraries and projects under open-source licenses:

- Dialogic: MIT License
- Godot: MIT License
- .NET Core: MIT License
