import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/brain_constants.dart';
import 'package:cog_screen/utilities/sleep_constants.dart';
import 'package:flutter/material.dart';

class HealthElement {
  final String title;
  final String onboardingRoute;
  final bool isActive;
  final List<ContentItem> assessments;
  final List<ContentItem> integrativeHealth;
  final List<ContentItem> learningCenter;
  final List<HealthElementImage> images; // New field for images

  HealthElement({
    required this.title,
    required this.onboardingRoute,
    required this.isActive,
    required this.assessments,
    required this.integrativeHealth,
    required this.learningCenter,
    required this.images, // New parameter for images
  });
}

class ContentItem {
  final String title;
  final String description;
  final String route;
  String imageUrl; // Changed to non-final to update later
  final Color? cardColor;
  final String? url;
  final String onboardingTitle;
  final String onboardingDescription;
  final String surveyType;
  final String surveyImage;

  ContentItem({
    required this.title,
    required this.description,
    required this.route,
    required this.imageUrl,
    this.cardColor,
    this.url,
    this.onboardingTitle = '',
    this.onboardingDescription = '',
    this.surveyType = '',
    this.surveyImage = '',
  });
}

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

final List<HealthElement> elements = [
  HealthElement(
    title: "Brain Health",
    onboardingRoute: "/brainCareOboarding",
    isActive: true,
    images: [
      HealthElementImage(
        name: 'cog_health',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'brain_assessment1',
        type: 'png',
        folder: 'BrainHealth',
      ),
      HealthElementImage(
        name: 'brain_assessment2',
        type: 'png',
        folder: 'BrainHealth',
      ),
      HealthElementImage(
        name: 'brain_protocol1',
        type: 'jpeg',
        folder: 'BrainHealth',
      ),
      HealthElementImage(
        name: 'brain_learning1',
        type: 'jpeg',
        folder: 'BrainHealth',
      ),
      HealthElementImage(
        name: 'brain_learning2',
        type: 'jpeg',
        folder: 'BrainHealth',
      ),
      HealthElementImage(
        name: 'brain_learning3',
        type: 'jpeg',
        folder: 'BrainHealth',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score",
        description: BrainConstants.brainCareShort,
        route: '/brainehealthquestionnaire',
        imageUrl: 'brain_assessment1',
        cardColor: AppTheme.primaryColor,
        onboardingDescription: BrainConstants.braincareStart,
        onboardingTitle: "Brain Care Score",
        surveyType: 'Brain Health',
        surveyImage: 'lib/assets/images/memory_enhancement.png',
      ),
      ContentItem(
        title: "The CogHealth Screening Test",
        description: "A short assessment of memory and cognitive function.",
        route: '/cognitive',
        imageUrl: 'brain_assessment2',
        cardColor: const Color(0xE9FCAF3B),
        onboardingDescription: BrainConstants.cogHealthStart,
        onboardingTitle: "CogHealth Screening Test",
        surveyImage: 'lib/assets/images/cog_health_start2.png',
      ),
    ],
    integrativeHealth: [
      //integrative health
      ContentItem(
        title: 'Essential oils and cognitive health',
        description: 'Explore the benefits of essential oils and memory',
        route: '/essentialOils',
        imageUrl: 'brain_learning1',
      ),
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
        route: '/eoOnboarding',
        imageUrl: 'brain_protocol1',
        //cardColor: const Color(0xE9FCAF3B),
      ),
    ],
    learningCenter: [
      //learning cente
      ContentItem(
        title: 'Basic facts about brain health',
        description: '3 min',
        route: '/viewScreen',
        imageUrl: 'brain_learning2',
        url:
            'https://powermeacademy.com/lessons/understanding-cognitive-health/',
      ),
      ContentItem(
        title: 'Lifestyle strategies for a health brain',
        description: '3 min',
        route: '/viewScreen',
        imageUrl: 'brain_learning3',
        url:
            'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
      ),
    ],
  ),
  HealthElement(
    title: "Sleep",
    onboardingRoute: "/brainCareOboarding",
    isActive: true,
    images: [
      HealthElementImage(
        name: 'sleep',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment3',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "Pittsburgh Sleep Quality Index",
        description:
            "A comprehensive tool for assessing  a broad range of sleep metrics.",
        route: '/cognitive',
        imageUrl: 'sleep_assessment2',
        cardColor: const Color.fromARGB(255, 6, 138, 63),
        onboardingTitle: "Pittsburgh Sleep Quality Index",
        onboardingDescription: SleepConstants.sleepPSQI,
        surveyType: 'PSQI',
        surveyImage: 'lib/assets/images/psqi_survey.jpeg',
      ),
      ContentItem(
        title: "PowerME Sleep Assessment",
        description: SleepConstants.pmSleepAssessment,
        route: '/brainehealthquestionnaire',
        cardColor: const Color.fromARGB(255, 175, 11, 203),
        imageUrl: 'sleep_assessment1',
        onboardingTitle: "The PowerME Sleep Assessment",
        onboardingDescription: SleepConstants.sleepAssessment,
        surveyType: 'PowerME Sleep Assessment',
        surveyImage: 'lib/assets/images/sleep_assessment_pm.jpeg',
      ),
      ContentItem(
        title: "Sleep Hygiene Tool",
        description: SleepConstants.sleepHygieneTool,
        route: '/brainehealthquestionnaire',
        cardColor: const Color.fromARGB(255, 62, 6, 147),
        imageUrl: 'sleep_assessment3',
        onboardingTitle: "Sleep Hygiene Tool",
        onboardingDescription: SleepConstants.sleepHygieneTool,
        surveyType: 'Sleep Hygiene Tool',
        surveyImage: 'lib/assets/images/sleep_assessment_pm.jpeg',
      ),
    ],
    integrativeHealth: [
      //integrative health
      ContentItem(
        title: 'Integrative Health for Sleep',
        description: 'Explore integrative health strategies',
        route: '/essentialOils',
        imageUrl: 'sleep_learning1',
      ),
      ContentItem(
        title: "Sleep Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
        route: '/eoOnboarding',
        imageUrl: 'sleep_protocol1',
        //cardColor: const Color(0xE9FCAF3B),
      ),
    ],
    learningCenter: [
      //learning center

      ContentItem(
        title: 'Basic facts about sleep',
        description: '3 min',
        route: '/viewScreen',
        imageUrl: 'sleep_learning2',
        url:
            'https://powermeacademy.com/lessons/understanding-cognitive-health/',
      ),
      ContentItem(
        title: 'Lifestyle strategies for a good sleep',
        description: '3 min',
        route: '/viewScreen',
        imageUrl: 'sleep_learning3',
        url:
            'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/',
      ),
    ],
  ),
  HealthElement(
    title: "Stress",
    onboardingRoute: "/comingsoon",
    isActive: false,
    images: [
      HealthElementImage(
        name: 'stress',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: BrainConstants.brainCareShort,
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
    integrativeHealth: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
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
        imageUrl: 'dT_EO2',
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
  HealthElement(
    title: "Gut Health",
    onboardingRoute: "/comingsoon",
    isActive: false,
    images: [
      HealthElementImage(
        name: 'gut',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: BrainConstants.brainCareShort,
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
    integrativeHealth: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
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
        imageUrl: 'dT_EO2',
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
  HealthElement(
    title: "Metabolic Health",
    onboardingRoute: "/comingsoon",
    isActive: false,
    images: [
      HealthElementImage(
        name: 'metabolic',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: BrainConstants.brainCareShort,
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
    integrativeHealth: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
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
        imageUrl: 'dT_EO2',
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
  HealthElement(
    title: "Healthy Aging",
    onboardingRoute: "/comingsoon",
    isActive: false,
    images: [
      HealthElementImage(
        name: 'aging',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: BrainConstants.brainCareShort,
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
    integrativeHealth: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
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
        imageUrl: 'dT_EO2',
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
  HealthElement(
    title: "Emotional Health",
    onboardingRoute: "/comingsoon",
    isActive: false,
    images: [
      HealthElementImage(
        name: 'emotional',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: BrainConstants.brainCareShort,
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
    integrativeHealth: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
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
        imageUrl: 'dT_EO2',
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
  HealthElement(
    title: "Functional Movement",
    onboardingRoute: "/comingsoon",
    isActive: false,
    images: [
      HealthElementImage(
        name: 'movement',
        type: 'jpeg',
        folder: 'Home',
      ),
      HealthElementImage(
        name: 'sleep_assessment1',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment2',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_assessment3',
        type: 'png',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_protocol1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning1',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning2',
        type: 'jpeg',
        folder: 'Sleep',
      ),
      HealthElementImage(
        name: 'sleep_learning3',
        type: 'jpeg',
        folder: 'Sleep',
      ),
    ],
    assessments: [
      //Assessments
      ContentItem(
        title: "McCANCE Brain Care Score'",
        description: BrainConstants.brainCareShort,
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
    integrativeHealth: [
      //protocols
      ContentItem(
        title: "Memory Enhancement Protocol",
        description: BrainConstants.memoryEnhancement,
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
        imageUrl: 'dT_EO2',
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
];
