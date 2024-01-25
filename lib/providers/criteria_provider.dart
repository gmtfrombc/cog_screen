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
  void resetCriteria() {
    // Reassign criteriaList with a fresh copy of criteriaDataList
    criteriaList = criteriaDataList
        .map((criteria) => Criteria(statement: criteria.statement))
        .toList();
    notifyListeners();
  }
  bool canProceed() {
    return criteriaList.any((criteria) => criteria.response == true);
  }
}

