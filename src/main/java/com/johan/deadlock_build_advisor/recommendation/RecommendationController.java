package com.johan.deadlock_build_advisor.recommendation;

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

	// Same query as db/queries/recommend_items.sql, with the enemy list as a parameter
	private static final String RECOMMEND_SQL = """
			SELECT i.name AS item,
			       i.cost,
			       SUM(itr.effectiveness) AS score,
			       STRING_AGG(h.name || ': ' || t.name, ', ') AS countered
			FROM heroes h
			JOIN hero_threats ht ON ht.hero_id = h.id
			JOIN threats t ON t.id = ht.threat_id
			JOIN item_threat_relationships itr ON itr.threat_id = t.id
			JOIN items i ON i.id = itr.item_id
			WHERE h.name IN (:enemies)
			GROUP BY i.id, i.name, i.cost
			ORDER BY score DESC, i.cost ASC
			""";

	private final NamedParameterJdbcTemplate jdbc;

	public RecommendationController(NamedParameterJdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}

	// Example: GET /api/recommendations?enemies=Grey Talon,Vindicta
	@GetMapping("/recommendations")
	public List<Recommendation> recommend(@RequestParam List<String> enemies) {
		return jdbc.query(RECOMMEND_SQL, Map.of("enemies", enemies),
				(row, rowNum) -> new Recommendation(
						row.getString("item"),
						row.getInt("cost"),
						row.getInt("score"),
						row.getString("countered")));
	}
}
