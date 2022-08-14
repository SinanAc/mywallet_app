import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class TodayTransactionsList extends StatelessWidget {
  const TodayTransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
      ),
      body: Consumer<TransactionListProvider>(
        builder: (context, transactionData, Widget? _) {
          return transactionData.transactionList
                  .where((element) =>
                      DateFormat.yMMMMd().format(element.selectedDate) ==
                      DateFormat.yMMMMd().format(DateTime.now()))
                  .toList()
                  .isEmpty
              ? const NoDataImage(
                  image: 'assets/images/homeNoData.svg',
                  text: 'No data available today')
              : ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (ctx, index) {
                    final data = transactionData.transactionList[index];
                    return DateFormat.MMMMd().format(data.selectedDate) ==
                            DateFormat.MMMMd().format(DateTime.now())
                        ? DisplayCard(
                            data: data, isCustom: false, isSearch: false)
                        : const SizedBox();
                  },
                  itemCount: transactionData.transactionList.length,
                );
        },
      ),
    );
  }
}
