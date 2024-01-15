import 'dart:ui';

class EssentialOilsModel {
  final EOScreenHeader header;
  final EOScreenArticles articles;
  final List<EOResearch> research;

  EssentialOilsModel({
    required this.header,
    required this.articles,
    required this.research,
  });
}

class EOScreenHeader {
  final String title;
  final String image;

  EOScreenHeader({
    this.title = '',
    this.image = '',
  });
}

class EOScreenArticles {
  final String title;
  final String description;
  final String image;
  final Color color;

  EOScreenArticles({
    this.title = '',
    this.description = '',
    this.image = '',
    this.color = const Color(0xFF000000),
  });
}

class EOResearch {
  final String title;
  final String description;
  final String image;
  final String link;
  final String url;

  EOResearch({
    this.title = '',
    this.description = '',
    this.image = '',
    this.link = '',
    this.url = '',
  });
}
