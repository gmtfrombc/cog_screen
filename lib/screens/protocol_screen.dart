import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/models/protocol_model.dart';
import 'package:cog_screen/providers/health_element_provider.dart';
import 'package:cog_screen/screens/essential_oils_screen.dart';
import 'package:cog_screen/widgets/highlighter.dart';
import 'package:flutter/material.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/utilities/brain_constants.dart';

class ProtocolScreen extends StatelessWidget {
  const ProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final healthElementProvider = Provider.of<HealthElementProvider>(context);
    final healthElement = healthElementProvider.currentHealthElement;
    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeaderSection(context, healthElement!),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        BrainConstants.protocol,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      _buildEssentialOilList(healthElement),
                      const SizedBox(height: 20),
                      _buildUsageInstructions(healthElement),
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
                Icons.arrow_back,
                color: Colors.black,
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

  Widget _buildEssentialOilList(HealthElement healthElement) {
    ProtocolModel protocolModel = healthElement.protocol!;
    EOList oilList = protocolModel.oils;
    List<String> oils = oilList.oils;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HighlightedTitle(
          text: 'Recommended Essential Oils',
          highlightColor: Colors.yellow, // Choose your highlight color
        ),
        const SizedBox(height: 10),
        ...oils.map((oil) => Text('• $oil')),
      ],
    );
  }

  Widget _buildUsageInstructions(HealthElement healthElement) {
    ProtocolModel protocolModel = healthElement.protocol!;
    ProtocolInstructions instructions = protocolModel.protcolInstructions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HighlightedTitle(
          text: instructions.title,
          highlightColor: Colors.greenAccent, // Choose your highlight color
        ),
        const SizedBox(height: 10),
        Text(
          instructions.instructions,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        const HighlightedTitle(
          text: 'Frequency and Duration',
          highlightColor: Colors.orangeAccent, // Choose your highlight color
        ),
        const SizedBox(height: 10),
        Text(
          instructions.frequencyDuration,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(
      BuildContext context, HealthElement healthElement) {
    ProtocolModel protocolModel = healthElement.protocol!;
    final header = protocolModel.header;
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
              header.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 30,
          child: Text(
            header.title,
            style: const TextStyle(
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
