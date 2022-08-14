import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/view_all/widgets/custom_date.dart';
import 'package:my_wallet/view/screens/view_all/widgets/custom_month.dart';
import 'package:my_wallet/view/screens/view_all/widgets/custom_period.dart';
import 'package:provider/provider.dart';

class ViewAllFunctions {
  static Future<void> selectDate(context) async {
    final customSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (customSelectedDate == null) {
      return;
    } else {
      CoreFunctions.pushToNext(context, CustomDateList(customDate: customSelectedDate));
    }
  }

  static Future<void> selectMonth({required context, String? locale}) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final customSelectedMonth = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      locale: localeObj,
    );
    if (customSelectedMonth == null) {
      return;
    } else {
      final List<dynamic> customMonthList =
          Provider.of<TransactionListProvider>(context, listen: false)
              .customMonthStatistics(customSelectedMonth);
      CoreFunctions.pushToNext(
          context,
          CustomMonthList(
              customMonthIncome: customMonthList[0],
              customMonthExpense: customMonthList[1],
              customSelected: customSelectedMonth));
    }
  }

  static Future<void> selectPeriod(context) async {
    final customSelectedFirstDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      helpText: 'SELECT FIRST DATE',
    );
    if (customSelectedFirstDate == null) {
      return;
    } else {
      final customSelectedLastDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: customSelectedFirstDate.add(const Duration(days: 1)),
        lastDate: DateTime.now(),
        helpText: 'SELECT LAST DATE',
      );
      if (customSelectedLastDate == null) {
        return;
      } else {
        CoreFunctions.pushToNext(
            context,
            CustomPeriodList(
                customSelectedFirstDate: customSelectedFirstDate,
                customSelectedLastDate: customSelectedLastDate));
      }
    }
  }

}
