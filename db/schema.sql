--Core Tables
CREATE TABLE heroes (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE items (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	cost INTEGER NOT NULL CHECK (cost >= 0)
);

CREATE TABLE threats (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	description TEXT
);

-- Which threats an enemy hero brings
CREATE TABLE hero_threats (
	id SERIAL PRIMARY KEY,
	hero_id INTEGER NOT NULL,
	threat_id INTEGER NOT NULL,

	UNIQUE(hero_id, threat_id),

	FOREIGN KEY(hero_id) REFERENCES heroes(id),
	FOREIGN KEY(threat_id) REFERENCES threats(id)
);

-- Matchup exceptions against a specific enemy hero (-3 = much worse than usual, +3 = much better)
CREATE TABLE item_hero_modifiers (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	hero_id INTEGER NOT NULL,
	modifier INTEGER NOT NULL CHECK (modifier BETWEEN -3 AND 3 AND modifier <> 0),
	reason TEXT NOT NULL,

	UNIQUE(item_id, hero_id),

	FOREIGN KEY(item_id) REFERENCES items(id),
	FOREIGN KEY(hero_id) REFERENCES heroes(id)
);

-- How well an item fits the player's own hero (1 to 3)
CREATE TABLE item_hero_synergies (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	hero_id INTEGER NOT NULL,
	synergy_strength INTEGER NOT NULL CHECK (synergy_strength BETWEEN 1 AND 3),
	reason TEXT,

	UNIQUE(item_id, hero_id),

	FOREIGN KEY(item_id) REFERENCES items(id),
	FOREIGN KEY(hero_id) REFERENCES heroes(id)
);

-- How well an item answers a threat (1 = helps a little, 2 = solid, 3 = core counter)
CREATE TABLE item_threat_relationships (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	threat_id INTEGER NOT NULL,
	effectiveness INTEGER NOT NULL CHECK (effectiveness BETWEEN 1 AND 3),
	reason TEXT,

	UNIQUE(item_id, threat_id),

	FOREIGN KEY(item_id) REFERENCES items(id),
	FOREIGN KEY(threat_id) REFERENCES threats(id)
);

-- Which items an upgrade is built from
CREATE TABLE item_components (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	component_item_id INTEGER NOT NULL,

	UNIQUE(item_id, component_item_id),
	CHECK (item_id <> component_item_id),

	FOREIGN KEY(item_id) REFERENCES items(id),
	FOREIGN KEY(component_item_id) REFERENCES items(id)
);
