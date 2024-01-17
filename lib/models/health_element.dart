import 'package:cog_screen/data/essential_oils_data.dart';
import 'package:cog_screen/data/results_info_data.dart';
import 'package:cog_screen/models/essential_oils_model.dart';
import 'package:cog_screen/models/healthelement_image_model.dart';
import 'package:cog_screen/models/protocol_model.dart';
import 'package:cog_screen/models/results_info_model.dart';
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
  final List<HealthElementImage> images;
  final EssentialOilsModel essentialOils;
  final ProtocolModel? protocol;
  final ResultsInfoModel? resultsInfo;

  HealthElement({
    required this.title,
    required this.onboardingRoute,
    required this.isActive,
    required this.assessments,
    required this.integrativeHealth,
    required this.learningCenter,
    required this.images,
    required this.essentialOils,
    this.resultsInfo,
    this.protocol,
  });
}

class ContentItem {
  final String title;
  final String description;
  final String? route;
  String imageUrl; // Changed to non-final to update later
  final Color? cardColor;
  final String? url;
  final String onboardingTitle;
  final String onboardingDescription;
  final String surveyType;
  final String surveyImage;
  final String surveyResultsTop;
  final String surveyResultsBottom;
  final int? possibleScore;

  ContentItem({
    required this.title,
    required this.description,
    this.route,
    required this.imageUrl,
    this.cardColor,
    this.url,
    this.onboardingTitle = '',
    this.onboardingDescription = '',
    this.surveyType = '',
    this.surveyImage = '',
    this.surveyResultsTop = '',
    this.surveyResultsBottom = '',
    this.possibleScore,
  });
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
        possibleScore: 21,
        surveyResultsTop: BrainConstants.brainCareShort,
        surveyResultsBottom: BrainConstants.brainHealthMore,
      ),
      ContentItem(
        title: "CogHealth Screening Test",
        description: "A short assessment of memory and cognitive function.",
        route: '/cognitive',
        imageUrl: 'brain_assessment2',
        cardColor: const Color(0xE9FCAF3B),
        onboardingDescription: BrainConstants.cogHealthStart,
        onboardingTitle: "CogHealth Screening Test",
        surveyImage: 'lib/assets/images/cog_health_start2.png',
        surveyType: 'CogHealth Screening Test',
        possibleScore: 10,
        surveyResultsTop: BrainConstants.cogHealthExplanation,
        surveyResultsBottom: BrainConstants.cogHealthMore,
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
        description: 'Olfactory Enrichment',
        imageUrl: 'brain_protocol1',
        surveyType: 'protocol',
        onboardingTitle: 'Memory Enhancement',
        onboardingDescription: BrainConstants.memoryEnhancment,
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
    essentialOils: EssentialOilsModel(
      header: EOScreenHeader(
        title: 'Essential Oils \nand Brain Health',
        image: 'lib/assets/images/dT_EO9-cropped.jpeg',
      ),
      articles: EOScreenArticles(
        title: 'Recent Articles',
        color: AppTheme.primaryColor,
        description:
            'Read our latest article on essential oils and cognitive health, memory, and more.',
        image: 'lib/assets/images/diffusers.png',
      ),
      research: eoCogResearch,
    ),
    protocol: ProtocolModel(
      header: EOScreenHeader(
        title: 'Olfactory Enrichment \nProtocol',
        image: 'lib/assets/images/dT_EO8.jpeg',
      ),
      oils: EOList(
        title: 'Recommended Essential Oils',
        oils: [
          'Rose',
          'Orange',
          'Eucalyptus',
          'Lemon',
          'Peppermint',
          'Rosemary',
          'Lavender'
        ],
      ),
      protcolInstructions: ProtocolInstructions(
        title: 'Protocol Instructions',
        instructions: '1. Place the diffuser near your bed.\n'
            '2. Fill the diffuser with the essential oil of the night.\n'
            '3. Turn on the diffuser when going to bed.\n'
            '4. Diffuse the essential oil for at least 2 hours.\n'
            '5. Rotate through a different essential oil each night.',
        frequencyDuration: BrainConstants.frequencyDuration,
      ),
    ),
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
        possibleScore: 21,
        surveyResultsTop: SleepConstants.psqiAssessmentResultsTop,
        surveyResultsBottom: SleepConstants.psqiAssessmentResultsBottom,
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
        surveyResultsTop: SleepConstants.sleepAssessmentResultsTop,
        surveyResultsBottom: SleepConstants.sleepAssessmentResultsBottom,
        possibleScore: 10,
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
        surveyResultsTop: SleepConstants.sleepHygieneResultsTop,
        surveyResultsBottom: SleepConstants.sleepHygieneResultsBottom,
        possibleScore: 20,
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
        description: 'Essential Oils',
        //route: '/eoOnboarding',
        imageUrl: 'sleep_protocol1',
        surveyType: 'protocol',
        onboardingTitle: 'Sleep Enhancement',
        onboardingDescription: SleepConstants.sleepProtocol,
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
    essentialOils: EssentialOilsModel(
        header: EOScreenHeader(
          title: 'Essential Oils \nand Sleep',
          image: 'lib/assets/images/dT_EO9-cropped.jpeg',
        ),
        articles: EOScreenArticles(
          title: 'Recent Articles',
          color: AppTheme.secondaryColor,
          description:
              'Read our most recent article on essential oils and sleep health and more.',
          image: 'lib/assets/images/diffusers.png',
        ),
        research: eoSleepResearch),
    protocol: ProtocolModel(
      header: EOScreenHeader(
        title: 'Sleep Enhancement \nProtocol',
        image: 'lib/assets/images/dT_EO8.jpeg',
      ),
      oils: EOList(
        title: 'Recommended Essential Oils',
        oils: [
          'Lavendar',
          'Chamomile',
          'Bergamot',
          'Ylang Ylang',
          'Sandalwood',
          'Clary Sage'
        ],
      ),
      protcolInstructions: ProtocolInstructions(
        title: 'Protocol Instructions',
        instructions:
            '1. Finish eating 2-3 hours before going to bed, avoiding caffeine and alcohol.\n'
            '2. Turn off devices an 30-60 minutes before bedtime; consider reading a book or listening to soft music.\n'
            '3. Make sure your bedroom is dark and at a cool temperature.\n'
            '4. Start diffusing your favorite essential oil 30 minutes before bed.\n'
            '5. Consider a warm bath or breathing exercises 30 minutes before you turn in.\n'
            '6. Diffuse your essential oil for at least 2 hours.\n',
        frequencyDuration: SleepConstants.sleepFrequencyDuration,
      ),
    ),
    resultsInfo: resultsInfoData
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
        description: BrainConstants.olfactoryEnrichment,
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
    essentialOils: EssentialOilsModel(
      header: EOScreenHeader(
        title: 'Essential Oils and Brain Health',
        image: 'brain_health_2',
      ),
      articles: EOScreenArticles(
        title: 'Essential Oils and Brain Health',
        description: 'Learn',
        image: 'dT_EO2',
      ),
      research: eoCogResearch,
    ),
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
        description: BrainConstants.olfactoryEnrichment,
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
    essentialOils: EssentialOilsModel(
      header: EOScreenHeader(
        title: 'Essential Oils and Brain Health',
        image: 'brain_health_2',
      ),
      articles: EOScreenArticles(
        title: 'Essential Oils and Brain Health',
        description: 'Learn',
        image: 'dT_EO2',
      ),
      research: eoCogResearch,
    ),
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
        description: BrainConstants.olfactoryEnrichment,
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
    essentialOils: EssentialOilsModel(
        header: EOScreenHeader(
          title: 'Essential Oils and Brain Health',
          image: 'brain_health_2',
        ),
        articles: EOScreenArticles(
          title: 'Essential Oils and Brain Health',
          description: 'Learn',
          image: 'dT_EO2',
        ),
        research: eoCogResearch),
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
        description: BrainConstants.olfactoryEnrichment,
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
    essentialOils: EssentialOilsModel(
      header: EOScreenHeader(
        title: 'Essential Oils and Brain Health',
        image: 'brain_health_2',
      ),
      articles: EOScreenArticles(
        title: 'Essential Oils and Brain Health',
        description: 'Learn',
        image: 'dT_EO2',
      ),
      research: eoCogResearch,
    ),
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
        description: BrainConstants.olfactoryEnrichment,
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
    essentialOils: EssentialOilsModel(
      header: EOScreenHeader(
        title: 'Essential Oils and Brain Health',
        image: 'brain_health_2',
      ),
      articles: EOScreenArticles(
        title: 'Essential Oils and Brain Health',
        description: 'Learn',
        image: 'dT_EO2',
      ),
      research: eoCogResearch,
    ),
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
        description: BrainConstants.olfactoryEnrichment,
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
    essentialOils: EssentialOilsModel(
      header: EOScreenHeader(
        title: 'Essential Oils and Brain Health',
        image: 'brain_health_2',
      ),
      articles: EOScreenArticles(
        title: 'Essential Oils and Brain Health',
        description: 'Learn',
        image: 'dT_EO2',
      ),
      research: [
        EOResearch(
          title:
              "Overnight olfactory enrichment using an odorant diffuser improves memory and modifies the uncinate fasciculus in older adults",
          description: '4 min',
          image: 'lib/assets/images/research1.jpeg',
          link: '/viewScreen',
          url:
              'https://powermeacademy.com/topic/study-on-olfactory-enrichments-in-older-adults/',
        ),
        EOResearch(
          title:
              "Overnight olfactory enrichment using an odorant diffuser improves memory and modifies the uncinate fasciculus in older adults",
          description: '4 min',
          image: 'lib/assets/images/research1.jpeg',
          link: '/viewScreen',
          url:
              'https://powermeacademy.com/topic/study-on-olfactory-enrichments-in-older-adults/',
        ),
        EOResearch(
          title:
              "Overnight olfactory enrichment using an odorant diffuser improves memory and modifies the uncinate fasciculus in older adults",
          description: '4 min',
          image: 'lib/assets/images/research1.jpeg',
          link: '/viewScreen',
          url:
              'https://powermeacademy.com/topic/study-on-olfactory-enrichments-in-older-adults/',
        ),
      ],
    ),
  ),
];
