# Game Design Document — Hamster Madness

---

## 1. General Information

### Game Name
Hamster Madness

### Genre
Roguelite top-down arena
Skill-based combat
Structured progression

### Inspirations
- The Binding of Isaac (room structure)
- Titan Souls (single resource risk)
- Mega Man X (boss upgrades)

### Platform
PC (Defold Engine)

### Target Run Duration
5–10 minutes per run

---

## 2. Description

A hamster is subjected to virtual simulations in a laboratory.
His only survival tool is a hamster ball that simultaneously
serves as a shield and as a weapon.

Every shot is a life-or-death decision:
throwing the ball means being completely vulnerable.

---

## 3. Core Concept

> 1 ball = shield + projectile + life.
> Throwing it = exposed.
> Recovering it = survival.

---

## 4. Core Loop

1. Enter simulation
2. Enemies spawn in closed room
3. Decide when to throw your only ball
4. Eliminate enemies or dodge
5. Recover ball manually
6. Clear room
7. Advance to next room
8. Face simulation boss
9. Obtain permanent upgrade
10. New harder simulation
11. Death → restart

---

## 5. Player

### Character: Hamster

#### Movement
- 8 directions
- Constant base speed

#### States

| State      | Visual                              | Behavior              |
|------------|-------------------------------------|-----------------------|
| Protected  | Hamster inside transparent ball     | Can absorb 1 hit     |
| Vulnerable | Hamster without ball                | 1 hit = death         |

#### Base Actions
- Move
- Throw ball (facing direction)
- Pick up ball (direct contact)

#### Unlockable Actions
- Parry (Turtle boss upgrade)
- Sonar (Bat boss upgrade)
- Spike Shield (Porcupine boss upgrade)
- Penetration (Cobra boss upgrade)

---

## 6. Ball System

### Intentional Shot (Player throws)

| Property        | Behavior                                      |
|-----------------|-----------------------------------------------|
| Direction       | Straight line, facing direction               |
| Speed           | Fast (~2x player speed)                       |
| Bounce          | No (base). Yes with upgrade                   |
| Penetration     | No (base). Yes with upgrade                   |
| Damage          | Yes                                           |

### Shield Lost by Enemy Hit

| Property        | Behavior                                      |
|-----------------|-----------------------------------------------|
| Direction       | Expelled in hit direction                     |
| Speed           | Slower than intentional shot                  |
| Damage          | No (base). Yes with Spike Shield upgrade      |
| Recovery        | Manual pickup required                        |

### Impact Results

| Scenario                        | Result                              |
|---------------------------------|-------------------------------------|
| Hits enemy and kills            | Ball falls near eliminated enemy    |
| Hits enemy but doesn't kill     | Ball falls immediately at impact    |
| Misses and hits wall            | Ball falls where it impacted        |

### Recovery
- Player must physically touch the ball
- Ball never returns automatically
- Ball never disappears from the world

### Fundamental Rule

> No upgrade shall eliminate the vulnerability
> of being without the ball.
> The ball ALWAYS separates from the player upon taking damage.

---

## 7. Damage System

### With Shield (Ball)
- Absorbs 1 hit
- Ball is expelled (speed < intentional shot)
- Expelled ball does NOT damage enemies (base)
- Expelled ball DOES damage enemies (with Spike Shield)
- Ball is recoverable from the ground

### Without Shield
- 1 hit = instant death

### Parry (if unlocked)
- Success → keeps shield + reflects projectile / stuns enemy
- Failure → loses shield normally

### Parry + Spike Shield
- Failed parry → loses spiked shield equally
- Spikes do NOT save from a failed parry

### Summary Table

| Situation                  | Result                                     |
|----------------------------|--------------------------------------------|
| Hit with shield            | Lose shield, ball expelled, recoverable    |
| Hit without shield         | Death                                      |
| Parry success              | Keep shield, reflect/stun                  |
| Parry failure              | Lose shield normally                       |
| Parry failure + spikes     | Lose spiked shield equally                 |
| Contact enemy + spikes     | Enemy takes damage, keep shield            |
| Expelled ball + spikes     | Expelled ball damages on contact           |

---

## 8. Room Design

### Normal Rooms
- Compact size
- Player crosses room in ~2 seconds
- Ball reaches opposite wall in ~1 second
- No 100% safe zone ever
- Doors locked until all enemies eliminated

