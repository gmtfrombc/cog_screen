class HealthElement {
  final String title;
  final String imagePath;
  final String route;
  final bool isActive;

  HealthElement(
    this.title,
    this.imagePath,
    this.route,
    this.isActive,
  );
}

final List<HealthElement> elements = [
  HealthElement(
    "Brain Health",
    "lib/assets/images/cog_health.jpeg",
    "/brainCareOboarding",
    true,
  ),
  HealthElement(
    "Sleep",
    "lib/assets/images/sleep.jpeg",
    "/comingsoon",
    false,
  ),
  HealthElement(
    "Stress",
    "lib/assets/images/stress.jpeg",
    "/comingsoon",
    false,
  ),
  HealthElement(
    "Gut Health",
    "lib/assets/images/gut.jpeg",
    "/comingsoon",
    false,
  ),
  HealthElement(
    "Metabolic Health",
    "lib/assets/images/metabolic.jpeg",
    "/comingsoon",
    false,
  ),
  HealthElement(
    "Healthy Aging",
    "lib/assets/images/aging.jpeg",
    "/comingsoon",
    false,
  ),
  HealthElement("Emotional Health", "lib/assets/images/emotional.jpeg",
      "/comingsoon", false),
  HealthElement(
    "Functional Movement",
    "lib/assets/images/movement.jpeg",
    "/comingsoon",
    false,
  ),
  // Add other elements here...
];
