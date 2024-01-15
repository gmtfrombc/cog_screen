import 'package:cog_screen/models/survey_model.dart';

List<SurveyCategory> cogHealth = [
  SurveyCategory(
    category: "Today's Date",
    title: 'Check your date with today’s actual date?',
    criteria: [
      SurveyCriterion(
        description: 'My answer was correct',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'My answer was incorrect',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Money Question',
    title: "How many 20 cent pieces are in \$2.40?",
    criteria: [
      SurveyCriterion(
        description: '13',
        rank: 0,
      ),
      SurveyCriterion(
        description: '12',
        rank: 1,
      ),
      SurveyCriterion(
        description: '11',
        rank: 0,
      ),
      SurveyCriterion(
        description: '10',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Calculate the Change',
    title:
        'If you are buying \$13.40 of groceries how much change do you receive back from a \$20 bill?',
    criteria: [
      SurveyCriterion(
        description: '6.60',
        rank: 1,
      ),
      SurveyCriterion(
        description: '6.30',
        rank: 0,
      ),
      SurveyCriterion(
        description: '7.10',
        rank: 0,
      ),
      SurveyCriterion(
        description: '6.90',
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Clock',
    title:
        'Check the clock that you drew and answer the following:\n\n\nDoes your clock have a face with numbers?',
    criteria: [
      SurveyCriterion(
        description: 'Yes',
        rank: 1,
      ),
      SurveyCriterion(
        description: "No",
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Clock',
    title:
        "Does your clock have the long hand pointing at one and the short hand pointing at eleven?",
    criteria: [
      SurveyCriterion(
        description: "Yes",
        rank: 1,
      ),
      SurveyCriterion(
        description: "No",
        rank: 0,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Counting Task',
    title:
        'For your 15 second counting task, how many animals did you write down?',
    criteria: [
      SurveyCriterion(
        description: 'less than 2',
        rank: 0,
      ),
      SurveyCriterion(
        description: 'between 3 and 7',
        rank: 1,
      ),
      SurveyCriterion(
        description: 'between 8 and 12',
        rank: 2,
      ),
      SurveyCriterion(
        description: 'more than 12',
        rank: 3,
      ),
    ],
  ),
  SurveyCategory(
    category: 'Are you finished with the test?',
    title:
        'At the beginning of test, you were asked to select from the following to indicate you were finished with the test. Please select the option you chose.',
    criteria: [
      SurveyCriterion(
        description: "Yes, I'm finished",
        rank: 0,
      ),
      SurveyCriterion(
        description: "I'm done",
        rank: 0,
      ),
      SurveyCriterion(
        description: "I am finished",
        rank: 0,
      ),
      SurveyCriterion(
        description: "I am done",
        rank: 2,
      ),
      SurveyCriterion(
        description: "Yes, I'm done",
        rank: 0,
      ),
    ],
  ),
];
