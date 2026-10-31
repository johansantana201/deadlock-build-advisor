-- Ranks items by how well they counter the threats an enemy team brings.
-- Score = sum of effectiveness for every (enemy hero, threat, counter item) match.
-- Ties are broken by cost, cheapest first.
-- Replace the hero names in the WHERE clause with the enemy team.
SELECT i.name AS item,
       i.cost,
       SUM(itr.effectiveness) AS score,
       STRING_AGG(h.name || ': ' || t.name, ', ') AS countered
FROM heroes h
JOIN hero_threats ht ON ht.hero_id = h.id
JOIN threats t ON t.id = ht.threat_id
JOIN item_threat_relationships itr ON itr.threat_id = t.id
JOIN items i ON i.id = itr.item_id
WHERE h.name IN ('Grey Talon', 'Vindicta')
GROUP BY i.id, i.name, i.cost
ORDER BY score DESC, i.cost ASC;
