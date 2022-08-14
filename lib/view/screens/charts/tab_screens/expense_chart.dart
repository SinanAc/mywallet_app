import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/chart_provider.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/view/screens/charts/functions/chart_data.dart';
import 'package:my_wallet/view/screens/charts/widgets/income_expense.dart';
import 'package:my_wallet/view/screens/charts/widgets/no_data.dart';
import 'package:my_wallet/view/core/category_list.dart';
import 'package:provider/provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButton(
        value: Provider.of<ChartProvider>(context).expenseChartCategoryType,
        items: CategoryLists.instance.chartCategories,
        onChanged: (value) {
          Provider.of<ChartProvider>(context, listen: false)
              .expenseChartCategoryType = value.toString();
        },
      ),
      Consumer<TransactionListProvider>(
          builder: (context, transactionData, Widget? _) {
        // expense lists
        final expenseList = transactionData.transactionList
            .where((element) => element.incomeOrExpense == 'Expense')
            .toList();
        final lastMonthExpenseList = expenseList
            .where((element) => element.selectedDate
                .isAfter(DateTime.now().subtract(const Duration(days: 31))))
            .toList();
        final hundredDaysExpenseList = expenseList
            .where((element) => element.selectedDate
                .isAfter(DateTime.now().subtract(const Duration(days: 101))))
            .toList();
        // expense lists chart data
        final List<ChartData> expenseTransactionList =
            ChartData.chartLogic(expenseList);
        final List<ChartData> lastMonthExpenseTransactionList =
            ChartData.chartLogic(lastMonthExpenseList);
        final List<ChartData> hundredDaysExpenseTransactionList =
            ChartData.chartLogic(hundredDaysExpenseList);
        // chart in ui    
        return Expanded(
          child: Provider.of<ChartProvider>(context).expenseChartCategoryType ==
                  'All'
              ? IncomeExpenseChartWidget(
                  transactionList: expenseTransactionList,
                )
              : Provider.of<ChartProvider>(context).expenseChartCategoryType ==
                          'Last 30 days' &&
                      lastMonthExpenseList.isNotEmpty
                  ? IncomeExpenseChartWidget(
                      transactionList: lastMonthExpenseTransactionList,
                    )
                  : Provider.of<ChartProvider>(context)
                                  .expenseChartCategoryType ==
                              'Last 30 days' &&
                          lastMonthExpenseList.isEmpty
                      ? const ChartNoDataWidget()
                      : Provider.of<ChartProvider>(context)
                                      .expenseChartCategoryType ==
                                  'Last 100 days' &&
                              hundredDaysExpenseList.isNotEmpty
                          ? IncomeExpenseChartWidget(
                              transactionList:
                                  hundredDaysExpenseTransactionList,
                            )
                          : Provider.of<ChartProvider>(context)
                                          .expenseChartCategoryType ==
                                      'Last 100 days' &&
                                  hundredDaysExpenseList.isEmpty
                              ? const ChartNoDataWidget()
                              : const SizedBox(),
        );
      })
    ]);
  }
}
