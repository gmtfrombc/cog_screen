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
        "Welcome to the PowerME Integrative Health App from PowerME Labs! \n\nHere you can explore into a wealth of insights and practical strategies, designed to enhance key aspects of your health such as energy, memory, emotional health, sleep, healthy aging, and more.",
  ),
  OnboardingModel(
    imagePath: 'lib/assets/images/onboarding_image3.png',
    description:
        "In PowerME, we  take an integrative approach, combining the best of conventional and complementary medicine.\n\nFrom the home page, you can check out any of our modules.\n\nYou can take assessments, learn about the latest research, and find practical strategies to improve your health.",
  ),
  OnboardingModel(
    imagePath: 'lib/assets/images/onboarding_image2.png',
    description:
        "In order for us to provide you with clinically-related information, we do ask you to sign the following medical consent form.\n\nDuring this test phase, we won't collect health information. But stay tuned for more features as our program evolves. ",
  ),
  // Add other onboarding models as needed
];
//      "Welcome to the PowerME Integrative Health App from PowerME Labs! \n\nHere you can dive into a wealth of insights and practical strategies, designed to enhance vital aspects of your health such as brain function, sleep quality, metabolic balance, and more."\n\n"During this test phase, we won't collect health information. But stay tuned for more features as our program evolves." \n\nWelcome aboard!\n\nYour PowerME Team ";

