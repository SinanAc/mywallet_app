import 'package:flutter/material.dart';
import 'package:my_wallet/controller/chart_provider.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/screens/charts/functions/all_chart_data.dart';
import 'package:my_wallet/view/screens/charts/widgets/all_data.dart';
import 'package:my_wallet/view/screens/charts/widgets/no_data.dart';
import 'package:my_wallet/view/core/category_list.dart';
import 'package:provider/provider.dart';

class AllChart extends StatelessWidget {
  const AllChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButton(
        value: Provider.of<ChartProvider>(context).allChartCategoryType,
        items: CategoryLists.instance.chartCategories,
        onChanged: (value) {
          Provider.of<ChartProvider>(context, listen: false)
              .allChartCategoryType = value.toString();
        },
      ),
      Consumer<TransactionListProvider>(
          builder: (context, transactionData, Widget? _) {
        final data = transactionData.transactionList;
        final lastMonthList = data
            .where((element) => element.selectedDate
                .isAfter(DateTime.now().subtract(const Duration(days: 31))))
            .toList();
        final hundredDaysList = data
            .where((element) => element.selectedDate
                .isAfter(DateTime.now().subtract(const Duration(days: 101))))
            .toList();
        final List<AllChartData> allTransactionList =
            AllChartData.allChartLogic(transactionData.transactionList);
        final List<AllChartData> lastMonthTransactionList =
            AllChartData.allChartLogic(lastMonthList);
        final List<AllChartData> hundredDaysTransactionList =
            AllChartData.allChartLogic(hundredDaysList);
        return Expanded(
          child: Provider.of<ChartProvider>(context).allChartCategoryType ==
                  'All'
              ? AllChartWidget(transactionList: allTransactionList)
              : Provider.of<ChartProvider>(context).allChartCategoryType ==
                          'Last 30 days' &&
                      lastMonthList.isNotEmpty
                  ? AllChartWidget(transactionList: lastMonthTransactionList)
                  : Provider.of<ChartProvider>(context).allChartCategoryType ==
                              'Last 30 days' &&
                          lastMonthList.isEmpty
                      ? const ChartNoDataWidget()
                      : Provider.of<ChartProvider>(context)
                                      .allChartCategoryType ==
                                  'Last 100 days' &&
                              hundredDaysList.isNotEmpty
                          ? AllChartWidget(
                              transactionList: hundredDaysTransactionList)
                          : Provider.of<ChartProvider>(context)
                                          .allChartCategoryType ==
                                      'Last 100 days' &&
                                  hundredDaysList.isEmpty
                              ? const ChartNoDataWidget()
                              : const SizedBox(),
        );
      })
    ]);
  }
}
