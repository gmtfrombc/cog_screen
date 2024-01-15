import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllResultsScreen extends StatefulWidget {
  const AllResultsScreen({super.key});

  @override
  State<AllResultsScreen> createState() => _AllResultsScreenState();
}

class _AllResultsScreenState extends State<AllResultsScreen> {
  String? selectedAssessment;
  List<String> assessmentTitles = [];

  @override
  void initState() {
    super.initState();
    _fetchAssessmentTitles();
  }

  Future<void> _fetchAssessmentTitles() async {
    var titles = await FirebaseService().fetchAssessmentTitles();
    setState(() {
      debugPrint('titles: $titles');
      assessmentTitles = titles..sort(); // Sort the titles alphabetically
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    final String userId = authProvider.currentUser?.uid ?? '';

    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    // Fetch data using FutureBuilder or similar approach
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: true,
        showLeading: false,
      ),
      showDrawer: true,
      showAppBar: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: Scaffold(
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'SELECT AN ASSESSMENT',
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoSlab(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[300]!, width: 2), // Faint border
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: DropdownButton<String>(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  isExpanded: true,
                  underline:
                      const SizedBox(), // This makes the dropdown take the full width
                  value: selectedAssessment,
                  items: assessmentTitles
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAssessment = newValue;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: selectedAssessment == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Image.asset(
                            'lib/assets/images/survey_results_onboarding.png',
                            width: 250,
                          ),
                          const SizedBox(
                              height:
                                  20), // Provides space between the image and the text
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  'Choose an assessment to view your results',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoSlab(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : FutureBuilder<List<Map<String, dynamic>>>(
                      // Fetch results based on the selected assessment title
                      future: FirebaseService()
                          .getUserResultsByTitle(userId, selectedAssessment!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          var assessmentResults = snapshot.data;
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                if (assessmentResults != null &&
                                    assessmentResults.isNotEmpty)
                                  _buildTestResultsSection(
                                    selectedAssessment!, // Use the selected title
                                    assessmentResults,
                                    'brainhealthscore', // Update this key if necessary
                                  )
                                else
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'lib/assets/images/survey_results_onboarding.png',
                                        width: 250,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0,
                                          vertical: 20.0,
                                        ),
                                        child: Text(
                                          'There are no results available for $selectedAssessment. \n\nComplete an the assessment first to view your results.',
                                          style: GoogleFonts.robotoSlab(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            letterSpacing: 0.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        } else {
                          return const Text("No results found");
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultsSection(
      String title, List<Map<String, dynamic>>? results, String scoreKey) {
    if (results == null) {
      return Column(
        children: [
          Text("$title - No data available"),
        ],
      );
    }
    var sortedResults = List<Map<String, dynamic>>.from(results)
      ..sort(
          (a, b) => (a['date'] as Timestamp).compareTo(b['date'] as Timestamp));

    DateTime firstDate = (sortedResults.first['date'] as Timestamp).toDate();
    DateTime lastDate = (sortedResults.last['date'] as Timestamp).toDate();
    int totalSpan = lastDate.difference(firstDate).inDays;

    List<BarChartGroupData> barGroups = [];
    for (var result in sortedResults) {
      DateTime date = (result['date'] as Timestamp).toDate();
      int daysSinceFirst = date.difference(firstDate).inDays;
      double relativePosition = totalSpan > 0
          ? (daysSinceFirst / totalSpan) * (sortedResults.length - 1)
          : 0;

      double y = 0;
      if (result['score'] != null) {
        debugPrint('The value of result[score]: ${result['score']}');
        y = (result['score'] as num).toDouble();
      } else {
        debugPrint('else clause: The value of result[score]: null');
        y = 10.0; // Or any other default value if needed
        continue;
      }
      barGroups.add(BarChartGroupData(
        x: relativePosition.round(),
        barRods: [
          BarChartRodData(
            toY: y,
            color: AppTheme.secondaryColor,
            width: 15,
          ),
        ],
      ));
    }

    double maxY = (scoreKey == 'coghealthscore') ? 10 : 25;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              title,
              style: GoogleFonts.robotoSlab(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5),
            ),
          ),
          SizedBox(
            height: 260,
            width: 360,
            child: _buildChart(barGroups, sortedResults, maxY),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 8.0,
            ),
            child: Container(
              width: 360,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primaryColor.withOpacity(
                      0.6,
                    ), // Top color of the gradient
                    AppTheme.primaryColor.withOpacity(
                      0.1,
                    ), // Top color of the gradient
                  ],
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Score',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(results.length, (index) {
                      debugPrint('The value of index: $index');
                      var result = results[index];
                      debugPrint('The value of result: $result');
                      String formattedDate = DateFormat('MM/dd/yyyy')
                          .format(result['date'].toDate());

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Score: ${result['score']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(
    List<BarChartGroupData> barGroups,
    List<Map<String, dynamic>> results,
    double maxY,
  ) {
    return Material(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            20.0, 5.0, 10.0, 5.0), // Adjust padding as needed
        child: SizedBox(
          height: 200,
          width: 350,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY, // Adjust according to your data
              barGroups: barGroups,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      String date = DateFormat('MM/dd').format(
                          (results[value.toInt()]['date'] as Timestamp)
                              .toDate());
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(date,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10)),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: false,
                horizontalInterval: 1, // Adjust the interval as needed
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  );
                },
                drawVerticalLine: true,
                verticalInterval: 1, // Adjust the interval as needed
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Colors.black,
                    strokeWidth: 1.0,
                  );
                },
              ),
              borderData: FlBorderData(
                show: false,
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(
    List<Map<String, dynamic>> results,
    double value,
    TitleMeta meta,
  ) {
    var uniqueDates = results
        .map((result) => (result['date'] as Timestamp).toDate())
        .toSet()
        .toList()
      ..sort((a, b) => a.compareTo(b));

    int index = value.round();
    if (index < 0 || index >= uniqueDates.length) return Container();

    String text = DateFormat('MM/dd').format(uniqueDates[index]);

    // Check number of data points for the current date
    int dataPointCount = results
        .where((result) =>
            (result['date'] as Timestamp)
                .toDate()
                .compareTo(uniqueDates[index]) ==
            0)
        .length;

    // Modify label display based on data point count (e.g., add count after date)
    if (dataPointCount > 1) {
      text += " ($dataPointCount)";
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    // Format the score value into a string
    String text =
        '${value.toInt()}'; // Or use more complex formatting if needed
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }
}
