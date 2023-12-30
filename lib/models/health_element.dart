import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:flutter/material.dart';

class HealthElement {
  final String title;
  final String imagePath;
  final String onboardingRoute;
  final bool isActive;
  final List<ContentItem> assessments;
  final List<ContentItem> protocols;
  final List<ContentItem> learningCenter;

  HealthElement(
    this.title,
    this.imagePath,
    this.onboardingRoute,
    this.isActive,
    this.assessments,
    this.protocols,
    this.learningCenter,
  );
}

class ContentItem {
  final String title;
  final String description;
  final String route;
  final String imagePath;
  final Color? cardColor;
  final String? url;

  ContentItem({
    required this.title,
    required this.description,
    required this.route,
    required this.imagePath,
    this.cardColor,
    this.url,
  });
}

final List<HealthElement> elements = [
  HealthElement(
    "Brain Health",
    "lib/assets/images/cog_health.jpeg",
    "/brainCareOboarding",
    true,
    [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: AppConstants.brainCareShort,
        route: '/brainehealthquestionnaire',
        imagePath: 'lib/assets/images/memory_health.png',
        cardColor: AppTheme.primaryColor,
      ),
      ContentItem(
        title: "The CogHealth Screening Test'",
        description: "A short assessment of memory and cognitive function.",
        route: '/cognitive',
        imagePath: 'lib/assets/images/cog_health_test2.png',
        cardColor: const Color(0xE9FCAF3B),
      ),
    ],
    [
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: AppConstants.memoryEnhancement,
        route: '/eoOnboarding',
        imagePath: 'lib/assets/images/memory_health.png',
        cardColor: const Color(0xE9FCAF3B),
      ),
    ],
    [
      ContentItem(
        title: 'Essential oils, memory, and cognitive health',
        description: 'Learn',
        route: '/essentialOils',
        imagePath: 'lib/assets/images/dT_EO2.jpeg',
      ),
      ContentItem(
        title: 'Basic facts about brain health',
        description: '3 min',
        route: '/viewScreen',
        imagePath: 'lib/assets/images/brain_health_2.jpeg',
        url: 'https://powermeacademy.com/lessons/understanding-cognitive-health/',
      ),
      ContentItem(
        title: 'Lifestyle strategies for a health brain',
        description: '3 min',
        route: '/viewScreen',
        imagePath: 'lib/assets/images/brain_outdoor_dog.jpeg',
        url: 'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
      ),
    ],
  ),
  // HealthElement(
  //   "Sleep",
  //   "lib/assets/images/sleep.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // HealthElement(
  //   "Stress",
  //   "lib/assets/images/stress.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // HealthElement(
  //   "Gut Health",
  //   "lib/assets/images/gut.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // HealthElement(
  //   "Metabolic Health",
  //   "lib/assets/images/metabolic.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // HealthElement(
  //   "Healthy Aging",
  //   "lib/assets/images/aging.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // HealthElement(
  //   "Emotional Health",
  //   "lib/assets/images/emotional.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // HealthElement(
  //   "Functional Movement",
  //   "lib/assets/images/movement.jpeg",
  //   "/comingsoon",
  //   false,
  // ),
  // Add other elements here...
];
