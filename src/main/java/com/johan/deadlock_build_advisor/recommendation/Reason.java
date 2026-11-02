package com.johan.deadlock_build_advisor.recommendation;

// One contribution to an item's score: which enemy, why, and how many points
// kind is "threat" (item counters a threat the hero brings) or "matchup" (hero-specific modifier)
public record Reason(String hero, String reason, int points, String kind) {
}
