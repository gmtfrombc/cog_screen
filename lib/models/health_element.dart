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

  HealthElement({
    required this.title,
    required this.imagePath,
    required this.onboardingRoute,
    required this.isActive,
    required this.assessments,
    required this.protocols,
    required this.learningCenter,
  });
}

class ContentItem {
  final String title;
  final String description;
  final String route;
  String imageUrl; // Changed to non-final to update later
  final Color? cardColor;
  final String? url;

  ContentItem({
    required this.title,
    required this.description,
    required this.route,
    required this.imageUrl,
    this.cardColor,
    this.url,
  });
}

final List<HealthElement> elements = [
  HealthElement(
    title: "Brain Health",
    imagePath: "lib/assets/images/cog_health.jpeg",
    onboardingRoute: "/brainCareOboarding",
    isActive: true,
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: AppConstants.brainCareShort,
        route: '/brainehealthquestionnaire',
        imageUrl: 'memory_health',
        cardColor: AppTheme.primaryColor,
      ),
      ContentItem(
        title: "The CogHealth Screening Test'",
        description: "A short assessment of memory and cognitive function.",
        route: '/cognitive',
        imageUrl: 'cog_health_test2',
        cardColor: const Color(0xE9FCAF3B),
      ),
    ],
    protocols: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: AppConstants.memoryEnhancement,
        route: '/eoOnboarding',
        imageUrl: 'memory_protocol',
        cardColor: const Color(0xE9FCAF3B),
      ),
    ],
    learningCenter: [
      //learning center
      ContentItem(
        title: 'Essential oils, memory, and cognitive health',
        description: 'Learn',
        route: '/essentialOils',
        imageUrl: 'dt_EO2',
      ),
      ContentItem(
        title: 'Basic facts about brain health',
        description: '3 min',
        route: '/viewScreen',
        imageUrl: 'brain_health_2',
        url:
            'https://powermeacademy.com/lessons/understanding-cognitive-health/',
      ),
      ContentItem(
        title: 'Lifestyle strategies for a health brain',
        description: '3 min',
        route: '/viewScreen',
        imageUrl: 'brain_outdoor_dog',
        url:
            'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
      ),
    ],
  ),
  // HealthElement(
  //   title: "Sleep",
  //   imagePath: "lib/assets/images/sleep.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // HealthElement(
  //   title: "Stress",
  //   imagePath: "lib/assets/images/stress.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // HealthElement(
  //   title: "Gut Health",
  //   imagePath: "lib/assets/images/gut.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // HealthElement(
  //   title: "Metabolic Health",
  //   imagePath: "lib/assets/images/metabolic.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // HealthElement(
  //   title: "Healthy Aging",
  //   imagePath: "lib/assets/images/aging.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // HealthElement(
  //   title: "Emotional Health",
  //   imagePath: "lib/assets/images/emotional.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // HealthElement(
  //   title: "Functional Movement",
  //   imagePath: "lib/assets/images/movement.jpeg",
  //   onboardingRoute: "/comingsoon",
  //   isActive: false,
  //   assessments: [
  //     //Assessments
  //     ContentItem(
  //       title: "McCANCE Brain Care Score'",
  //       description: AppConstants.brainCareShort,
  //       route: '/brainehealthquestionnaire',
  //       imageUrl: 'memory_health',
  //       cardColor: AppTheme.primaryColor,
  //     ),
  //     ContentItem(
  //       title: "The CogHealth Screening Test'",
  //       description: "A short assessment of memory and cognitive function.",
  //       route: '/cognitive',
  //       imageUrl: 'cog_health_test2',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   protocols: [
  //     //protocols
  //     ContentItem(
  //       title: "Memory Enhancement Protocol",
  //       description: AppConstants.memoryEnhancement,
  //       route: '/eoOnboarding',
  //       imageUrl: 'memory_protocol',
  //       cardColor: const Color(0xE9FCAF3B),
  //     ),
  //   ],
  //   learningCenter: [
  //     //learning center
  //     ContentItem(
  //       title: 'Essential oils, memory, and cognitive health',
  //       description: 'Learn',
  //       route: '/essentialOils',
  //       imageUrl: 'dT_EO2',
  //     ),
  //     ContentItem(
  //       title: 'Basic facts about brain health',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_health_2',
  //       url:
  //           'https://powermeacademy.com/lessons/understanding-cognitive-health/',
  //     ),
  //     ContentItem(
  //       title: 'Lifestyle strategies for a health brain',
  //       description: '3 min',
  //       route: '/viewScreen',
  //       imageUrl: 'brain_outdoor_dog',
  //       url:
  //           'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
  //     ),
  //   ],
  // ),
  // Add other elements here...
];
