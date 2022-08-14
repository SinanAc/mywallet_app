import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class IncomeAndExpenseTransactionsList extends StatelessWidget {
  final String incomeExpense;
  const IncomeAndExpenseTransactionsList(
      {Key? key, required this.incomeExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(
      builder: (context, transactionData, Widget? _) {
        return Scaffold(
            appBar: AppBar(
              title: Text(incomeExpense),
            ),
            body: transactionData.transactionList
                    .where(
                        (element) => element.incomeOrExpense == incomeExpense)
                    .toList()
                    .isEmpty
                ? const NoDataImage(
                    image: 'assets/images/homeNoData.svg',
                    text: 'No Data Available')
                : ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (ctx, index) {
                      final data = transactionData.transactionList[index];
                      return data.incomeOrExpense == incomeExpense
                          ? DisplayCard(
                              data: data, isCustom: false, isSearch: false)
                          : const SizedBox();
                    },
                    itemCount: transactionData.transactionList.length,
                  ));
      },
    );
  }
}
