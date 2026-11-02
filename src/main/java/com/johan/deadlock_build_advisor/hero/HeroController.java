package com.johan.deadlock_build_advisor.hero;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class HeroController {

	private final JdbcTemplate jdbc;

	public HeroController(JdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}

	// Heroes for the enemy picker on the front end
	@GetMapping("/heroes")
	public List<Hero> heroes() {
		return jdbc.query("SELECT name, description FROM heroes ORDER BY name",
				(row, rowNum) -> new Hero(row.getString("name"), row.getString("description")));
	}
}
