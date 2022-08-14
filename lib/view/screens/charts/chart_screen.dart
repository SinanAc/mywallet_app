import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/chart_provider.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/screens/charts/tab_screens/all_chart.dart';
import 'package:my_wallet/view/screens/charts/tab_screens/expense_chart.dart';
import 'package:my_wallet/view/screens/charts/tab_screens/income_chart.dart';
import 'package:my_wallet/view/screens/charts/widgets/tab_widget.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChartProvider>(context, listen: false).allChartCategoryType =
          'All';
      Provider.of<ChartProvider>(context, listen: false)
          .incomeChartCategoryType = 'All';
      Provider.of<ChartProvider>(context, listen: false)
          .expenseChartCategoryType = 'All';
    });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Charts'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Consumer<TransactionListProvider>(
              builder: (context, transactionData, Widget? _) {
            final data = transactionData.transactionList;
            final incomeList = data
                .where((element) => element.incomeOrExpense == 'Income')
                .toList();
            final expenseList = data
                .where((element) => element.incomeOrExpense == 'Expense')
                .toList();
            return incomeList.isEmpty || expenseList.isEmpty
                ? const NoDataImage(
                    image: 'assets/images/chartNoDataSvg.svg',
                    text:
                        'No enough transactions to run a chart. Add both income and expense transactions',
                  )
                : Column(children: [
                    const SizedBox(height: 10),
                    TabBar(
                      unselectedLabelColor: kIndigoAccentColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const[
                        TabWidget(text: 'All'),
                        TabWidget(text: 'Income'),
                        TabWidget(text: 'Expense'),
                      ],
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kIndigoAccentColor),
                    ),
                    const SizedBox(height: 15),
                    const Expanded(
                      child: TabBarView(children: [
                        AllChart(),
                        IncomeChart(),
                        ExpenseChart(),
                      ]),
                    ),
                  ]);
          }),
        ),
      ),
    );
  }
}
