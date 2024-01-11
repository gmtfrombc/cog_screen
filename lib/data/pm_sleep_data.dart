import 'package:cog_screen/models/survey_model.dart';

List<SurveyCategory> sleepData = [
  SurveyCategory(
    category: 'Sleep Duration',
    title:
        'How many hours of sleep do you get on average per night? (Please select the option that best describes your sleep pattern)',
    criteria: [
      SurveyCriterion(
        description: 'Less than 6 hours',
        rank: 0,
      ),
      SurveyCriterion(
        description: '6-7 hours',
        rank: 1,
      ),
      SurveyCriterion(
        description: '7-9 hours',
        rank: 2,
      ),
      SurveyCriterion(
        description: 'More than 9 hours',
        rank: 1,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Quality',
    title: 'When you wake up in the morning, do you feel well rested?',
    criteria: [
      SurveyCriterion(
        description: 'All of the time',
        rank: 2,
      ),
      SurveyCriterion(
        description: 'Most of the time',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Rarely',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'On average, how long does it take you to fall asleep at night?',
    title: 'Sleep Onset',
    criteria: [
      SurveyCriterion(
        description: 'Less than 5 minutes',
        rank: 1,
      ),
      SurveyCriterion(
        description: '5-30 minutes',
        rank: 2,
      ),
      SurveyCriterion(
        description: '30-60 minutes',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'More than 60 minutes',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category:
        'On average, if you wake up in the night, how long does it take you to fall back asleep?',
    title: 'Sleep Maintenance',
    criteria: [
      SurveyCriterion(
        description: 'Less than 5 minutes',
        rank: 1,
      ),
      SurveyCriterion(
        description: '5-30 minutes',
        rank: 2,
      ),
      SurveyCriterion(
        description: '30-60 minutes',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'More than 60 minutes',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category:
        'If you have ever been diagnosed with sleep apnea are you being treated?',
    title: 'Sleep Apnea',
    criteria: [
      SurveyCriterion(
        description: "I don't have sleep apnea",
        rank: 2,
      ),
      SurveyCriterion(
        description: 'I have sleep apnea and I am being treated',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'I have sleep apnea and I am not being treated',
        rank: 0,
      ),
    ],
  ),
];
