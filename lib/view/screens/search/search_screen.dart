import 'package:flutter/material.dart';
import 'package:my_wallet/controller/search_provider.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/widgets/display_card.dart';
import 'package:my_wallet/view/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false).runFilter(
                    value,
                    Provider.of<TransactionListProvider>(context, listen: false)
                        .transactionList);
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  hintText: 'Search by category or amount',
                  counterText: '',
                  suffixIcon: Icon(Icons.search)),
              maxLength: 20,
            ),
          ),
          Consumer<SearchProvider>(
            builder: (context, transactionData, _) => Expanded(
                child: transactionData.resultList.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: transactionData.resultList.length,
                        itemBuilder: (context, index) {
                          final data = transactionData.resultList[index];
                          return DisplayCard(
                              data: data, isCustom: true, isSearch: true);
                        })
                    : transactionData.initSearching
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount:
                                Provider.of<TransactionListProvider>(context)
                                    .transactionList
                                    .length,
                            itemBuilder: (ctx, index) {
                              final data =
                                  Provider.of<TransactionListProvider>(context)
                                      .transactionList[index];
                              return DisplayCard(
                                  data: data, isCustom: true, isSearch: true);
                            })
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                ImageWidget(
                                    imagePath:
                                        'assets/images/noSearchResults.svg',
                                    heightSize: 0.22),
                                SizedBox(height: 5),
                                Text(
                                  'No results found',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )),
          ),
        ],
      ),
    ));
  }
}
