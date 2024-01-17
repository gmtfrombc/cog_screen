class HealthElementImage {
  final String name;
  final String type;
  final String folder;
  String? url;
  HealthElementImage({
    required this.name,
    required this.type,
    required this.folder,
    this.url,
  });
  String get fullPath =>
      '/$folder/$name.$type'; // Full path to the image in Firebase Storage
}
