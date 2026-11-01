package com.johan.deadlock_build_advisor.recommendation;

// One row of the scoring query: an item, its total score, and which enemy threats it answers
public record Recommendation(String item, int cost, int score, String countered) {
}
