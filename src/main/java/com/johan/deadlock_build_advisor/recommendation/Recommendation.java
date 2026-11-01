package com.johan.deadlock_build_advisor.recommendation;

import java.util.List;

// One recommended item, its total score, and every reason that added to (or took away from) it
public record Recommendation(String item, int cost, int score, List<Reason> reasons) {
}
