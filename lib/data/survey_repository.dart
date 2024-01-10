import 'package:cog_screen/data/brain_care_data.dart';
import 'package:cog_screen/data/sleep_data.dart';
import 'package:cog_screen/models/survey_model.dart';
import 'package:flutter/material.dart';

class SurveyRepository {
  // Static map to hold survey data. The key is the survey type.
  static final Map<String, List<SurveyCategory>> _surveys = {
    'Brain Health': brainCareData,
    'Sleep': sleepData,
    // Future surveys can be added here.
  };
  //todo Set this back to normal
    static List<SurveyCategory> getSurveyData(String surveyType) {
    debugPrint('Requested Survey Type: $surveyType');
    final data = _surveys[surveyType] ?? [];
    debugPrint('Survey Data Length: ${data.length}');
    return data;
  }
}
