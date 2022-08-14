import 'package:flutter/material.dart';

class ChartProvider extends ChangeNotifier {
  // all chart category type change here
  String _allChartCategoryType = 'All';
  get allChartCategoryType => _allChartCategoryType;
  set allChartCategoryType(value) {
    _allChartCategoryType = value;
    notifyListeners();
  }

  // income chart category type change here
  String _incomeChartCategoryType = 'All';
  get incomeChartCategoryType => _incomeChartCategoryType;
  set incomeChartCategoryType(value) {
    _incomeChartCategoryType = value;
    notifyListeners();
  }

  // expense chart category type change here
  String _expenseChartCategoryType = 'All';
  get expenseChartCategoryType => _expenseChartCategoryType;
  set expenseChartCategoryType(value) {
    _expenseChartCategoryType = value;
    notifyListeners();
  }
}
