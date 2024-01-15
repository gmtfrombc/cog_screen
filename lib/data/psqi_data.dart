import 'package:cog_screen/models/survey_model.dart';

List<SurveyCategory> psqiData = [
  SurveyCategory(
    category: 'Bed Time',
    title:
        'During the past month, approximately what time have you gone to bed at night?',
    criteria: [
      SurveyCriterion(description: 'Before 7:00 p.m.', rank: 0),
      SurveyCriterion(description: 'Between 7:00 p.m. and 9:00 p.m.', rank: 1),
      SurveyCriterion(description: 'Between 9:00 p.m. and 11:00 p.m.', rank: 1),
      SurveyCriterion(description: 'Between 11:00 p.m. and 1:00 a.m.', rank: 1),
      SurveyCriterion(description: 'After 1:00 a.m.', rank: 0),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Latency',
    title:
        'During the past month, how long (in minutes) has it usually taken you to fall asleep each night?',
    criteria: [
      SurveyCriterion(description: 'Less than 15 minutes', rank: 0),
      SurveyCriterion(description: '15-30 minutes', rank: 1),
      SurveyCriterion(description: '31-60 minutes', rank: 2),
      SurveyCriterion(description: 'More than 60 minutes', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Wake Time',
    title:
        'During the past month, approximately what time have you usually gotten up in the morning?',
    criteria: [
      SurveyCriterion(description: 'Before 4:00 a.m.', rank: 0),
      SurveyCriterion(description: 'Between 4:00 a.m. and 6:00 a.m.', rank: 1),
      SurveyCriterion(description: 'Between 6:00 p.m. and 8:00 a.m.', rank: 1),
      SurveyCriterion(description: 'Between 8:00 a.m. and 10:00 a.m.', rank: 1),
      SurveyCriterion(description: 'After 10:00 a.m.', rank: 0),
    ],
  ),
  // ...
  SurveyCategory(
    category: 'Sleep Duration',
    title:
        'During the past month, how many hours of actual sleep did you get at night? (This may be different than the number of hours you spent in bed.)',
    criteria: [
      SurveyCriterion(description: 'More than 7 hours', rank: 3),
      SurveyCriterion(description: '6-7 hours', rank: 2),
      SurveyCriterion(description: '5-6 hours', rank: 1),
      SurveyCriterion(description: 'Less than 5 hours', rank: 0),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Onset',
    title:
        'During the past month, how often have you had trouble sleeping because you cannot get to sleep within 30 minutes?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Maintenance',
    title:
        'During the past month, how often have you had trouble sleeping because you wake up in the middle of the night or early morning?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Restroom',
    title:
        'During the past month, how often have you had trouble sleeping because you have to get up to use the restroom?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),

  SurveyCategory(
    category: 'Sleep Disturbances - Breathing',
    title:
        'During the past month, how often have you had trouble sleeping because you cannot breathe comfortably?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Snoring',
    title:
        'During the past month, how often have you had trouble sleeping because you cough or snore loudly?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Cold',
    title:
        'During the past month, how often have you had trouble sleeping because you feel too cold?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Hot',
    title:
        'During the past month, how often have you had trouble sleeping because you feel too hot?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Bad Dreams',
    title:
        'During the past month, how often have you had trouble sleeping because you had bad dreams?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Discomfort',
    title:
        'During the past month, how often have you had trouble sleeping because you cannot get comfortable due to pain?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
  SurveyCategory(
    category: 'Sleep Disturbances - Others',
    title:
        'During the past month, how often have you had trouble sleeping because you have to get up to care for a child or another adult?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
  SurveyCategory(
    category: 'Subjective Sleep Quality',
    title:
        'During the past month, how would you rate your sleep quality overall?',
    criteria: [
      SurveyCriterion(description: 'Very good', rank: 0),
      SurveyCriterion(description: 'Fairly good', rank: 1),
      SurveyCriterion(description: 'Fairly bad', rank: 2),
      SurveyCriterion(description: 'Very bad', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Use of Sleeping Medication',
    title:
        'During the past month, how often have you taken medicine to help you sleep? (prescribed or “over the counter”)',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Daytime Wakefulness',
    title:
        'During the past month, how often have you had trouble staying awake while driving, eating meals, or engaging in social activity?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),

  SurveyCategory(
    category: 'Daytime Dysfunction',
    title:
        'During the past month, how much of a problem has it been for you to keep up enthusiasm to get things done?',
    criteria: [
      SurveyCriterion(description: 'No problem at all', rank: 0),
      SurveyCriterion(description: 'A very slight problem', rank: 1),
      SurveyCriterion(description: 'Somewhat of a problem', rank: 2),
      SurveyCriterion(description: 'A very big problem', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleeping Parners - Snoring',
    title:
        'If you have a room mate or bed partner, ask him/her how often in the past month you had loud snoring?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 1),
      SurveyCriterion(description: 'Once or twice a week', rank: 2),
      SurveyCriterion(description: 'Three or more times a week', rank: 3),
    ],
  ),
  SurveyCategory(
    category: 'Sleeping Parners - Breathing',
    title:
        'If you have a room mate or bed partner, ask him/her how often in the past month you have had long pauses between breaths while asleep?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
  SurveyCategory(
    category: 'Sleeping Parners - Restless Legs',
    title:
        'If you have a room mate or bed partner, ask him/her how often in the past month you have had legs twitching or jerking while you sleep?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
  SurveyCategory(
    category: 'Sleeping Parners - Confusion',
    title:
        'If you have a room mate or bed partner, ask him/her how often in the past month you have had episodes of disorientation or confusion during sleep',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
  SurveyCategory(
    category: 'Sleeping Parners - Restlessness',
    title:
        'If you have a room mate or bed partner, ask him/her how often in the past month you have had other restlessness issues while asleep?',
    criteria: [
      SurveyCriterion(description: 'Not during the past month', rank: 0),
      SurveyCriterion(description: 'Less than once a week', rank: 0),
      SurveyCriterion(description: 'Once or twice a week', rank: 1),
      SurveyCriterion(description: 'Three or more times a week', rank: 2),
    ],
  ),
];
