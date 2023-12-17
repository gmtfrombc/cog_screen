import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllResultsScreen extends StatelessWidget {
  const AllResultsScreen({super.key});

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
        body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
          future: FirebaseService().getUserResults(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              var cogHealthResults = snapshot.data!['coghealth'];
              var brainHealthResults = snapshot.data!['brainhealth'];
              debugPrint(cogHealthResults.toString());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTestResultsSection(
                      'CogHealth Test Results',
                      cogHealthResults,
                      'coghealthscore',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Divider(
                        color: Colors.grey
                            .withOpacity(0.3), // Color of the divider
                        thickness: 1, // Thickness of the divider
                      ),
                    ),
                    _buildTestResultsSection(
                      'Brain Score Results',
                      brainHealthResults,
                      'brainhealthscore',
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

      double y = result[scoreKey].toDouble();
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 280,
            width: 350,
            child: _buildChart(barGroups, sortedResults, maxY),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Score',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(results.length, (index) {
                    var result = results[index];
                    String scoreKey = title.contains('CogHealth')
                        ? 'coghealthscore'
                        : 'brainhealthscore';
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
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${result[scoreKey]}',
                              style: const TextStyle(fontSize: 16),
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
        ],
      ),
    );
  }

  Widget _buildChart(
    List<BarChartGroupData> barGroups,
    List<Map<String, dynamic>> results,
    double maxY,
  ) {
    return BarChart(
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
                    (results[value.toInt()]['date'] as Timestamp).toDate());
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(date,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 10)),
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
              color: Colors.grey,
              strokeWidth: 0.5,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey, width: 0.5),
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
