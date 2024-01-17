class ResultsInfoModel {
  final String title;
  final String introText;
  final List<ResultListItem> resultListItems;
  final String imagePath;
  final String conclusionText;

  ResultsInfoModel({
    required this.title,
    this.introText = "",
    this.imagePath = "",
    this.resultListItems = const [],
    this.conclusionText = "",
  });
}


class ResultListItem {
  final String boldText;
  final String regularText;

  ResultListItem({
    this.boldText = "",
    this.regularText = "",
  });
}
