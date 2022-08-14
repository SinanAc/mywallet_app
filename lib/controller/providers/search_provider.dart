import 'package:flutter/material.dart';
import 'package:my_wallet/models/transaction_model.dart';

class SearchProvider extends ChangeNotifier {
  // variables
  bool initSearching = true;
  List<TransactionModel> resultList = [];
  // methods
  void runFilter(
      String enteredKeyword, List<TransactionModel> transactionList) {
    initSearching = false;
    if (enteredKeyword.isEmpty) {
      resultList = transactionList;
    } else {
      resultList = transactionList
              .where((element) => element.categoryTypeName
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList() +
          transactionList
              .where((element) => element.amount
                  .toString()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();
    }
    notifyListeners();
  }
}
