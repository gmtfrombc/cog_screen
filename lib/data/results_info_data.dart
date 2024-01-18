import 'package:cog_screen/models/results_info_model.dart';

ResultsInfoModel sleepHygeineToolInfo = ResultsInfoModel(
  title: 'Sleep Hygiene Tool',
  introText:
      "Sleep hygiene refers to the set of practices, habits, and environmental factors that help in enhancing both the duration and quality of sleep. It typically includes:",
  resultListItems: [
    ResultListItem(
      boldText: "Consistent Sleep Schedule: ",
      regularText:
          "Going to bed and waking up at the same time every day, even on weekends, helps regulate the body's internal clock.",
    ),
    ResultListItem(
      boldText: "Sleep-Inducing Environment: ",
      regularText:
          "Creating a bedroom environment that's conducive to sleep, such as quiet, dark, and cool, with comfortable bedding.",
    ),
    ResultListItem(
      boldText: "Limiting Screen Time Before Bed: ",
      regularText:
          "Reducing exposure to screens and blue light from devices like smartphones and computers before bedtime.",
    ),
    ResultListItem(
      boldText: "Avoiding Stimulants: ",
      regularText:
          "Avoiding caffeine, nicotine, and other stimulants particularly in the hours before sleep.",
    ),
    ResultListItem(
      boldText: "Mindful Eating and Drinking: ",
      regularText:
          "Avoiding heavy meals, alcohol, and large amounts of fluids before bedtime.",
    ),
  ],
  imagePath: 'lib/assets/images/sleep_assessment3.png',
  conclusionText:
      "If your sleep hygiene test is lower than you would like, follow the above instructions and explore the content we've provided in the learning section.",
);

ResultsInfoModel sleepAssessmentInfo = ResultsInfoModel(
  title: 'PowerME Sleep Assessment',
  introText:
      "The PowerME Sleep Assessment is a shortened version of the Pittsburgh Sleep Quality Index (PSQI). A score greater than 7 suggests good quality of sleep. Here is a breakdown of the score:",
  resultListItems: [
    ResultListItem(
      boldText: "Sleep Quantity: ",
      regularText:
          "In general, most adults need 7-9 hours per night. However, some people may need as little as 6 hours, while others may need up to 10 hours per night.",
    ),
    ResultListItem(
      boldText: "Sleep Onset: ",
      regularText:
          "Most people fall asleep within 5 to 30 minutes of going to bed. While there is significant individual variability, falling asleep in less than 5 minutes may indicate inadequate sleep, while longer than 30 minutes to fall asleep, could be sign of insomnia.",
    ),
    ResultListItem(
      boldText: "Sleep Maintenance: ",
      regularText:
          "It's normal to wake up briefly a few times during the night. However, if youu have difficulty falling back asleep, there are strategies that can help. Check out our content in the learning section for more information",
    ),
    ResultListItem(
      boldText: "Sleep Apnea: ",
      regularText:
          "Sleep apnea is a common sleep disorder that involves repeated breathing interruptions during sleep. Untreated sleep apnea has a host of negative health consequences. If you think you may have sleep apnea, talk to your doctor.",
    ),
    ResultListItem(
      boldText: "Individual Variation: ",
      regularText:
          "As noted, there is significant individual variation in sleep needs. Some people may need more sleep than others. If you feel well rested and alert during the day, you are likely getting enough sleep.",
    ),
  ],
  imagePath: 'lib/assets/images/sleep_assessment3.png',
  conclusionText:
      "The Sleep Assessment tool can be used as a quick way to assess your sleep quality. You can follow your results over time. Your results don't need to be perfect. Again, if you feel well rested and alert during the day, you are likely getting enough sleep.\n\nCheck out our learning section for more information on how to improve your sleep.",
);

