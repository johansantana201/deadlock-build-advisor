#Deadlock Build Advisor

##Overview
Deadlock Build Advisor is a context-aware recommendation tool designed to help players decide which item to buy next during a match.

Instead of providing a fixed build order, the system evaluates potential items based on the current match situation. Factors such as the player's hero, the enemy heroes, everyones current items, available gold, and the player's main problem in the match can affect an item's relevance.

The goal is to provide recommendations along with understandable explanations for why an item may be useful in the current situation.

##Problem
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

##Goal

The goal of this project is to create a decision-support tool that evaluates potential item purchases based on the current match context and explains why each recommendation is relevant.

The system will not attempt to determine one objectively correct purchase. Instead, it will provide situational recommendations and explain the factors contributing to each item's relevance.

##MVP

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
Example

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

##Relevance Point System

The recommendation engine will use a rule-based scoring system.

An item's relevance score can be affected by several factors.

Enemy Hero Relevance

An item may receive points when it addresses a specific enemy hero.

For example:

Phantom Strike
    → Grey Talon: +1
    → Vindicta: +1
###Hero Synergy

An item may receive points when it is particularly useful for the player's selected hero.

Abrams
    → Phantom Strike: +1
###Threat Relevance

An item may receive points when it directly addresses the player's current problem.

Examples include:

Getting kited
Enemy healing
Getting burst down
Enemy crowd control
Difficulty reaching enemies
Difficulty surviving team fights
Other Factors

###Future versions may consider:

Affordability
Current inventory
Winning or losing
Teammate item functions
Upcoming objectives
Item redundancy

The exact scoring rules will be developed as the project progresses.

The points are intended to represent item relevance within the provided context, not an objectively correct purchase.

##Initial Scope

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

##Out of Scope for the MVP

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

Technology Stack
Java
Spring Boot
Maven
Spring Web
Spring Data JPA
PostgreSQL
REST API

A frontend framework may be added after the core backend and recommendation system are functional.

##Planned Database

The initial database will contain tables representing:

Heroes
Items
Threats
Item-Hero relationships
Item-Threat relationships

These relationships will provide the data used by the recommendation engine.

##Planned API

Initial endpoints will provide access to:

GET /api/heroes
GET /api/items
GET /api/threats
GET /api/item-hero-relationships
GET /api/item-threat-relationships

Recommendation endpoints will be added after the scoring system is implemented.

##Development Roadmap
###Phase 1 — Design, Database, and Project Setup
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

###Phase 2 — Recommendation Engine
Implement the relevance point system
Calculate item scores based on match context
Add hero-specific scoring
Add enemy-specific scoring
Add threat-based scoring
Generate explanations for recommendations
Return recommended items through the API

###Phase 3 — User Interface
Create hero selection
Create enemy selection
Create current inventory input
Create available gold input
Create threat/problem selection
Display recommendations and explanations

###Phase 4 — Improve Recommendation Logic
Add winning/losing context
Improve item alternatives
Add additional relationships
Handle edge cases
Improve recommendation explanations
Test different match scenarios

###Phase 5 — Testing and Polish
Test API endpoints
Test recommendation logic
Test database relationships
Improve frontend presentation
Fix bugs
Clean up code
Complete documentation
Prepare project demonstration
Future Ideas

###Possible future features include:

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