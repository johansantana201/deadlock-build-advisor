# Deadlock Build Advisor

## Overview
Deadlock Build Advisor is a context-aware recommendation tool designed to help players decide which item to buy next during a match.

Instead of providing a fixed build order, the system evaluates potential items based on the current match situation. Factors such as the player's hero, the enemy heroes, everyones current items, available gold, and the player's main problem in the match can affect an item's relevance.

The goal is to provide recommendations along with understandable explanations for why an item may be useful in the current situation.

## Problem
Even experienced deadlock players have difficulty determining what item to purchase next because an item's usefulness depends heavily on the current match context.
A player may need to consider:

Their own hero
Enemy heroes
Their current items
Available gold
Problems they are experiencing in the match
Whether they are winning or losing
The functions already provided by teammates
Other situational factors

Although players can find information about individual heroes and items, they still have to manually combine this information to decide what purchase makes sense.

The core problem is that the player has access to the relevant information, but must manually determine how those pieces of information interact.

## Goal

The goal of this project is to create a decision-support tool that evaluates potential item purchases based on the current match context and explains why each recommendation is relevant.

The system will not attempt to determine one objectively correct purchase. Instead, it will provide situational recommendations and explain the factors contributing to each item's relevance.

## MVP

The minimum viable product will allow a player to:

Select their hero.
Select enemy heroes.
Enter their current items.
Enter their available gold.
Select their primary problem or threat in the match.
Optionally indicate whether they are currently winning or losing.

The system will then:

Evaluate potential item purchases.
Assign relevance points based on the current match context.
Present several relevant item recommendations.
Explain why each item received its points.
Show whether the item is currently affordable.
Provide alternative recommendations when appropriate.

### Example

A player selects:

Hero: Abrams
Enemies: Grey Talon and Vindicta
Problem: Difficulty reaching ranged enemies

The system could evaluate Phantom Strike as:

+1 because Grey Talon is on the enemy team
+1 because Vindicta is on the enemy team
+1 because the item synergizes with Abrams
Additional points may come from other relevant factors

The system would then explain why Phantom Strike is relevant rather than simply displaying it as part of a predetermined build.

## Scoring Model

The recommendation engine is a rule-based scoring system. Items are not scored against heroes directly. Instead, each enemy hero is described by the **threats** they bring, and each item is scored by how well it **answers** those threats.

### Threats

A threat is a problem an enemy can create, such as High Sustain, Flight, Weapon Burst or Hard Crowd Control. Each enemy hero is linked to the main threats they bring **with their most common build** (`hero_threats`). For example, Holliday is listed for Spirit Damage, not Weapon Damage, because she is usually built for spirit.

### Effectiveness

Each item is linked to the threats it counters, with an effectiveness score and a reason (`item_threat_relationships`):

| Score | Meaning |
|---|---|
| 1 | Helps a little |
| 2 | Solid answer |
| 3 | Core counter |

Only items that actually address a threat get a row. No row means the item does not help against that threat.

The scores follow a few consistent rules:

- **Passive resists** (Bullet Vest, Metal Skin, Plated Armor, Spirit Resilience) score high against **steady** damage and low against **burst**.
- **Shields** (Weapon Shielding, Spirit Shielding) score high against **burst** and low against **steady** damage.
- **Upgraded items score higher** than the items they are built from.

### Calculating a score

For a given enemy team:

1. Find every threat each enemy hero brings.
2. Find every item that counters each of those threats.
3. Add up the effectiveness for each item. If two enemies bring the same threat, the item counts for both, so items that answer several enemies rank higher.
4. Sort by score, highest first. Ties go to the cheaper item.

The query lives in [`db/queries/recommend_items.sql`](db/queries/recommend_items.sql).

### Example

Enemy team: **Grey Talon** (Flight, Spirit Burst, Soft Crowd Control) and **Vindicta** (Flight, Weapon Damage).

