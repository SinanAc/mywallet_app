import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class CustomPeriodList extends StatelessWidget {
  const CustomPeriodList({
    Key? key,
    required this.customSelectedFirstDate,
    required this.customSelectedLastDate,
  }) : super(key: key);
  final DateTime customSelectedFirstDate;
  final DateTime customSelectedLastDate;
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(
      builder: (context, transactionData, Widget? _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${DateFormat.MMMd().format(customSelectedFirstDate)} - ${DateFormat.MMMd().format(customSelectedLastDate)}'),
          ),
          body: transactionData.transactionList
                  .where((element) =>
                      element.selectedDate.isAfter(customSelectedFirstDate
                          .subtract(const Duration(days: 1))) &&
                      element.selectedDate.isBefore(
                          customSelectedLastDate.add(const Duration(days: 1))))
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
                    return data.selectedDate.isAfter(customSelectedFirstDate
                                .subtract(const Duration(days: 1))) &&
                            data.selectedDate.isBefore(customSelectedLastDate
                                .add(const Duration(days: 1)))
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
