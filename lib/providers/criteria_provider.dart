import 'package:cog_screen/data/criteria_data.dart';
import 'package:cog_screen/models/criteria.dart';
import 'package:flutter/material.dart';

class CriteriaProvider extends ChangeNotifier {
  List<Criteria> criteriaList = criteriaDataList;
 
  void setResponse(int index, bool response) {
    criteriaList[index].response = response;
    notifyListeners();
  }

  bool allAnswered() {
    return criteriaList.every((criteria) => criteria.response != null);
  }

  bool canProceed() {
    // Add logic to determine if the user can proceed based on their responses
    // For instance, if any 'Yes' response excludes the user, you can check for that
    return criteriaList.any((criteria) => criteria.response == true);
  }
}

