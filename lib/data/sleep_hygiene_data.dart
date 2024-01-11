import 'package:cog_screen/models/survey_model.dart';

List<SurveyCategory> sleepHygiene = [
  SurveyCategory(
    category: 'Room Temperature',
    title: 'How do you find the temperature in your bedroom?',
    criteria: [
      SurveyCriterion(
        description: 'Too cold',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Too hot',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Just right',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Room Darkness',
    title: 'How do you find the level of darkness of your bedroom?',
    criteria: [
      SurveyCriterion(
        description: 'Too dark',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Too light',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Just right',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Pre-Bedtime Eating',
    title: 'On a usual day, how long before bedtime is the last time you tyically eat?',
    criteria: [
      SurveyCriterion(
        description: 'Less than 30 minutes',
        rank: 3,
      ),
      SurveyCriterion(
        description: '30 minutes to 1 hour',
        rank: 2,
      ),
      SurveyCriterion(
        description: '1-2 hours',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Over 2 hours',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Pre-Bedtime Device Usage',
    title: '4.	How long before bedtime do you turn off devices (smart phone, computer) excluding apps that you use for relaxation, such as mediation or reading apps?',
    criteria: [
      SurveyCriterion(
        description: 'Less than 30 minutes',
        rank: 3,
      ),
      SurveyCriterion(
        description: '30 minutes to 1 hour',
        rank: 2,
      ),
      SurveyCriterion(
        description: '1-2 hours',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Over 2 hours',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Weekly Exercise Frequency',
    title: '5.	How many days per week do you exercise (moderate to vigorous)',
    criteria: [
      SurveyCriterion(
        description: '6-7 days',
        rank: 0,
      ),
      SurveyCriterion(
        description: '3-5 days',
        rank: 1,
      ),
      SurveyCriterion(
        description: '0-2 days',
        rank: 2,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Weekly Alcohol Consumption',
    title: 'How many days a week do you have more than one drink of alcohol?',
    criteria: [
      SurveyCriterion(
        description: '6-7 days',
        rank: 3,
      ),
      SurveyCriterion(
        description: '4-5 days',
        rank: 2,
      ),
      SurveyCriterion(
        description: '2-3 days',
        rank: 1,
      ),
      SurveyCriterion(
        description: '0-1 days',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Caffeine Intake Before Bedtime',
    title:
        'How many days a week do you have caffeinated beverages within 12 hours of your bedtime?',
    criteria: [
      SurveyCriterion(
        description: '6-7 days',
        rank: 3,
      ),
      SurveyCriterion(
        description: '4-5 days',
        rank: 2,
      ),
      SurveyCriterion(
        description: '2-3 days',
        rank: 1,
      ),
      SurveyCriterion(
        description: '0-1 days',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Mattress Quality',
    title: 'How would you rate the quality of your mattress?',
    criteria: [
      SurveyCriterion(
        description: 'Excellent',
        rank: 0,
      ),
      SurveyCriterion(
        description: 'Good',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'Fair',
        rank: 2,
      ),
      SurveyCriterion(
        description: 'Poor',
        rank: 3,
      ),
    ],
  ),
];
