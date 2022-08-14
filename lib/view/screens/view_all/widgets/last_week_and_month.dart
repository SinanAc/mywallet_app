import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class LastWeekAndMonthList extends StatelessWidget {
  final int days;
  final String text;
  const LastWeekAndMonthList({Key? key, required this.days, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(
      builder: (context, transactionData, Widget? _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(text),
          ),
          body: transactionData.transactionList
                  .where((element) => element.selectedDate
                      .isAfter(DateTime.now().subtract(Duration(days: days))))
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
                    return data.selectedDate.isAfter(
                            DateTime.now().subtract(Duration(days: days)))
                        ? DisplayCard(
                            data: data, isCustom: false, isSearch: false)
                        : const SizedBox();
                  },
                  itemCount: transactionData.transactionList.length,
                ),
        );
      },
    );
  }
}
