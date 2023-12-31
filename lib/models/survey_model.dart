class SurveyCategory {
  final String category;
  final String title;
  final List<SurveyCriterion> criteria;

  SurveyCategory({
    required this.category,
    required this.title,
    required this.criteria,
  });
}

class SurveyCriterion {
  final String description;
  final int rank;

  SurveyCriterion({
    required this.description,
    required this.rank,
  });
}