### Boss Rooms
- Slightly larger than normal rooms
- Player crosses room in ~3 seconds
- Enough space for attack patterns
- No additional enemies (boss only)

---

## 9. Enemies

### MVP Enemies (2 types)

#### Chaser
| Property    | Value                          |
|-------------|--------------------------------|
| Behavior    | Directly pursues player        |
| Speed       | Moderate                       |
| HP          | 1 hit                          |
| Danger      | Dangerous in groups            |

#### Shooter
| Property    | Value                          |
|-------------|--------------------------------|
| Behavior    | Moves little, shoots slow      |
| Speed       | Slow                           |
| HP          | 2 hits                         |
| Danger      | Forces smart shield usage      |

### Future Enemies (Post-MVP)

| Enemy    | Key Behaviors                              |
|----------|--------------------------------------------|
| Hamsters | Collect balls, mimic player actions        |
| Snakes   | Grow when eating balls                     |
| Spiders  | Web, hang, sting                           |
| Roaches  | Quick bite                                 |
| Cats     | Speed, scratch                             |
| Bunnies  | Jump, stomp                                |
| Rats     | Speed, bite                                |
| Mice     | Speed, bite                                |
| Bees     | Fly, kamikaze                              |
| Hornets  | Fly, sting                                 |
| Moles    | Dig, scratch                               |
| Dogs     | Speed, destroy ball, bite                  |

---

## 10. Bosses

### Boss Upgrade System (Mega Man X style)

Each boss grants a permanent upgrade when defeated.
Upgrades expand options without eliminating core risk.

> Key Design Rule:
> Each boss demonstrates WHY you need its upgrade
> BEFORE giving it to you.

---

### Boss 1 — Turtle

**Theme:** Defense and patience

**Attacks:**

| Attack          | Description                                    | Counter                              |
|-----------------|------------------------------------------------|--------------------------------------|
| Bite            | Extends neck, surprising range                 | Dodge, respect distance              |
| Seismic slam    | Hits floor with shell, area damage             | Without parry → lose shield          |
|                 |                                                | With parry → negate                  |
| Shell hide      | Hides inside shell, invulnerable               | Wait, reposition                     |

**Phases:**

| Phase              | Behavior                                    |
|--------------------|---------------------------------------------|
| Phase 1 (100-50%)  | Alternates bite and shell hide              |
|                    | Occasional seismic slam                     |
| Phase 2 (50-0%)    | More aggressive                             |
|                    | Seismic slam more frequent                  |
|                    | Less time hiding in shell                   |

**Design Intent:**

> The seismic slam teaches the player
> they need a way to negate area damage.
> Defeating the boss grants exactly that: Parry.

**Upgrade: Parry**

| Property          | Value                                       |
|-------------------|---------------------------------------------|
| Activation        | Active button press                         |
| Window            | ~0.2 seconds                                |
| Success           | Reflects projectile or stuns enemy          |
| Failure           | Loses shield normally                       |

---

### Boss 2 — Bat

**Theme:** Darkness and information

**Attacks:**

| Attack              | Description                                | Counter                      |
|---------------------|--------------------------------------------|------------------------------|
| Darkness            | Reduces visibility partially               | Memorize patterns            |
| Teleport            | Appears at random position                 | React quickly                |
| Blind side attack   | Charges from off-screen                    | Central positioning          |

**Design Intent:**

> The boss demonstrates that lack of information kills.
> Defeating it grants the tool that solves
> exactly that problem.

**Upgrade: Sonar**

| Function              | Description                                |
|-----------------------|--------------------------------------------|
| Enemy HP bars         | Shows enemy health bars                    |
| Trap detection        | Reveals floor spikes and mines             |
| Hidden rooms          | Shows possible secret room access          |
| Cooldown              | Prevents abuse, tactical use only          |

**Sonar does NOT:**
- Deal damage
- Stun
- Slow

> Sonar is purely informational.

---

### Boss 3 — Porcupine

**Theme:** Dangerous contact

**Attacks:**

| Attack              | Description                                | Counter                      |
|---------------------|--------------------------------------------|------------------------------|
| Roll and charge     | Curls into ball and charges                | Dodge                        |
| Spike spray         | Fan-shaped projectiles                     | Shield or dodge              |
| Contact damage      | Touching boss deals damage                 | Keep distance                |

**Upgrade: Spike Shield**

