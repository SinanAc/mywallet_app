import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/search/search_screen.dart';
import 'package:my_wallet/view/widgets/all_transactions.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              CoreFunctions.pushToNext(context, const SearchScreen());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Provider.of<TransactionListProvider>(context, listen: false)
                .transactionList
                .isEmpty
            ? const NoDataImage(
                image: 'assets/images/homeNoData.svg',
                text: 'No transaction data to display \nStart adding now')
            : const AllTransactionList(isHomeScreen: false),
      ),
    );
  }
}
