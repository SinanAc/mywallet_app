import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/controller/data_base/db_functions.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class AllTransactionList extends StatelessWidget {
  final bool isHomeScreen;
  const AllTransactionList({Key? key, required this.isHomeScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUi(context);
    return Consumer<TransactionListProvider>(
      builder: (ctx, transactionData, _) {
        return transactionData.transactionList.isEmpty
            ? const NoDataImage(
                image: 'assets/images/homeNoData.svg',
                text: 'No transaction data to display \nStart adding now')
            : ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (ctx, index) {
                  final data = transactionData.transactionList[index];
                  return DisplayCard(
                    data: data,
                    isCustom: false,
                    isSearch: false,
                  );
                },
                itemCount: isHomeScreen == true
                    ? transactionData.transactionList.length < 5
                        ? transactionData.transactionList.length
                        : 5
                    : transactionData.transactionList.length,
              );
      },
    );
  }
}