| Property                | Behavior                                  |
|-------------------------|-------------------------------------------|
| Contact damage          | Melee enemies take damage touching shield |
| Expelled ball           | Lost shield ball ALSO deals damage        |
| Parry interaction       | Failed parry → lose spiked shield equally |
| Projectile protection   | Does NOT add projectile damage            |

---

### Boss 4 — Queen Bee (Phase 3)

**Theme:** Flight and venom

**Attacks:**

| Attack              | Description                                | Counter                      |
|---------------------|--------------------------------------------|------------------------------|
| Sting               | Moves through arena                        | Positioning                  |
| Minions             | Quick frontal attack                       | Dodge, attack                |
| Honey shots         | Honey shots that leave sticky ponds        | Find gaps                    |

**Upgrade: Penetration**
- Ball passes through 1 enemy before falling

---

## 11. Progression System

### Simulation Structure

### Permanent Progression (Roguelite)
- Boss upgrades are permanent between runs
- Difficulty scales with obtained upgrades
- New simulations unlock upon defeating bosses

### There is NO:
- Random items
- Shops
- Coins
- Upgrade RNG

> Progression is clean and predictable.

---

## 12. NPCs (Post-MVP)

| NPC      | Function                |
|----------|------------------------|
| Hamsters | Info, narrative context |
| Raccoon  | Trade, hints           |

---

## 13. Story

A hamster lives a peaceful life inside a cage
with food and water in a laboratory.

Different animals are used to create
virtual environments that test their adaptability
and simulate experiments to enhance their physical abilities.

The player controls the hamster that is used
to explore different virtual simulations
and evaluate if the improvements are ready
to be implemented in the real world.

### Narrative Justification

| Game Element      | Narrative Reason                              |
|-------------------|-----------------------------------------------|
| Each simulation   | A run                                         |
| Death             | Simulation failure → restart                  |
| Upgrades          | Data collected from experiments               |
| Bosses            | Other enhanced laboratory animals             |

---

## 14. Metrics (Initial Reference — Adjust with Playtesting)

| Parameter                | Suggested Value          |
|--------------------------|--------------------------|
| Player speed             | Medium                   |
| Ball speed (shot)        | Fast (~2x player)        |
| Ball speed (expelled)    | Slow (~0.5x shot speed)  |
| Normal room size         | ~2s to cross             |
| Boss room size           | ~3s to cross             |
| Parry window             | ~0.2s                    |
| Sonar duration           | ~2s                      |
| Sonar cooldown           | ~10s (adjust)            |
| Full run duration        | 5–10 minutes             |

---

## 15. Scope Control

### Phase 1 — MVP
- 8-direction movement
- 1 ball system (shield + projectile)
- Shield expulsion on hit
- 2 enemy types (Chaser, Shooter)
- 1 boss (Turtle → Parry)
- 4 rooms per run
- Death and restart system
- Placeholder art

### Phase 2
- Bat boss (Sonar)
- Porcupine boss (Spike Shield)
- Additional enemies
- Traps (spikes, mines)
- Final art
- Sound

### Phase 3
- Cobra boss (Penetration)
- NPCs
- Complete story
- Hidden rooms
- Final polish

---

## 16. Future Projects (Separate Games)

> These are NOT part of Hamster Madness.
> They are independent games in the same universe.

| Project              | Genre                    | Character   |
|----------------------|--------------------------|-------------|
| Squirrel Experiment  | Metroidvania             | Squirrel    |
| Mole Experiment      | Puzzle (Supaplex)        | Mole        |
| Otter Experiment     | Aquatic Metroidvania     | Otter       |
| Bat Experiment       | Echolocation / Stealth   | Bat         |

---

## 17. Bonus Games (Far Future)

> Possible expansions or independent games.

- Pong
- Arkanoid
- Frogger

---

## 18. Design Principles

1. **Simplicity first.** If it's not fun with 1 ball, it won't be fun with 10.
2. **Vulnerability is sacred.** No upgrade shall eliminate it.
3. **Every shot is a decision.** No spam.
4. **Skill over RNG.** The player improves, not the numbers.
5. **Less is more.** Only add when existing systems work.
6. **Bosses teach.** Each boss demonstrates why you need its upgrade.
7. **Information ≠ Power.** Knowing more doesn't make you invincible.
8. **The ball is physical.** It always exists in the world, never disappears magically.