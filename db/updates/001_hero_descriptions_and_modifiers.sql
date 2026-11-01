-- One-time update for a database created before hero descriptions and matchup modifiers.
-- A fresh database built from schema.sql and seed.sql already has these changes.

ALTER TABLE heroes ADD COLUMN description TEXT;

UPDATE heroes h
SET description = v.description
FROM (VALUES ('Abrams', 'Tanky brawler who charges in, stuns and heals himself through long fights'),
			 ('Venator', 'Gunner with steady and burst weapon damage, plus damage over time from his grenade'),
			 ('Grey Talon', 'Long-range archer who bursts from afar, slows enemies and takes to the air'),
			 ('Lash', 'Diver who leaps in from above, slams enemies and lifts the team into the air'),
			 ('Victor', 'Durable spirit caster who heals himself while dealing steady spirit damage'),
			 ('Shiv', 'Slippery assassin who stacks bleed with knives and finishes low health targets'),
			 ('Calico', 'Spirit assassin who bursts targets and stacks damage over time'),
			 ('Haze', 'Stealthy gunner who sleeps a target, then shreds them with weapon burst'),
			 ('Holliday', 'Mobile spirit caster with launch pads, explosives and crowd control'),
			 ('Bebop', 'Hooks enemies into his team and melts them with weapon and spirit damage'),
			 ('Celeste', 'Mobile spirit caster who keeps up steady spirit pressure'),
			 ('Mina', 'Mobile spirit assassin who stacks effects and bursts targets down'),
			 ('Vindicta', 'Flies above fights and snipes with heavy weapon damage'))
	 AS v(name, description)
WHERE h.name = v.name;

INSERT INTO item_hero_modifiers (item_id, hero_id, modifier, reason)
SELECT i.id, h.id, v.modifier, v.reason
FROM (VALUES
			 ('Plated Armor', 'Abrams', -2, 'Most of Abrams'' weapon damage comes from melee, so plated armor does little against him'))
	 AS v(item_name, hero_name, modifier, reason)
JOIN items i ON i.name = v.item_name
JOIN heroes h ON h.name = v.hero_name;
