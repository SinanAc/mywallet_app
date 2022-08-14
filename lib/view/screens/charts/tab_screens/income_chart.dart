import 'package:flutter/material.dart';
import 'package:my_wallet/controller/chart_provider.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/screens/charts/functions/chart_data.dart';
import 'package:my_wallet/view/screens/charts/widgets/income_expense.dart';
import 'package:my_wallet/view/screens/charts/widgets/no_data.dart';
import 'package:my_wallet/view/core/category_list.dart';
import 'package:provider/provider.dart';

class IncomeChart extends StatelessWidget {
  const IncomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButton(
        value: Provider.of<ChartProvider>(context).incomeChartCategoryType,
        items: CategoryLists.instance.chartCategories,
        onChanged: (value) {
          Provider.of<ChartProvider>(context, listen: false)
              .incomeChartCategoryType = value.toString();
        },
      ),
      Consumer<TransactionListProvider>(
          builder: (context, transactionData, Widget? _) {
        final incomeList = transactionData.transactionList
            .where((element) => element.incomeOrExpense == 'Income')
            .toList();
        final lastMonthIncomeList = incomeList
            .where((element) => element.selectedDate
                .isAfter(DateTime.now().subtract(const Duration(days: 31))))
            .toList();
        final hundredDaysIncomeList = incomeList
            .where((element) => element.selectedDate
                .isAfter(DateTime.now().subtract(const Duration(days: 101))))
            .toList();
        final List<ChartData> incomeTransactionList =
            ChartData.chartLogic(incomeList);
        final List<ChartData> lastMonthIncomeTransactionList =
            ChartData.chartLogic(lastMonthIncomeList);
        final List<ChartData> hundredDaysIncomeTransactionList =
            ChartData.chartLogic(hundredDaysIncomeList);
        return Expanded(
          child: Provider.of<ChartProvider>(context).incomeChartCategoryType ==
                  'All'
              ? IncomeExpenseChartWidget(
                  transactionList: incomeTransactionList,
                )
              : Provider.of<ChartProvider>(context).incomeChartCategoryType ==
                          'Last 30 days' &&
                      lastMonthIncomeList.isNotEmpty
                  ? IncomeExpenseChartWidget(
                      transactionList: lastMonthIncomeTransactionList,
                    )
                  : Provider.of<ChartProvider>(context)
                                  .incomeChartCategoryType ==
                              'Last 30 days' &&
                          lastMonthIncomeList.isEmpty
                      ? const ChartNoDataWidget()
                      : Provider.of<ChartProvider>(context)
                                      .incomeChartCategoryType ==
                                  'Last 100 days' &&
                              hundredDaysIncomeList.isNotEmpty
                          ? IncomeExpenseChartWidget(
                              transactionList: hundredDaysIncomeTransactionList)
                          : Provider.of<ChartProvider>(context)
                                          .incomeChartCategoryType ==
                                      'Last 100 days' &&
                                  hundredDaysIncomeList.isEmpty
                              ? const ChartNoDataWidget()
                              : const SizedBox(),
        );
      })
    ]);
  }
}
