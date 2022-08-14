import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class CustomMonthList extends StatelessWidget {
  const CustomMonthList({
    Key? key,
    required this.customMonthIncome,
    required this.customMonthExpense,
    required this.customSelected,
  }) : super(key: key);

  final double customMonthIncome;
  final double customMonthExpense;
  final DateTime customSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMM().format(customSelected),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              7,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    kIndigoColor,
                    kBlackCardColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.aspectRatio * 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Income',
                            style: TextStyle(
                              color: kAmberColor,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('₹ $customMonthIncome',
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Expense',
                            style: TextStyle(
                              color: kAmberColor,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('₹ $customMonthExpense',
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<TransactionListProvider>(
              builder: (context, transactionData, Widget? _) {
                return transactionData.transactionList
                        .where((element) =>
                            DateFormat.yMMMM().format(element.selectedDate) ==
                            DateFormat.yMMMM().format(customSelected))
                        .toList()
                        .isEmpty
                    ? const NoDataImage(
                        image: 'assets/images/homeNoData.svg',
                        text: 'No data available on selected month')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (ctx, index) {
                          final data = transactionData.transactionList[index];
                          return DateFormat.yMMMM().format(data.selectedDate) ==
                                  DateFormat.yMMMM().format(customSelected)
                              ? DisplayCard(
                                  data: data, isCustom: true, isSearch: false)
                              : const SizedBox();
                        },
                        itemCount: transactionData.transactionList.length,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
