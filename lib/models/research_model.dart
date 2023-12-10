import 'package:cog_screen/utilities/constants.dart';

class ResearchElement {
  final String title;
  final String description;
  final String image;
  final String link;

  ResearchElement(
    this.title,
    this.description,
    this.image,
    this.link,
  );
}

final List<ResearchElement> elements = [
  ResearchElement(
    "Overnight olfactory enrichment using an odorant diffuser improves memory and modifies the uncinate fasciculus in older adults",
    AppConstants.overnightOlfactory,
    'lib/assets/images/research1.jpeg',
    '/research',
  ),
  ResearchElement(
    "Lavender aromatherapy: A systematic review from essential oil quality and administration methods to cognitive enhancing effects",
    AppConstants.lavenderAromatherapy,
    'lib/assets/images/research2.jpeg',
    '/research',
  ),
  ResearchElement(
    "Essential Oils as A Potential Neuroprotective Remedy for Alzheimer's Disease",
    AppConstants.alheimersDisease,
    'lib/assets/images/research3.jpeg',
    '/research',
  ),
  ResearchElement(
    "The effect of the essential oils of lavender and rosemary on the human short-term memory",
    AppConstants.shortTermMemory,
    'lib/assets/images/research4.jpeg',
    '/research',
  ),
];
