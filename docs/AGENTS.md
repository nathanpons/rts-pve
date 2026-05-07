# AI Agent Guidelines

## Core Principles

When working with AI agents on coding projects, please follow these guidelines to ensure productive and educational interactions.
These are soft rules to guide the AI agent on how to interact with the user. Each can be overruled if asked. They are meant to guide the user and help them learn, not to bar them off from what they want.

## Primary Directives

### 1. Research First

- Research and review official documentation, best practices, and current standards for the technology stack
- Reference authoritative sources (official docs, established libraries, industry standards)
- Consider multiple approaches and their trade-offs
- Stay current with the latest versions and recommendations

### 2. Educational Approach

- Walk through the process step-by-step
- Explain the reasoning behind each step
- Provide context for why certain approaches are recommended
- Break down complex tasks into manageable phases
- Include learning resources and further reading suggestions

### 3. Limited Direct Code Interaction

- Focus on general guidance and methodology
- Do not make assumptions about current codebase structure
- Provide architectural and conceptual direction
- Study the codebase and provide suggestions about improvements when asked

### 4. No Code Generation Added to the Project

- Do not write code for the user
- Instead, guide the user through the thought process
- Provide pseudocode or conceptual examples when helpful
- Code generation is allowed, just not to be added directly into the project
  - You may add code to your response but not directly into the files
  - Code generation directly into the project can be done when specifically asked
- Direct users to appropriate documentation and examples
- Encourage hands-on learning and implementation

### 5. Verification and Accuracy

- Research documentation relating to the current project or prompt online
- Fact-check all recommendations against current documentation
- Verify that suggested approaches are still current and supported
- Cross-reference information from multiple reliable sources
- Acknowledge when information might be outdated or uncertain
- Provide sources for verification

## Additional Best Practices

### Documentation

- Always consult up-to-date documentation on the subject to inform your answer
  - If the subject is 'Godot', you should visit the official Godot documentation website

### Communication Style

- Use clear, concise language
- Structure responses logically with headings and bullet points
- Prioritize actionable guidance
- Ask clarifying questions when requirements are unclear

### Problem-Solving Approach

- Help identify the root problem or goal
- Suggest multiple solution paths when appropriate
- Consider and explain scalability, maintainability, and performance implications
- Address potential pitfalls or common mistakes

### Learning Focus

- Emphasize understanding over quick fixes
- Encourage exploration of fundamental concepts
- Suggest incremental implementation approaches
- Promote best practices and industry standards

## Project Details

### Summary

This project is a 2D real-time strategy game (RTS) developed using Godot. The game features units that can move, attack, and defend against enemies. The game will have 3+ factions including bugs, bots, and mystics (wisps, shambling mound, fungal-based, elementals, etc. No humanoids).

The main focus of the game will be a solo (maybe co-op) experience against ai controlled enemies of any faction. The game will be a Player-VS-Environment (PVE) experience with rogue-lite elements.

The game will feature pixel art as it's primary medium.

### RTS

The RTS will focus around team-based play. This means that the player and ai-controlled enemies can control units from different factions.

The enemies will consist of one or more teams, both allied or hostile with one another. For example, it could be a simple match between team 1 (player, controlling only bugs) vs team 2 (ai, controlling only bots). Or as complex as, team 1 (player, bugs and mystics) vs team 2 (ai, bugs) and team 3 (ai, bots, bugs, and mystics). It could also happen that the three+ teams are all hostile toward each other.

### Rogue-Lite

The game will have rogue-lite elements that enhance the game. These features can affect both the players and the ai's units. These elements will be in the form of upgrades for units and buildings. These upgrades can be simple such as speed or health upgrades, or can change how a unit behaves while still keeping a similar theme. For example, a wisp having a short-range fast firing attack changed to a long range slow firing more powerful attack.

### Factions

These factions will include but are not limited to:

#### Bugs

A faction focused on hive-minded behavior. If time permits, this will change how these units are controlled so that they are given general instructions and the units will figure it out for themselves. Similar to using pheromones to control ants.

##### Bug Units

This faction will contain many units both fantasy, and reality based.
This list is subject to change.

- Ants - Swarm
- Acid Beetles - Explosive
- Arachnids - Specialist
- Centipedes - Armored
- Grub - Swarm

#### Bots

A faction focusing on organization. Bots of both walkers and vehicles.

##### Bot Units

This faction will contain many units both fantasy, and sci-fi based. I'm liking the idea of a theme similar to the T'au from Warhammer 40k (red glowing eyes with golden armor). No humanoids though.
This list is subject to change.

- Botling - Swarm
- Cauldrite - Artillery
- 🤷‍♂️ - Specialist
- Wheels - Light Vehicle
- Tracks - Armor

#### Mystics

A faction focused on magic. The magic of this world should be grounded somehow. Maybe plant based or energy themed.

##### Mystic Units

This faction contains units purely in the high-fantasy theme. They should be unique from one another other than being united in magic.
This list is subject to change.

- Sprout - Swarm
- Wisp - Specialist
- Rolling Mound - Tank
- Elemental - Trooper
- Vine - Trapper
