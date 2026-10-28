INSERT INTO heroes(name)
VALUES ('Abrams'), ('Venator'), ('Grey Talon'), ('Lash'), ('Victor'), ('Shiv'), ('Calico'), ('Haze'),
	   ('Holliday'), ('Bebop'), ('Celeste'), ('Mina'), ('Vindicta');

INSERT INTO items(name, cost)
VALUES ('Healbane', 1600), ('Toxic Bullets', 3200),
	   ('Bullet Vest', 1600), ('Metal Skin', 3200),
	   ('Enchanter''s Emblem', 1600), ('Spirit Resilience', 3200),
	   ('Slowing Hex', 1600), ('Slowing Bullets', 1600),
	   ('Reactive Barrier', 1600), ('Indomitable', 6400),
	   ('Spirit Shielding', 1600), ('Weapon Shielding', 1600),
	   ('Knockdown', 3200), ('Phantom Strike', 6400),
	   ('Rebuttal', 800);

INSERT INTO threats(name, description)
VALUES ('High Sustain', 'Enemy has high self healing or is receiving healing'),
	   ('Weapon Damage', 'Enemy outputs steady weapon damage'),
	   ('Spirit Damage', 'Enemy outputs steady spirit damage'),
	   ('Melee Damage', 'Enemy is incentivized to throw out melees often'),
	   ('High Mobility', 'Enemy is hard to catch or escape from'),
	   ('Crowd Control', 'Enemy has stuns or displacements'),
	   ('Flight', 'Enemy can fly or hover in the air'),
	   ('Spirit Burst', 'Enemy can deal a high burst of spirit damage'),
	   ('Weapon Burst', 'Enemy can deal a high burst of weapon damage');
