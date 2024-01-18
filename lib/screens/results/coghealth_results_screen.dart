// import 'package:cog_screen/models/health_element.dart';
// import 'package:cog_screen/providers/auth_provider.dart';
// import 'package:cog_screen/providers/cog_provider.dart';
// import 'package:cog_screen/screens/base_screen.dart';
// import 'package:cog_screen/services/firebase_services.dart';
// import 'package:cog_screen/themes/app_theme.dart';
// import 'package:cog_screen/utilities/brain_constants.dart';
// import 'package:cog_screen/widgets/custom_app_bar.dart';
// import 'package:cog_screen/widgets/custom_progress_indicator.dart';
// import 'package:cog_screen/widgets/custom_text_for_title.dart';
// import 'package:cog_screen/widgets/gradient_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CogHealthResultsScreen extends StatefulWidget {
//   const CogHealthResultsScreen({super.key});

//   @override
//   State<CogHealthResultsScreen> createState() => _CogHealthResultsScreenState();
// }

// class _CogHealthResultsScreenState extends State<CogHealthResultsScreen> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     String imagePath = 'lib/assets/images/cog_health_start2.png';
//     final theme = Theme.of(context);

//     Widget content = Consumer<CogProvider>(
//       builder: (context, surveyProvider, child) {
//         String resultText =
//             'Your CogHealth Screening Score: ${surveyProvider.totalScore}/10';
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10.0,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment:
//                   CrossAxisAlignment.center, // Stretch to fill width
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     resultText,
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontSize: 26,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: Text(
//                     BrainConstants.cogHealthExplanation,
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: GradientImage(
//                     imagePath: imagePath,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: Text(
//                     BrainConstants.cogHealthMore,
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 _buildButtons(context),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     return BaseScreen(
//       authProvider: Provider.of<AuthProviderClass>(context, listen: false),
//       customAppBar: CustomAppBar(
//         title: const CustomTextForTitle(),
//         backgroundColor: AppTheme.primaryBackgroundColor,
//         showEndDrawerIcon: true,
//         showLeading: false,
//       ),
//       showDrawer: true,
//       showAppBar: true,
//       child: content, // If you want to show the AppBar
//     );
//   }

//   Widget _buildButtons(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: OutlinedButton(
//                 onPressed: () {
//                   var provider =
//                       Provider.of<CogProvider>(context, listen: false);
//                   if (provider.currentHealthElement != null) {
//                     Navigator.pushNamed(
//                       context,
//                       '/advice',
//                       arguments: provider.currentHealthElement,
//                     );
//                   } else {
//                     // Handle the case where the HealthElement is not available
//                     Navigator.pushNamed(context, '/home');
//                   }
//                   provider.restartSurvey();
//                 },
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   side: BorderSide(
//                       color: AppTheme.secondaryColor,
//                       width: 1.0), // Border color and width
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 ),
//                 child: const Text('No thanks'),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//               child: ElevatedButton(
//             style: ElevatedButtonTheme.of(context).style,
//             onPressed: _isLoading
//                 ? null
//                 : () async {
//                     setState(() => _isLoading = true);

//                     bool saveSuccessful = await _saveCogHealthResults();
//                     if (saveSuccessful && mounted) {
//                       // Set the current health element in CogProvider
//                       Provider.of<CogProvider>(context, listen: false)
//                           .setCurrentHealthElement(elements[
//                               0]); // Assuming elements[0] is your cognitive health element

//                       // Navigate to AdviceScreen
//                       Navigator.pushNamed(context, '/advice',
//                           arguments: elements[0]);

//                       // Restart the survey
//                       Provider.of<CogProvider>(context, listen: false)
//                           .restartSurvey();
//                     }

//                     if (mounted) {
//                       setState(() => _isLoading = false);
//                     }
//                   },
//             child: _isLoading
//                 ? const CustomProgressIndicator(size: 20.0)
//                 : const Text('Save my results'),
//           )),
//         ],
//       ),
//     );
//   }

//   Future<bool> _saveCogHealthResults() async {
//     final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
//     final surveyProvider = Provider.of<CogProvider>(context, listen: false);
//     final firebaseService = FirebaseService();
//     final totalScore = surveyProvider.totalScore;
//     final userId = authProvider.currentUser?.uid ?? '';

//     try {
//       await firebaseService.saveCogHealthResults(userId, totalScore);
//       return true; // Save successful
//     } catch (e) {
//       debugPrint('Error saving results: $e');
//       return false; // Save failed
//     }
//   }
// }
