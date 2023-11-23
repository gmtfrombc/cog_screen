import 'package:cog_screen/screens/essential_oils_screen.dart';
import 'package:cog_screen/widgets/highlighter.dart';
import 'package:flutter/material.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:provider/provider.dart';

class ProtocolScreen extends StatelessWidget {
  const ProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildTopImageSection(context),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'This protocol involves using a diffuser with various essential oil odorants. Follow the steps below to ensure proper usage:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      _buildEssentialOilList(),
                      const SizedBox(height: 20),
                      _buildUsageInstructions(),
                      const SizedBox(height: 20),
                      const HighlightedTitle(
                        text: 'Frequency and Duration',
                        highlightColor:
                            Colors.orangeAccent, // Choose your highlight color
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Continue this regimen at home for 6 months, changing the diffuser water daily before going to bed.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 5,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white60,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
    );
  }

  Widget _buildEssentialOilList() {
    List<String> oils = [
      'Rose',
      'Orange',
      'Eucalyptus',
      'Lemon',
      'Peppermint',
      'Rosemary',
      'Lavender'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HighlightedTitle(
          text: 'Essential Oils',
          highlightColor: Colors.yellow, // Choose your highlight color
        ),
        const SizedBox(height: 10),
        ...oils.map((oil) => Text('• $oil')),
      ],
    );
  }

  Widget _buildUsageInstructions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HighlightedTitle(
          text: 'Protocol Instructions',
          highlightColor: Colors.greenAccent, // Choose your highlight color
        ),
        SizedBox(height: 10),
        Text(
          '1. Place the diffuser near your bed.\n'
          '2. Fill the diffuser with the essential oil of the night.\n'
          '3. Turn on the diffuser when going to bed.\n'
          '4. Diffuse the essential oil for at least 2 hours.\n'
          '5. Rotate through different essential oils each night.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTopImageSection(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: ConvexBottomClipper(),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              BlendMode.colorBurn,
            ),
            child: Image.asset(
              'lib/assets/images/dT_EO8.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          bottom: 80,
          left: 30,
          child: Text(
            'Olfactory Enrichment \nProtocol',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