| Item | Score | Why |
|---|---|---|
| Knockdown | 6 | Flight 3 (Grey Talon) + Flight 3 (Vindicta) |
| Phantom Strike | 6 | Flight 3 (Grey Talon) + Flight 3 (Vindicta) |
| Slowing Hex | 4 | Flight 2 (Grey Talon) + Flight 2 (Vindicta) |

Both enemies fly, so anti-flight items take the top spots. Knockdown ranks above Phantom Strike because they tie on score and Knockdown is cheaper (3200 vs 6400).

### Not used in scoring yet

The schema already includes tables for these, but they are empty and the score does not use them yet:

- **Matchup modifiers** (`item_hero_modifiers`): exceptions for a specific enemy hero, from -3 to +3. For example, Rebuttal against a hero who melees constantly.
- **Hero synergy** (`item_hero_synergies`): how well an item fits the player's own hero, from 1 to 3.
- **Upgrade chains** (`item_components`): which items an upgrade is built from.

Later versions may also consider affordability, current inventory, winning or losing, and heroes with more than one common build.

The score represents how relevant an item is in the given matchup, not one objectively correct purchase.

## Initial Scope

The initial version will use a limited set of heroes, items, and relationships to demonstrate the recommendation system.

The project will initially focus on:

A small selection of heroes
A small selection of items
Common gameplay threats
Hero-item relationships
Threat-item relationships
Basic contextual scoring
REST API functionality
PostgreSQL data storage

The system will be designed so that additional heroes, items, and relationships can be added later without requiring a major redesign.

## Out of Scope for the MVP

The following features will not be required for the initial version:

Automatic live-game tracking
Automatic detection of the player's inventory
Automatic ultimate cooldown tracking
Automatic objective timing
Machine learning
AI-generated recommendations
Complete coverage of every possible matchup
A complete community build platform
Recreating Deadlock's existing build-planning functionality

These features may be considered for future versions if the core recommendation system is completed.

## Technology Stack
Java
Spring Boot
Maven
Spring Web
Spring Data JPA
PostgreSQL
REST API

A frontend framework may be added after the core backend and recommendation system are functional.

## Planned Database

The initial database will contain tables representing:

Heroes
Items
Threats
Item-Hero relationships
Item-Threat relationships

These relationships will provide the data used by the recommendation engine.

## Planned API

Initial endpoints will provide access to:

GET /api/heroes
GET /api/items
GET /api/threats
GET /api/item-hero-relationships
GET /api/item-threat-relationships

Recommendation endpoints will be added after the scoring system is implemented.

## Development Roadmap
### Phase 1 — Design, Database, and Project Setup
Define the exact MVP
Design the database schema
Create the Spring Boot Maven project
Connect Spring Boot to PostgreSQL
Create initial entities and tables
Add a small amount of hero, item, and threat data
Add initial item relationships
Create basic REST API endpoints

Week 1 Deliverable:

The API can retrieve heroes, items, threats, and their relationships from PostgreSQL.

### Phase 2 — Recommendation Engine
Implement the relevance point system
Calculate item scores based on match context
Add hero-specific scoring
Add enemy-specific scoring
Add threat-based scoring
Generate explanations for recommendations
Return recommended items through the API

### Phase 3 — User Interface
Create hero selection
Create enemy selection
Create current inventory input
Create available gold input
Create threat/problem selection
Display recommendations and explanations

### Phase 4 — Improve Recommendation Logic
Add winning/losing context
Improve item alternatives
Add additional relationships
Handle edge cases
Improve recommendation explanations
Test different match scenarios

### Phase 5 — Testing and Polish
Test API endpoints
Test recommendation logic
Test database relationships
Improve frontend presentation
Fix bugs
Clean up code
Complete documentation
Prepare project demonstration

## Future Ideas

### Possible future features include:

Full hero and item database
Team composition analysis
Teammate item analysis
Objective-based recommendations
Ultimate availability
Live match integration
Personal recommendation history
Match history analysis
More advanced recommendation rules
User accounts and saved builds