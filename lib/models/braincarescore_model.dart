class BrainCareCategory {
  final String category;
  final String title;
  final List<BrainCareCriterion> criteria;

  BrainCareCategory({
    required this.category,
    required this.title,
    required this.criteria,
  });
}

class BrainCareCriterion {
  final String description;
  final int rank;

  BrainCareCriterion({
    required this.description,
    required this.rank,
  });
}
