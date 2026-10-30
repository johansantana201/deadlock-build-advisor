INSERT INTO heroes(name)
VALUES ('Abrams'), ('Venator'), ('Grey Talon'), ('Lash'), ('Victor'), ('Shiv'), ('Calico'), ('Haze'),
	   ('Holliday'), ('Bebop'), ('Celeste'), ('Mina'), ('Vindicta');

INSERT INTO items(name, cost)
VALUES ('Healbane', 1600), ('Toxic Bullets', 3200), 
	   ('Bullet Vest', 1600), ('Metal Skin', 3200), 
	   ('Enchanter''s Emblem', 1600), ('Spirit Resilience', 3200),
	   ('Slowing Hex', 1600), ('Slowing Bullets', 1600),
	   ('Reactive Barrier', 1600), ('Enduring Speed', 1600), 
	   ('Spirit Shielding', 1600), ('Weapon Shielding', 1600),
	   ('Knockdown', 3200), ('Phantom Strike', 6400),
	   ('Dispel Magic', 3200), ('Debuff Reducer', 1600),
	   ('Plated Armor', 6400), ('Indomitable', 6400),
	   ('Tankbuster', 3200), ('Decay', 3200),
	   ('Armor Piercer', 6400), ('Weakening Headshot', 1600),
	   ('Crippling Headshot', 6400);

INSERT INTO threats(name, description)
VALUES ('High Sustain', 'Enemy has high self healing, shielding, or is receiving external healing'),
	   ('Weapon Damage', 'Enemy outputs steady weapon damage'),
	   ('Spirit Damage', 'Enemy outputs steady spirit damage'),
       ('High Mobility', 'Enemy is hard to catch or escape from'),
	   ('Soft Crowd Control', 'Enemy can restricts actions, abilities, or speed, but still allows the player to manually walk around'),
	   ('Hard Crowd Control', 'Enemy strips away a player''s ability to move with stuns, or can forcefully displace them'), 
	   ('Flight', 'Enemy can fly or hover in the air'), 
	   ('Spirit Burst', 'Enemy can deal a high burst of spirit damage'),
	   ('Weapon Burst', 'Enemy can deal a high burst of weapon damage'),
	   ('Status Markers', 'Enemy deals damage over time or builds up effect stacks to deal damage and/or apply debuffs'),
	   ('High Health', 'Enemy has high effective hp from either resists, high base hp, or high hp boon scaling');

INSERT INTO hero_threats (hero_id, threat_id)
SELECT h.id AS hero_id, t.id AS threat_id
FROM (VALUES ('Abrams', 'High Sustain'),
			 ('Abrams', 'Weapon Damage'),
			 ('Abrams', 'Hard Crowd Control'),
			 ('Abrams', 'High Health'),
             ('Lash', 'Flight'),
			 ('Lash', 'Spirit Burst'),
			 ('Lash', 'Hard Crowd Control'),
			 ('Lash', 'High Mobility'),
			 ('Lash', 'High Health'),
			 ('Venator', 'Weapon Damage'),
			 ('Venator', 'Weapon Burst'),
			 ('Venator', 'Status Markers'),
			 ('Grey Talon', 'Flight'),
			 ('Grey Talon', 'Spirit Burst'),
			 ('Grey Talon', 'Soft Crowd Control'),
			 ('Victor', 'High Sustain'),
			 ('Victor', 'Spirit Damage'),
			 ('Shiv', 'Spirit Burst'),
			 ('Shiv', 'High Mobility'),
			 ('Shiv', 'Status Markers'),
			 ('Shiv', 'High Sustain'),
			 ('Calico', 'Spirit Burst'),
			 ('Calico', 'Status Markers'),
			 ('Haze', 'Weapon Damage'),
			 ('Haze', 'Weapon Burst'),
			 ('Haze', 'Hard Crowd Control'),
	   		 ('Holliday', 'High Mobility'),
			 ('Holliday', 'Spirit Damage'),
			 ('Holliday', 'Hard Crowd Control'),
			 ('Bebop', 'Hard Crowd Control'),
			 ('Bebop', 'Weapon Damage'),
			 ('Bebop', 'Status Markers'),
			 ('Bebop', 'Spirit Damage'),
			 ('Celeste', 'Spirit Damage'),
			 ('Celeste', 'High Mobility'),
			 ('Mina', 'Spirit Burst'),
			 ('Mina', 'High Mobility'),
			 ('Mina', 'Status Markers'),
			 ('Vindicta', 'Flight'),
			 ('Vindicta', 'Weapon Damage'))
			 AS v(hero_name, threat_name)
JOIN heroes h ON h.name = v.hero_name
JOIN threats t ON t.name = v.threat_name;