import 'package:flutter/material.dart';
import 'package:cog_screen/utilities/constants.dart'; // Import constants

class EssentialOilScreen extends StatelessWidget {
  const EssentialOilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('lib/assets/images/dT_EO9.jpeg'), // Corrected the path
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Library',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 250, // Set a height for the horizontal list
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCard(
                    context,
                    'Understanding Cognitive Health',
                    AppConstants.understandingCognitiveHealth,
                    '/basics',
                    'lib/assets/images/dT_EO6.jpeg',
                  ),
                  _buildCard(
                    context,
                    'Lifestyle Strategies for a Healthy Brain',
                    AppConstants.lifestyleStrategies,
                    '/lifestyle',
                    'lib/assets/images/dT_EO7.jpeg',
                  ),
                  _buildCard(
                    context,
                    'Essential Oils, Memory, and Cognitive Health',
                    AppConstants.essentialOils,
                    '/essentialOils',
                    'lib/assets/images/dT_EO8.jpeg',
                  ),
                  _buildCard(
                    context,
                    'Essential Oils, Memory, and Cognitive Health',
                    AppConstants.essentialOils,
                    '/essentialOils',
                    'lib/assets/images/dT_EO5.jpeg',
                  ),
                  // Add more cards as needed
                ],
              ),
            ),
            // Other widgets...
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description,
      String route, String imagePath) {
    return Card(
      margin: const EdgeInsets.all(8.0), // Add some margin around each card
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: SizedBox(
          width: 180, // Fixed width for each card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120, // Fixed height for the image
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
