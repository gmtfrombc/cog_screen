import 'package:cog_screen/models/results_info_model.dart';

ResultsInfoModel resultsInfoData = ResultsInfoModel(
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
    imagePath: 'lib/assets/images/sleep_assessment_pm.jpeg',
    conclusionText:
        "If your sleep hygiene test is lower than you would like, follow the above instructioins and explore the content we've provided in the learning section.");
