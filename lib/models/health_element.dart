class HealthElement {
  final String title;
  final String imagePath;
  final String route;

  HealthElement(
    this.title,
    this.imagePath,
    this.route,
  );
}

final List<HealthElement> elements = [
  HealthElement(
    "Brain Health",
    "lib/assets/images/cog_health.jpeg",
    "/coghealthonboarding",
  ),
  HealthElement(
    "Sleep",
    "lib/assets/images/sleep.jpeg",
    "/comingsoon",
  ),
  HealthElement(
    "Stress",
    "lib/assets/images/stress.jpeg",
    "/comingsoon",
  ),
  HealthElement(
    "Gut Health",
    "lib/assets/images/gut.jpeg",
    "/comingsoon",
  ),
  HealthElement(
    "Metabolic Health",
    "lib/assets/images/metabolic.jpeg",
    "/comingsoon",
  ),
  HealthElement(
    "Healthy Aging",
    "lib/assets/images/aging.jpeg",
    "/comingsoon",
  ),
  HealthElement(
    "Emotional Health",
    "lib/assets/images/emotional.jpeg",
    "/comingsoon",
  ),
  HealthElement(
    "Functional Movement",
    "lib/assets/images/movement.jpeg",
    "/comingsoon",
  ),
  // Add other elements here...
];