ResultsInfoModel psqiInfo = ResultsInfoModel(
  title: 'Pittsburgh Sleep Quality Index (PSQI)',
  introText:
      "The Pittsburgh Sleep Quality Index is a comprehensive assessment of sleep health. It is a 19-item questionnaire that assesses sleep quality and disturbances over a 1-month time interval. It is a widely used tool in both clinical and research settings, especially in the realm of behavioral health. Unlike our other assessments, with the PSQI, a LOWER score suggests better sleep quality Here is a breakdown of the score: ",
  resultListItems: [
    ResultListItem(
      boldText: "Sleep Quantity and Quality: ",
      regularText:
          "The PSQI evaluates sleep quantity and quality. Values are typically between 0 and 3, with higher values indicating worse sleep quality.",
    ),
    ResultListItem(
      boldText: "Sleep Disturbances: ",
      regularText:
          "Much of the PSQI focuses on sleep disturbances--how often you have trouble falling asleep, staying asleep, or waking up too early. The questions also focus on difficulties such as problems breathing, snoring, bad dreams, pain, and feeling too cold or too hot.",
    ),
    ResultListItem(
      boldText: "Sleep Treatment: ",
      regularText:
          "The PSQI also dedicates a number of questions to daytime functioning, such as how often you have trouble staying awake while driving, eating, or engaging in social activity. It also asks about sleep medications and other treatments.",
    ),
    ResultListItem(
      boldText: "Caring for Others: ",
      regularText:
          "Unlike most sleep assessments, the PSQI also asks about caring for others. This is because caring for others can have a significant impact on sleep quality. If you are caring for others, it's important to take care of yourself as well, which can be easier said than done.",
    ),
    ResultListItem(
      boldText: "Sleep Partner ",
      regularText:
          "Finally, the PSQI has questions that should be answered by a spouse or sleep partner. For those people who don't have a sleep partner, these questions can be skipped. And the score can be adjusted accordingly.",
    ),
  ],
  imagePath: 'lib/assets/images/sleep_assessment3.png',
  conclusionText:
      "The PSQI is our most comprehensive sleep assessment. As with our other assessments, you can follow your results over time. \n\n If you would like additional information, feel free to explore out our learning section.",
);
ResultsInfoModel mccanceInfo = ResultsInfoModel(
  title: 'McCANCE Brain Care Score',
  introText:
      "The McCance Brain Care Score was developed at the Massachusetts General Hospital and is widely used as an assessment of cognitive health. Here is a breakdown of the test: ",
  resultListItems: [
    ResultListItem(
      boldText: "Assessment Areas: ",
      regularText:
          "The MBCS focuses on lifestyle behaviors realted to physical activity, diet, sleep patterns, mental health, and social interactions. It accounts for health conditions such as high blood pressure, cholesterol, and diabetes.",
    ),
    ResultListItem(
      boldText: "Scoring System: ",
      regularText:
          "The MBCS has a possible high score of 21. As with most of our assessments, with the MBCS a higher score suggests better cognitive health.",
    ),
    ResultListItem(
      boldText: "Score Interpretation: ",
      regularText:
          "Because the MBHS is based on self-repored data, we don't recommend getting caught up with a spefic number. A high result (e.g., over 15 is predictive of good cognitive behaviors, while a low score suggests that you may benefit from making some changes to your lifestyle or even considering additional treatment options.",
    ),
    ResultListItem(
      boldText: "Lifestyle and Cognitive Health: ",
      regularText:
          "Our lifestyles have an enormous effect on all aspects of our health--including our cognitive health. The MBCS is a great way to assess your lifestyle and identify areas for improvement.",
    ),
    ResultListItem(
      boldText: "Next Steps ",
      regularText:
          "We all have areas that we can improve. We recommend that you review your results with your healthcare provider and develop a plan to work on the areas that you would like to improve. ",
    ),
  ],
  imagePath: 'lib/assets/images/brain_health_onboarding.png',
  conclusionText:
      "The McCance Brain Care Score is a validated and comprehensive survey for health beahviors related to brain health.\n\n If you have a low score or any specific concerns, we recommend that you review your results with your healthcare provider.\n\n Check out our learning section for more information on how to improve your brain health.",
);

ResultsInfoModel cogHealthInfo = ResultsInfoModel(
  title: 'CogHealth Screening Test',
  introText:
      "The CogHealth Screening Test is a simpler version of the mini mental status examination. It is designed to give you general insights into basic memory and cognitive tasks. Here is a breakdown of the test: ",
  resultListItems: [
    ResultListItem(
      boldText: "Assessment Areas: ",
      regularText:
          "The CogHealth Screening Test evaluates areas of 'executive function' of which memory, task completion, and problem solving are three elements.",
    ),
    ResultListItem(
      boldText: "Scoring System: ",
      regularText:
          "The CHST scores are weighted towoards more difficult tasks. The maximum score is 10.",
    ),
    ResultListItem(
      boldText: "Score Interpretation: ",
      regularText:
          "While a score of 7 or higher is considered normal, a lower score is not necessarily indicative of a problem. We recommend using the CHST as a screening tool, not for diagnostic purposes.",
    ),
    ResultListItem(
      boldText: "Improving Cognitive Health: ",
      regularText:
          "Lifestyle factors are the most important, actionable ways to improve cognitive health. There is good evidence that olfactory enrichment with essential oils can be a powerful, ancillary tool for supporting memory and cognitive health.",
    ),
    ResultListItem(
      boldText: "Next Steps ",
      regularText:
          "If you have a low score (e.g. 5 or less) we strongly recommend that you review your results with your healthcare provider. We have a number of resources in our learning section that can help you with supporting your cognitive health.",
    ),
  ],
  imagePath: 'lib/assets/images/brain_health_onboarding.png',
  conclusionText:
      "We recommend using the CogHealth Screening Test and the McCance Brain Care Score as basic screening tools,. \n\n You can repeat the tests after a few months after making lifestyle changes and our olfactory enrichment protocol to assess your progress.",
);
