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
			 ('Shiv', 'High Health'),
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
			 ('Bebop', 'High Health'),
			 ('Celeste', 'Spirit Damage'),
			 ('Celeste', 'High Mobility'),
			 ('Mina', 'Spirit Burst'),
			 ('Mina', 'High Mobility'),
			 ('Mina', 'Status Markers'),
			 ('Mina', 'High Sustain'),
			 ('Vindicta', 'Flight'),
			 ('Vindicta', 'Weapon Damage'))
			 AS v(hero_name, threat_name)
JOIN heroes h ON h.name = v.hero_name
JOIN threats t ON t.name = v.threat_name;
	   
INSERT INTO item_threat_relationships (item_id, threat_id, effectiveness, reason)
SELECT i.id AS item_id, t.id AS threat_id, v.effectiveness, v.reason
FROM (VALUES
			 --Anti Heal
			 ('Healbane',      'High Sustain', 3, 'Directly reduces enemy healing'),
             ('Toxic Bullets', 'High Sustain', 3, 'Anti-heal applied by your bullets'),
             ('Toxic Bullets', 'High Health', 2, 'Deals spirit percentage damage with bullet build up'),

			 --Weapon resistance: steady resists and active negation
             ('Bullet Vest', 'Weapon Damage', 2, 'Decent early-mid game passive bullet resists'),
             ('Bullet Vest', 'Weapon Burst', 1,  'Helps a negligible amount against burst, resists are more so for longer exchanges'),
             ('Metal Skin', 'Weapon Damage', 3,  'Provides passive resists and negates all weapon damage from guns and abilities upon activation'),
             ('Metal Skin', 'Weapon Burst', 3,   'Activation can be timed to completely negate a weapon burst combo'),

             -- Spirit resistance: steady resists and burst shields
             ('Enchanter''s Emblem', 'Spirit Damage', 2, 'Decent early-mid game passive spirit resists'),
             ('Enchanter''s Emblem', 'Spirit Burst', 1, 'Helps a little against burst, resists are more so for longer exchanges'),
             ('Spirit Resilience', 'Spirit Damage', 3, 'High passive spirit resists for sustained spirit pressure'),
             ('Spirit Resilience', 'Spirit Burst', 2, 'High resists noticeably reduce the size of a spirit combo'),
             ('Spirit Shielding', 'Spirit Burst', 3, 'Shield absorbs the bulk of a sudden spirit combo'),
             ('Spirit Shielding', 'Spirit Damage', 1, 'Shield helps once, but does little over a long exchange'),

             -- Weapon resistance: burst shield and late game armor
             ('Weapon Shielding', 'Weapon Burst', 3, 'Shield absorbs the bulk of a sudden weapon burst'),
             ('Weapon Shielding', 'Weapon Damage', 1, 'Shield helps once, but does little over a long exchange'),
             ('Plated Armor', 'Weapon Damage', 3, 'Large late game bullet resists against sustained gun damage'),
             ('Plated Armor', 'Weapon Burst', 2, 'High resists reduce the size of a weapon burst'),

             -- Anti-mobility and anti-flight
             ('Slowing Hex', 'High Mobility', 3, 'Slows and shuts down movement abilities to stop escapes and engages'),
             ('Slowing Hex', 'Flight', 2, 'Slowing a flying enemy makes them much easier to hit'),
             ('Slowing Bullets', 'High Mobility', 2, 'Constant slow on hit, but does not prevent the usage of movement abilities'),
             ('Slowing Bullets', 'Flight', 1, 'Slow helps track flying enemies but does not bring them down'),
             ('Knockdown', 'Flight', 3, 'Pulls flying or hovering enemies back to the ground and the stun time scales with enemy height'),
             ('Knockdown', 'High Mobility', 1, 'Delayed stun can interrupt a mobile enemy if timed well'),
             ('Phantom Strike', 'Flight', 3, 'Teleports to the target and brings them down from the air'),
             ('Phantom Strike', 'High Mobility', 2, 'Gap closer that lets you catch enemies who try to escape'),
             ('Enduring Speed', 'High Mobility', 2, 'Extra move speed to keep up with or escape mobile enemies'),
             ('Enduring Speed', 'Soft Crowd Control', 2, 'Reduces the impact of slows'),

             -- Crowd control and debuffs
             ('Reactive Barrier', 'Hard Crowd Control', 2, 'Grants a barrier when immobilized so you survive the follow-up'),
             ('Indomitable', 'Hard Crowd Control', 3, 'Activation makes you immune to sudden stuns and displacements'),
             ('Indomitable', 'Soft Crowd Control', 2, 'Immunity also blocks most slows and silences while active'),
             ('Debuff Reducer', 'Soft Crowd Control', 3, 'Shortens slows, silences and other debuffs'),
             ('Debuff Reducer', 'Status Markers', 2, 'Damage-over-time and stacking effects wear off faster'),
             ('Debuff Reducer', 'Hard Crowd Control', 1, 'Shortens stun duration slightly'),
             ('Dispel Magic', 'Status Markers', 3, 'Removes damage-over-time effects and debuff stacks entirely'),
             ('Dispel Magic', 'Soft Crowd Control', 3, 'Cleanses slows, silences and other active debuffs'),

			 -- Anti-tank: percent damage and resist reduction
             ('Tankbuster', 'High Health', 3, 'Bonus damage based on the enemy''s max health, scales up against bulky targets'),
             ('Decay', 'High Health', 3, 'Deals damage as a percentage of max health over time'),
             ('Decay', 'High Sustain', 2, 'Reduces the target''s healing while the decay is active'),
             ('Armor Piercer', 'High Health', 3, 'Cuts through bullet resists that make tanky enemies hard to kill'),
             ('Weakening Headshot', 'High Health', 2, 'Headshots reduce the target''s bullet resist for your team'),
             ('Crippling Headshot', 'High Health', 3, 'Headshots heavily reduce both bullet and spirit resists'),
			 ('Crippling Headshot', 'High Sustain', 3, 'Reduces incoming healing upon landing a headshot'))
     AS v(item_name, threat_name, effectiveness, reason)
JOIN items i ON i.name = v.item_name
JOIN threats t ON t.name = v.threat_name;