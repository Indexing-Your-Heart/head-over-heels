---
title: Refreshing the Project (No Notches, I Swear)
layout: devlog
date: 2021-11-02
---

_Good morning!_ It's such an honor to show you today what I have been working on for the past couple of months. I'm pleased to present: **Indexing Your Heart**, with an all-new design, refreshed project specifications, and more. There's even an HDMI port included! And I think you're going to love it.

Apple event jokes aside, this is the first devlog for **Indexing Your Heart**, the game that will remain largely inspired by Codename Katorin, the visual novel and RPG combination about a secret admirer wearing a costume. A lot has happened since the last devlog, which I will now dub "Devlog 0", and I'm excited to talk about the changes since then.

## Project Structure and Toolchain

The prototypes for Codename Katorin were initially written in Kotlin, thanks to the [Godot Kotlin/JVM plugin](https://godot-kotl.in). Despite its limitations and alpha state, I was set on writing a good game with the in-development technology. However, I did realize a few things that made me change my mind:

- First, I'd have to create a Java Runtime Environment (JRE) for each platform. While that isn't terrible in and of itself, it would mean I'd have to rely on CI to make the builds and download them for distribution. Given that the project is not open-source (at least not currently), I'd be looking at some decent times for GitHub Actions to compile the builds.
- Installing various toolchains for Kotlin can be a bit expensive, ranging from installing Gradle to getting IntelliJ CE (or even Ultimate). Additionally, the latest version of the Godot Kotlin/JVM plugin doesn't support the latest version of IntelliJ (at least at the time of writing). I'd be stuck running the previous versions of IntelliJ until the team releases a new plugin version compatible with the version of IntelliJ I would have installed.
- Finally, while I vowed that I would not use C# for games in the future, I realized that the only way I was going to be faster in the language is if I used it more. My friend made this more evident when he started working on a web application with ASP.NET on his device.

Thankfully, I don't need to set up a fancy IDE like I have in the past to jumpstart the project. Simply downloading the Mono version of Godot, the .NET SDK, and the C# extensions for Visual Studio Code were enough for me to get up and running. I only had to spend at most half an hour to get everything set up, including changing the build tool in Godot over to .NET CLI instead of Mono (since Mono support is still a work in progress on Apple Silicon). With all the setup out of the way, I rewrote my existing scripts in C#, which took about a couple of hours.

Since I was coming back to C# in a more supported environment, I also decided to try out the [Dialogic plugin for Godot](https://dialogic.coppolaemilio.com), which provides a nice utility for writing dialogue without the hassle of generating dialogues boxes, writing a custom JSON format, etc. Although Dialogic doesn't have the same niceties that my older system with the DSL did, it will handle a lot of the things that my version did not have, such as animations and sounds. Since Dialogic uses JSON files to store data for dialogue and characters, this also lets me quickly add in portraits and other properties using Python scripts.

## An Overhauled Story

You may recall that I proposed the following to be the plot of the game from Devlog 0:

> The main plot revolves around you taking over her work for about a week while she goes on vacation. You're also tasked with watching over Katorin's friend who planned to visit, "Luma". The game will flip between the day cycle where you have to complete tasks (mechanics for this are to be determined), and the night cycle, where you interact and talk with Luma (the visual novel component). 

Up until a week or two ago, I kept this plot, thinking I'd be satisfied with it enough. However, I noticed that I started to get a little tired of the candle costume being reused across multiple projects, and I wanted to add something that will surprise people. After speaking with some colleagues and friends, I ultimately decided that I would change the story ever so slightly to keep the main premise, but provide some twists and turns. 

You and Katorin have recently finished a huge project at the company you work for, and you head to a bar that night to celebrate. After getting slammed with a couple of drinks, Katorin introduces you to the band that was performing that night, _The Serif_. While the lead singer ran out early to tend to personal matters, you manage to strike a conversation with the band, who Katorin is close friends with. Later that night, a mysterious figure shows up at the door in a hammer costume, explaining that they wanted to hand-deliver some mail to you in order to avoid paying for postage before promptly leaving. Upon opening the envelope, you discover a note with a phone number and a brief explanation of the figure's intent: getting a date out of you. Hesitantly, you text back and accept the offer. The game will follow with you meeting with this mysterious figure every Friday night.

I'm excited to bring this new plot to the table and give the project the push it needs to succeed. I plan to have the story written out by the end of the month so that I can focus on developing more of the core aspects of the game in the following months. 

---

I look forward to keeping you posted on future devlogs which talk about the story and other future developments to the title.