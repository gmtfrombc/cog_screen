import 'package:cog_screen/data/brain_care_data.dart';
import 'package:cog_screen/data/cog_health_data.dart';
import 'package:cog_screen/data/pm_sleep_data.dart';
import 'package:cog_screen/data/psqi_data.dart';
import 'package:cog_screen/data/sleep_hygiene_data.dart';
import 'package:cog_screen/models/survey_model.dart';

class SurveyRepository {
  static final Map<String, List<SurveyCategory>> _surveys = {
    'Brain Health': brainCareData,
    'PowerME Sleep Assessment': sleepData,
    'PSQI': psqiData,
    'Sleep Hygiene Tool': sleepHygiene,
    'CogHealth Screening Test': cogHealth,
  };
  static List<SurveyCategory> getSurveyData(String surveyType) {
    final data = _surveys[surveyType] ?? [];
    return data;
  }
}
