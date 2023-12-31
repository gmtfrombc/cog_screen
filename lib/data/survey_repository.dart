import 'package:cog_screen/data/brain_care_data.dart';
import 'package:cog_screen/data/sleep_data.dart';
import 'package:cog_screen/models/survey_model.dart';

class SurveyRepository {
  // Static map to hold survey data. The key is the survey type.
  static final Map<String, List<SurveyCategory>> _surveys = {
    'Brain Health': brainCareData,
    'Sleep': sleepData,
    // Future surveys can be added here.
  };
  // Method to retrieve survey data based on type.
  static List<SurveyCategory> getSurveyData(String surveyType) {
    return _surveys[surveyType] ?? [];
  }
}
