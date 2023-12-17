import 'package:cog_screen/models/braincarescore_model.dart';

const String dietaryStatement =
    'Eat 4.5 servings of fruit and vegetables per day, 2 servings of lean protein per day, 3 or more servings of whole grains per day, Less than 1,500 mg of sodium per day, Less than 36 oz of sugar sweet beverages per week.';

List<BrainCareCategory> brainCareData = [
  BrainCareCategory(
    category: 'Resting Blood Pressure',
    title:
        'Determine your resting blood pressure from self-monitoring or from your doctor and choose the appropriate range below.',
    criteria: [
      BrainCareCriterion(
          description: 'Greater than 140/90, with or without treatment',
          rank: 0),
      BrainCareCriterion(
        description: '120-139/80-89, with or without treatment',
        rank: 1,
      ),
      BrainCareCriterion(
        description: 'Less than 120/80',
        rank: 2,
      ),
    ],
  ),
  BrainCareCategory(
    category: 'Hemoglobin A1c',
    title:
        'Your A1c is lab test that estimates your average blood sugar over the past 3 months. Select the range from the options below.',
    criteria: [
      BrainCareCriterion(
        description: 'Hemoglobin A1c greater than 6.4',
        rank: 0,
      ),
      BrainCareCriterion(
        description: 'Hemoglobin A1c between 5.7 and 6.4',
        rank: 1,
      ),
      BrainCareCriterion(
        description: 'Hemoglobin A1c less than 5.7',
        rank: 2,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Your total cholesterol can be measured in a lab test called a 'lipid panel'. Select the range of your total cholesterol from the options below.",
    category: 'Total Cholesterol',
    criteria: [
      BrainCareCriterion(
        description: '190 or higher',
        rank: 0,
      ),
      BrainCareCriterion(
        description: 'No treatment required or less than 190 mg/dL',
        rank: 1,
      ),
      BrainCareCriterion(
        description:
            'If cardiovascular disease is present, LDL is in accordance to the latest CDC recommendations',
        rank: 2,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Your BMI is a measure of your weight in relation to your height. It can be obtained from your healthcare provider, or there are many online calculators that can give you your BMI. Select your BMI range from the options below.",
    category: 'BMI',
    criteria: [
      BrainCareCriterion(
        description: 'Lower than 18.5 kg/m²',
        rank: 0,
      ),
      BrainCareCriterion(
        description: '18.5-25 kg/m²',
        rank: 1,
      ),
      BrainCareCriterion(
        description: '25-29.9 kg/m²',
        rank: 1,
      ),
      BrainCareCriterion(
        description: 'Greater than 30 kg/m²',
        rank: 0,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Select the option below that best describes your typical weekly diet using the following recommendations:\n\n $dietaryStatement",
    category: 'Dietary Habits',
    criteria: [
      BrainCareCriterion(
        description:
            'Typical weekly diet does not include at least 2 of the recommendations above',
        rank: 0,
      ),
      BrainCareCriterion(
        description:
            'Typical weekly diet includes 2 or more of the recommendations above',
        rank: 1,
      ),
      BrainCareCriterion(
        description:
            'Typical weekly diet includes 3 or more of the recommendations above',
        rank: 2,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Select the option below that best describes your typical weekly alcohol intake.",
    category: 'Alcohol Intake',
    criteria: [
      BrainCareCriterion(
        description: '4 or more alcoholic drinks per week',
        rank: 0,
      ),
      BrainCareCriterion(
        description: '2-3 alcoholic drinks per week',
        rank: 1,
      ),
      BrainCareCriterion(
        description: '0-1 alcoholic drink per week',
        rank: 2,
      ),
    ],
  ),
  BrainCareCategory(
    title: "Select the option below that best describes your smoking status.",
    category: 'Smoking',
    criteria: [
      BrainCareCriterion(
        description: 'Current smoker',
        rank: 0,
      ),
      BrainCareCriterion(
        description: 'Never smoked or quit more than a year ago',
        rank: 3,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Select the option below that best describes your physical activity level.",
    category: 'Physical Activity',
    criteria: [
      BrainCareCriterion(
        description:
            'Less than 150 minutes of moderate or 75 minutes of high intensity physical activity per week',
        rank: 0,
      ),
      BrainCareCriterion(
        description:
            'At least 150 minutes of moderate physical activity or 75 minutes of high intensity physical activity per week',
        rank: 1,
      ),
    ],
  ),
  BrainCareCategory(
    title: "Select the option below that best describes your sleep routine.",
    category: 'Sleep',
    criteria: [
      BrainCareCriterion(
          description: 'Untreated sleep disorder and/or sleeps <7hrs per night',
          rank: 0),
      BrainCareCriterion(
        description:
            'Treated sleep disturbances and 7-8 hours of routine sleep per night',
        rank: 1,
      ),
    ],
  ),
  BrainCareCategory(
    title: "Select the option below that best describes your stress level.",
    category: 'Stress',
    criteria: [
      BrainCareCriterion(
          description:
              'High level of stress that often makes it difficult to function',
          rank: 0),
      BrainCareCriterion(
        description:
            'Moderate level of stress that occasionally makes it difficult to function',
        rank: 1,
      ),
      BrainCareCriterion(
        description:
            'Manageable level of stress that rarely makes it difficult to function',
        rank: 2,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Select the option below that best describes your social relationships.",
    category: 'Social Relationships',
    criteria: [
      BrainCareCriterion(
        description:
            'Few or no close connections other than spouse or children',
        rank: 0,
      ),
      BrainCareCriterion(
        description:
            'At least two people, other than spouse or children, to feel close with and could talk about private matters or call upon for help',
        rank: 1,
      ),
    ],
  ),
  BrainCareCategory(
    title:
        "Select the option below that best describes the meaining or purpose of your life.",
    category: 'Meaning in Life',
    criteria: [
      BrainCareCriterion(
        description: 'Often struggle to find value or purpose in life',
        rank: 0,
      ),
      BrainCareCriterion(
        description: 'Generally feel that life has meaning and/or purpose',
        rank: 1,
      ),
    ],
  ),
];
