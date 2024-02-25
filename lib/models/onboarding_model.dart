class OnboardingModel {
  final String imagePath;
  final String description;

  OnboardingModel({
    required this.imagePath,
    required this.description,
  });
}

List<OnboardingModel> onboardingData = [
  OnboardingModel(
    imagePath: 'lib/assets/images/onboarding_image1.png',
    description:
        "Welcome to the PowerME Integrative Health App.\n\nGet ready to explore a broad range of practical health and wellness strategies.",
  ),
  OnboardingModel(
    imagePath: 'lib/assets/images/onboarding_image3.png',
    description:
        "In PowerME, we  take an integrative approach to healthcare, combining the best of conventional and complementary medicine.\n\nYou can take assessments, learn about the latest research, and find practical strategies to improve and support your health.",
  ),
  OnboardingModel(
    imagePath: 'lib/assets/images/onboarding_image2.png',
    description:
        "In order for us to provide you with clinically-related information, we ask you to accept the terms of use below.\n\n And stay tuned for more features as our program evolves. ",
  ),
];
