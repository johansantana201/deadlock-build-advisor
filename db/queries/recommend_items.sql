-- Ranks items by how well they counter an enemy team.
-- Each item's score is built from two kinds of points:
--   threat points:   effectiveness of the item against each threat an enemy brings
--   matchup points:  item_hero_modifiers exceptions for a specific enemy (-3 to +3)
-- Items whose total is 0 or less are left out. Ties are broken by cost, cheapest first.
-- Replace the hero names in both WHERE clauses with the enemy team.
SELECT i.name AS item,
       i.cost,
       SUM(c.points) AS score,
       STRING_AGG(c.hero || ': ' || c.reason || ' (' || c.points || ')', ', ') AS reasons
FROM (
	SELECT itr.item_id, h.name AS hero, t.name AS reason, itr.effectiveness AS points
	FROM heroes h
	JOIN hero_threats ht ON ht.hero_id = h.id
	JOIN threats t ON t.id = ht.threat_id
	JOIN item_threat_relationships itr ON itr.threat_id = t.id
	WHERE h.name IN ('Abrams', 'Vindicta')

	UNION ALL

	SELECT m.item_id, h.name AS hero, m.reason, m.modifier AS points
	FROM item_hero_modifiers m
	JOIN heroes h ON h.id = m.hero_id
	WHERE h.name IN ('Abrams', 'Vindicta')
) c
JOIN items i ON i.id = c.item_id
GROUP BY i.id, i.name, i.cost
HAVING SUM(c.points) > 0
ORDER BY score DESC, i.cost ASC;
