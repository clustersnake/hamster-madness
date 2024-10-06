# Game Design Document

## Game name 
Hamster Madness

## Description
This game is a snake like game starting with a hamster that collects hamster balls to create a long line of balls that can be used in different forms like shooting ammo, mines, shields and maybe more.

## Characters

### Player 
The player will control a hamster that walks in 4 directions and collects hamster balls.

### Enemies 
- Hamsters: Can collect hamster balls and will perform the same actions as the player.
- Snakes: Will grow every time they eat a ball, a hamster or an enemy.
- Spiders: web, hang, sting.
- Roaches: byte.
- Cats: speed, throw ball, scratch.
- Bunnies: jump, speed, throw ball, stomp.
- Rats: speed, byte, use two balls.
- Mice: speed, byte, use one ball.
- Bees: fly, speed, kamikaze.
- Hornets: fly, speed, sting.
- Moles: dig, hole, throw ball, scratch.
- Dogs: speed, destroy ball, byte.

### NPCs
- Hamsters: Trade, info
- Racoon: Trade, info


### Bosses
#### 1. Bugs
Theme: Space invaders
- Bee nest:     Battle: Space invaders. Attack: kamikaze, Shoot. Power up: Shooting
- Wasp nest:    Battle: Space invaders. Attack: sting.           Power up: Plasma sword
- Spider Queen: Battle: Space invaders. Attack: Poison.          Power up: Poison

#### 2. Mammals
Theme Asteroids
- Dog Pack:     Battle: Asteroids.      Attack: byte.
- Wolf Pack:    Battle: Asteroids.      Attack: byte.

#### 3. Diggers
Theme: Zelda classic
- Mole King:    Battle: Zelda.          Attack: Mines, scratch.  Power up: Explosive mines
- Rat King:     Battle: Zelda.          Attack: Saw.             Power up: Saw

#### 4. Reptiles
Theme: Snake
- Cobra:        Battle: Snake, spits,                            Power up: Stack Balls

### Power ups

- Armadillo:    Battle: Bouncing(sonic) Attack: Roll, parry.     Power up: Parry
- Turtle:       Battle:                                          Power up: Shield
- Hawk:         Battle:                                          Power up: Map?
- Bat:          Battle:                                          Power up: Map? Echo?


## Mechanics
- The player will collect hamster balls randomly placed in the game board.
- The first ball will automatically be used as a shield and will be used as a regular hamster ball.
- If the player's shield is destroyed and has more balls, then a ball will be used as a new shield after a short period of time.
- The player will be able to shoot the hamster ball at any time in the direction the player is facing.
- Can make charged shots that use extra balls.
- Can make parrys that won't deplete the current shield.
- The player may drop the hamster ball and use it as a land mine in any time, the land mine may be shot in any direction the player is facing or can be dropped in the place occupied by the player.
- The more hamster balls are being collected, the more the tail will grow.
- The player can collide with the balls line but will lose two balls, one for the shield and one for the ball being hit.
- The remaining balls left after being hit by the player can be recovered by the player.
- The mines and shoots can cut the "snake's" body at any time and missing balls can be recovered by the player.
- Some Enemies will interact with the inactive snakes's tail.

### Abilities
- Bat: Echo
- Otter: Swim
- Gecko: Climb
- Turtle: Charged Shield
- Armadillo: Parry
- Snake: Grow a tail


## Story
A hamster lives a peacefull life inside a cage with food and water in a laboratory. A big earthquake shakes the building and damages the building, breaks all cages and sets free all the animals product of the experiments.
The player starts at the top of the building and has to fight against many of the experiments. Not all the experiments are hostile, 


## Progress
The player will start in a board where can pick up a single ball, after picking it up, the ball will surround it and a message will show him about how blocking and shooting the ball. 


## Bonus games
Earned when special coins are found
- Pong
- Arkanoid
- Frogger
