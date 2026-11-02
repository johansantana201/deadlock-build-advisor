package com.johan.deadlock_build_advisor.recommendation;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class RecommendationController {

	// Same scoring as db/queries/recommend_items.sql, but returns one row per reason
	// (with the item's total score on every row) so the page can show each reason separately
	private static final String RECOMMEND_SQL = """
			SELECT item, cost, hero, reason, points, kind, score
			FROM (
				SELECT i.name AS item,
				       i.cost,
				       c.hero, c.reason, c.points, c.kind,
				       SUM(c.points) OVER (PARTITION BY i.id) AS score
				FROM (
					SELECT itr.item_id, h.name AS hero, t.name AS reason,
					       itr.effectiveness AS points, 'threat' AS kind
					FROM heroes h
					JOIN hero_threats ht ON ht.hero_id = h.id
					JOIN threats t ON t.id = ht.threat_id
					JOIN item_threat_relationships itr ON itr.threat_id = t.id
					WHERE h.name IN (:enemies)

					UNION ALL

					SELECT m.item_id, h.name AS hero, m.reason,
					       m.modifier AS points, 'matchup' AS kind
					FROM item_hero_modifiers m
					JOIN heroes h ON h.id = m.hero_id
					WHERE h.name IN (:enemies)
				) c
				JOIN items i ON i.id = c.item_id
			) ranked
			WHERE score > 0
			ORDER BY score DESC, cost ASC, item, hero, points DESC
			""";

	private final NamedParameterJdbcTemplate jdbc;

	public RecommendationController(NamedParameterJdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}

	// Example: GET /api/recommendations?enemies=Grey Talon,Vindicta
	@GetMapping("/recommendations")
	public List<Recommendation> recommend(@RequestParam List<String> enemies) {
		// Rows arrive already ranked; group them by item while keeping that order
		Map<String, Recommendation> byItem = new LinkedHashMap<>();
		jdbc.query(RECOMMEND_SQL, Map.of("enemies", enemies), row -> {
			int cost = row.getInt("cost");
			int score = row.getInt("score");
			Recommendation recommendation = byItem.computeIfAbsent(row.getString("item"),
					item -> new Recommendation(item, cost, score, new ArrayList<>()));
			recommendation.reasons().add(new Reason(
					row.getString("hero"),
					row.getString("reason"),
					row.getInt("points"),
					row.getString("kind")));
		});
		return new ArrayList<>(byItem.values());
	}
}
