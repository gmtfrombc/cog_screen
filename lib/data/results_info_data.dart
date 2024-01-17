import 'package:cog_screen/models/results_info_model.dart';

ResultsInfoModel sleepHygeineToolInfo = ResultsInfoModel(
  title: 'Sleep Hygeine Tool',
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
          "RAvoiding caffeine, nicotine, and other stimulants particularly in the hours before sleep.",
    ),
    ResultListItem(
      boldText: "Mindful Eating and Drinking: ",
      regularText:
          "Avoiding heavy meals, alcohol, and large amounts of fluids before bedtime.",
    ),
  ],
  imagePath: 'lib/assets/images/sleep_assessment3.png',
  conclusionText:
      "If your sleep hygiene test is lower than you would like, follow the above instructioins and explore the content we've provided in the learning section.",
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
