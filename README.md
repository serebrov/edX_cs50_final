## The game

The game is similar to boulder dash ([https://boulder-dash.com/](https://boulder-dash.com/)).

The main character goes through levels where each level is a rectangular area filled with ground, rocks, diamonds and empty spaces.

Rules are:

* The character can move through empty space and dig through the ground
* Digging slows the character down
* Character cannot move (or dig) through the rock blocks
* Character can collect diamonds
* Diamonds and rocks fall down if there is empty space under them
* Dimonds and rocks do not fall if the player stays directly beneath it
* If the diamond collides with the character when falling down, character dies (and loses one life)
* If character collects all the diamonds, the labyrinth exit opens, if the character reaches it, it goes to the next level
* The player wins the game if the character goes through the last level
* The player looses if the character has no lives left

First implementation:

* The game has 3 levels, designed manually
* The character has 1 life
* The character can dig the ground
* The character can collect diamonds

Testing and improvements:

* Test and adjust rules if necessary
* The player can move rocks
* Extra life is given when collected N diamonds
* Two or more rocks or diamonds cannot sand on top of each other unless supported by ground, they start rolling and falling
* Add enemies that live in empty spaces
  * The enemy circles around the available empty space
* Add a timer to pass through the maze
* Add scoreboard state, allow entering name for the scoreboard
* See if it is easy enough to add more levels
    * Possible options: design more levels manually, implement automatic generation, use GPT to generate more levels (describe the idea, probably use some JSON representation for the level, give examples, ask to generate more levels)
* If we have more levels: consider increasing number of lives.

## Engine selection: Unity or Love2d

I prefer using Love2d for this project since we have good set of examples from the course and it should not be too difficult to implement the game with Love while it might still be useful to have a hands-on experience with Love on a larger project.

I feel like with Unity it would be more studying the editor, looking up the documentation and searching for typical Unity patterns and less programming this is still useful experience, but it is too Unity-specific.

With Love2d most of the things are happening in the code which is more useful in this case, since this is a development course.

Similarities with other Love2d course games:

* Zelda: we can move in 4 directions, monsters deduct lives
* Mario: we can collect coins, monsters deduct lives
* Match3: diamonds can fall down

## Technical spec

Game states:

* Start state: menu to start the game, "Enter" moves to the start state
* Play state: the game itself
* Win state: the "congratulations" message, "Enter" moves to the start state
* Game over state: the "game over" message, "Enter" moves to the start state

Game objects:

* Level
  * Has a map with tiles: empty, ground, rock, diamond, exit
* Base entity
* Character

Behaviours:

* Gravity - both rock and diamond have this, can fall down if there is space
* Consumable - diamonds are consumable

Levels should be data-driven, with map defined as Lua table (potentially could be read from the file, maybe in some structured format like JSON).

Entities (diamonds, rocks) have fixed characteristics and behavior, so no need to make them configurable on the map, we can just specify where to place them.

The data can look like this:

```
[ 
  [ "-", " ", "-", "R", " ", "R", "R", "-", "-", "R", "-", "D", "-", "-", "D" ],
  [ "-", " ", "D", "-", " ", "-", "R", "D", "R", "R", "-", "-", "-", "R", "-" ],
  [ "-", " ", "R", "-", "-", "R", "-", "D", "R", "-", "-", "R", "-", "R", "-" ],
  [ "-", "-", "R", "D", "-", "-", "R", "-", "R", "-", "R", "R", "-", "R", "E" ],
  [ "-", "-", "R", "-", "D", "-", "R", "-", "-", "-", "-", "R", "-", "-", "-" ],
  [ "-", "-", "R", "-", "D", "-", "R", " ", " ", "R", " ", "-", " ", " ", "R" ],
  [ "-", "-", "R", "-", "D", "D", "-", "-", "-", "R", "-", "-", " ", "-", "R" ],
]
```

Were:

* "-" - ground tile
* " " - empty tile
* "R" - rock
* "D" - diamond
* "E" - exit from the level

We can also consider using more compact text format, something like this:


```
  - -R RR--R-D--D
  - D- -RDRR---R-
  - R--R-DR--R-R-
  --RD--R-R-RR-RE
  --R-D-R----R---
  --R-D-R  R -  R
  --R-DD---R-- -R
```


It is also more readable: we can see on the example above that there are probably too many rocks on the level and it might be hard to navigate. This is less obvious in JSON representation.

Related: [https://gamedev.stackexchange.com/a/139504](https://gamedev.stackexchange.com/a/139504)	

Controls: the character should be controlled with arrow keys. Use space key to start the game.

Assets:

* Character
* Tiles: air, ground, rock, diamond
* Sounds
  * Start game
  * Dig the ground
  * Moving through the empty space (maybe no sound here?)
  * Falling rock
  * Consume diamond
  * Loose life
  * Background music (maybe, not necessary)

## Implementation

### Project initialization

Create game project - repository, initial files structure, libraries (knife, state machine).

### Start state

Intro screen with game title.
Pressing "Enter" transfers to the game state.

### Level: map, empty and ground tiles.

Implement level and map, game starts directly into the level.
Level has empty tiles and ground tiles.
Level definition is read from the table.

### Character: moving, digging

Add the character to the level.
The character can move through empty tiles and erase ground blocks.
The character moves through empty space faster then through the ground.

### Collecting diamonds

The player can collect diamonds by moving over them.
Moving over the diamond is faster then moving through the ground, but slower then moving through the empty tile.
There is a counter on the screen to show the number of collected diamonds.

### Diamonds and rocks: physics

Diamonds and rocks fall down if there is empty space under them.
The play can stand under the diamond or rock, it does not fall in this case.

### Scoring and next level

The exit tile starts "working" when the player collects all diamonds.
When the character moves over the working exit tile, the game transfers to the next level.
The game transfers to the "you won" state from the last level.

### Live and death

We have only 1 live for now.
If falling diamond or rock collides with the player, the game transfers to the "game over" state.

### End state (win and game over)

Add "you won" and and "gave over" states.
