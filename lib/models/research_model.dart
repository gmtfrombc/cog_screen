class ResearchElement {
  final String title;
  final String description;
  final String image;
  final String link;
  final String url;

  ResearchElement(
    this.title,
    this.description,
    this.image,
    this.link,
    this.url,
  );
}

final List<ResearchElement> elements = [
  ResearchElement(
      "Overnight olfactory enrichment using an odorant diffuser improves memory and modifies the uncinate fasciculus in older adults",
      '4 min',
      'lib/assets/images/research1.jpeg',
      '/viewScreen',
      'https://powermeacademy.com/topic/study-on-olfactory-enrichments-in-older-adults/'),
  ResearchElement(
      "Lavender aromatherapy: A systematic review from essential oil quality and administration methods to cognitive enhancing effects",
      '3 min',
      'lib/assets/images/research2.jpeg',
      '/viewScreen',
      'https://powermeacademy.com/topic/a-review-of-essential-oils-and-the-nervous-system/'),
  ResearchElement(
      "Essential Oils as a Potential Neuroprotective Remedy for Alzheimer's Disease",
      '3 min',
      'lib/assets/images/research3.jpeg',
      '/viewScreen',
      'https://powermeacademy.com/topic/essential-oils-in-dementia/'),
  ResearchElement(
      "The effect of the essential oils of lavender and rosemary on the human short-term memory",
      '2 min',
      'lib/assets/images/research4.jpeg',
      '/viewScreen',
      'https://powermeacademy.com/topic/the-memory-boosting-effects-of-lavender-and-rosemary/'),
];
