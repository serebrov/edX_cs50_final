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
* Exit from the level activates once all dimonds are collected

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
* Tile: represents object on the map
* Base entity: rendered on the map, can move
* Player: entity with walk and idle states, handle collisions with rocks and diamonds

Levels should be data-driven, with map defined as Lua table (potentially could be read from the file, maybe in some structured format like JSON).

Entities (diamonds, rocks) have fixed characteristics and behavior, so no need to make them configurable on the map, we can just specify where to place them.

The level map can be defined like this:

```
  - -R RR--R-D--D
  - D- -RDRR---R-
  - R--R-DR--R-R-
  --RD--R-R-RR-RE
  --R-D-R----R---
  --R-D-R  R -  R
  --R-DD---R-- -R
```

Were:

* "-" - ground tile
* " " - empty tile
* "R" - rock
* "D" - diamond
* "E" - exit from the level

Related: [https://gamedev.stackexchange.com/a/139504](https://gamedev.stackexchange.com/a/139504).

Controls:

* Arrow keys: move the character
* Space key: start the game
* Esc: quit the game


## Implementation plan

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

# Current state

The implementation plan above is completed, we have:

* Four game states: start, play, you won, game over
* The map with text-based level definition, it is quite easy to add new levels
* Map tiles: ground, rock, diamond, exit, wall
* Entity class and player (the only entity at the moment)
* Player can "dig" the ground, collect diamonds and interact with an active exit tile to move to the next level
* Exit tile activates only after all diamonds are collected
* There is a diamond counter at the bottom of the screen
* Rocks and diamonds can fall down and kill the player

Keyboard controls:
* Space or Enter to start the game
* Arrow keys to control the character
* Esc to to go to the game over state from play or quit the game from other states (start, game over, game won)


# Code structure

Utility modules:
* Animation.lua - generic animation handling
* StateMachine.lua - state machine implementation
* Utils.lua - utility functions, currently `drawText`

Game setup:
* Dependencies.lua - `requre` statements to include all sources
* Resources.lua - definitions of textures, frames, fonts and sounds
* constants.lua - constants (width/height, speed settings, colors)

Game configuration:
* defs_entity.lua - entity configurations (player, tiles)
* defs_level.lua - level definitions

Game implementation:

* Game.lua - high-level game logic, game state machine and sound
* Level.lua - main game logic, parses level definition and manages updates and rendering
* Entity.lua - base class for movable entities (currently only player)
  * EntityWithState.lua - entity with state machine
* Player.lua - the game characher
* Tile.lua - base tile class, map tiles, exit tile, "no tile" (empty space)
* states/ folder - game and player states

# Possible future improvements

* Better graphics and sound
* The player can move rocks
* Extra life is given when collected N diamonds
* Two or more rocks or diamonds cannot sand on top of each other unless supported by ground, they start rolling and falling
* Add enemies that live in empty spaces
  * The enemy circles around the available empty space
* Add a timer to pass through the maze
* Add scoreboard state, allow entering name for the scoreboard
* Try automatic level generation, use GPT to generate more levels (describe the idea, probably use some JSON representation for the level, give examples, ask to generate more levels)
* If we have more levels: consider increasing number of lives.

