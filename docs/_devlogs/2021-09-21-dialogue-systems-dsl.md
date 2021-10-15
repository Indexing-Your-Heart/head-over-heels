---
title: "Dialogue Systems: Creating a Dialogue DSL in Kotlin"
layout: devlog
date: 2021-09-21
---
Welcome to the first devlog for **Codename Katorin**; there's not much about this project
I have discussed since a lot of it is still in its early stages. Story, mechanics,
visuals... that has yet to fully be determined. However, I am set on making a game that:

- is created with the [Godot engine](https://godotengine.org) and written entirely in
  [Kotlin](https://kotlinlang.org);
- mixes the visual novel genre with a different genre like RPG or action;
- represents a cultivation of some prototype ideas I've had for a while.

And today marks the first public announcement of my goals with this project. This game has
been brewing in the back of my head for a while (story-wise) and has gone through quite a 
couple iterations. I'm excited to bring this into fruition.

## What is this game, exactly?

At the current moment, **Codename Katorin** is a game where you play as one of Katorin's
colleagues (yes, that Katorin from Unscripted). The main plot revolves around you taking
over her work for about a week while she goes on vacation. You're also tasked with 
watching over Katorin's friend who planned to visit, "Luma". The game will flip between
the day cycle where you have to complete tasks (mechanics for this are to be determined),
and the night cycle, where you interact and talk with Luma (the visual novel component). 

I'm currently creating the game with a custom version of the Godot Engine which includes a
module that supports writing game scripts in Kotlin à la JVM (JVM being included in the
final game builds).  The project is pretty empty at this point, but I'm working on
implementing some more stuff and getting a prototype up and running.

## Dialogue scripting for Kotlin

Neither Godot nor Kotlin really support dialogue scripts in the same way that Ren'Py does,
which makes for a unique challenge. There are some add-ons and libraries that exist for
Godot to solve this problem, but compatibility with Kotlin seems questionable at best and
unlikely to work at worst. Rather than researching this, I decided to make my own system,
which breaks down into two parts:

- Writing Kotlin scripts that will generate a JSON file for Godot to read
- Reading that JSON file and parsing through the dialogue, displaying that on the screen

Ideally, I wanted to create a domain-specific language (DSL) that could generate a
dialogue script and let me shape out the dialogue in a declarative manner, supporting
writing dialogue blocks, changing images, and creating branches that let players make
a choice: 

```kotlin
buildScene {
	version(1)
	outputToFile("test.json")
	
	parts {
		val person = Character("John")
		dialogue {
			line(person.speak("Hello, world!"))
			line(person.speak("This is so much fun."))
		}
		
		branch {
			option("Test") {
				person.rename("Matt")
				line(person.speak("I am $person now."))
			}
		}
	}
}
```

Kotlin is a pretty flexible language that lets developers make DSLs thanks to language
features such as closures, function builders, and higher-order functions.

Take `Scene`, for instance. `Scene` is a custom class that I generated that holds basic
scene data:

```kotlin
class Scene(
	private var version: String = "1",
	private var outputPath: String = "",
	private var parts: ArrayList<ScenePart> = ...
) {
	
	fun version(versionId: Int) { ... }
	fun outputToFile(newPath: String) { ... }
}
```

We could use this to write a scene imperatively as follows:

```kotlin
val scene = Scene()
scene.version(1)
scene.outputToFile("test.json")
// Code for adding parts goes here.
```

This is still a bit verbose and may be harder to read through. It's also not really a DSL,
which goes against what I'm aiming for. Let's instead write a `buildScene` function that
handles this:

```kotlin
fun buildScene(builder: Scene.() -> Unit): Scene {
	val scene = Scene()
	builder.invoke(scene)
	return scene
}
```

`buildScene` takes in a single argument, `builder`, which is a function that takes in the
`Scene` class and runs calls we put inside the braces as if we're modifying that class
directly. I'm still unsure as to what the syntax means, but it's similar to the `with`
function:

```kotlin
with(scene) { ... }
```

We're able to now write our previous code in the following manner:

```kotlin
buildScene {
	version(1)
	outputToFile("test.json")
	
	// Code for adding parts goes here.
}
```

I won't delve into the specifics of how DSLs work in Kotlin, but this is the basic
building block that allowed me to create my own custom DSL. Most of the components I
needed were subclassed from `ArrayList` with some more convenient function names:

```kotlin
typealias DialoguePart = Map<String, String>

class DialogueBuilder: ArrayList<DialoguePart>() {
	fun narrate(line: String) {
		line(Character("narrator").speak(line))
	}
	fun line(dialogue: DialoguePart) {
		add(dialogue)
	}
	// Monologue is also a subclass of ArrayList.
	fun monologue(builder: Monologue.() -> Unit) {
		val mono = Monologue()
		builder.invoke(mono)
		mono.forEach { add(it) }
	}

}
```

## Making dialogue classes serializable

To export these classes as JSON, they needed to be serialized. The `kotlinx.serialization`
library offers this functionality and allows classes to be marked as serializable. There's
also some room for flexibility as to what fields get included and which ones don't. This
worked particularly well for `Scene`, which may contain certain types of data (but not
others):

```kotlin
@Serializable
@OptIn(ExperimentalSerializationApi::class)
class Scene(
	@Required private var version: String = "1",
	@Required private var parts: ArrayList<ScenePart> = ArrayList(),
	@Transient private var outputPath: String = ""
) { ... }
```

Writing this to JSON data was also particularly easy:

```kotlin
val scene = this
val format = Json { prettyPrint = true }
with(File(outputPath)) {
	writeText(format.encodeToString(scene))
}
```

Which then spits out a JSON file:

```json
{
  "version": "1",
  "parts": [
    {
      "kind": "DIALOGUE",
      "dialogue": [
        {"narrator":  "Hello, world!"},
        {
          "Player":  "Hey, all.",
          "image": "feetUpOnTable"
        }
      ]
    },
    {
      "kind": "BRANCH",
      "branch": [
        {
          "name": "Wave.",
          "dialogue": [
            {"narrator":  "I wave to everyone."}
          ]
        }
      ],
      "options": {
        "waitForAll": false
      }
    }
  ]
}
```

As a test, I've written up the first night scene in the game and have been able to check
that the JSON output is what I expected.

## Publishing to GitHub Packages

I did spend some time learning about how to publish Kotlin libraries through GitHub
Packages, which works with Gradle and other build systems for Java and/or Kotlin. I made
the package available on GitHub, which anyone is more than welcome to take a look at. It's
still a snapshot version since there's more I may add in the future.

[View kspeak package on GitHub &rsaquo;](https://github.com/alicerunsonfedora/kspeak)

---

I plan to discuss how I used the JSON data generated from the DSL to create the dialogue
and menu options in Godot like Ren'Py in the next devlog, since most of the work has been
there recently. 