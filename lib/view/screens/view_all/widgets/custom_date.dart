import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class CustomDateList extends StatelessWidget {
  const CustomDateList({Key? key, required this.customDate}) : super(key: key);
  final DateTime customDate;
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(
      builder: (context, transactionData, Widget? _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(DateFormat.yMMMd().format(customDate)),
          ),
          body: transactionData.transactionList
                  .where((element) =>
                      DateFormat.yMMMMd().format(element.selectedDate) ==
                      DateFormat.yMMMMd().format(customDate))
                  .toList()
                  .isEmpty
              ? const NoDataImage(
                  image: 'assets/images/homeNoData.svg',
                  text: 'No data available \non selected date')
              : ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (ctx, index) {
                    final data = transactionData.transactionList[index];
                    return DateFormat.yMMMMd().format(data.selectedDate) ==
                            DateFormat.yMMMMd().format(customDate)
                        ? DisplayCard(
                            data: data, isCustom: true, isSearch: false)
                        : const SizedBox();
                  },
                  itemCount: transactionData.transactionList.length,
                ),
        );
      },
    );
  }
}
