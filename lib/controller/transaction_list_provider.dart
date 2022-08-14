import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/models/transaction_model.dart';

class TransactionListProvider extends ChangeNotifier {
  // list of all transactions
  List<TransactionModel> transactionList = [];

  // add all transactions to list
  void addAllTransactions({required data}) {
    transactionList.clear();
    transactionList.addAll(data);
    notifyListeners();
  }

  // total transaction statistics
  List<double> totalStatistics() {
    double incomeTotal = 0;
    double expenseTotal = 0;
    for (int i = 0; i < transactionList.length; i++) {
      transactionList[i].incomeOrExpense == 'Income'
          ? incomeTotal += transactionList[i].amount
          : expenseTotal += transactionList[i].amount;
    }
    double totalBalance = incomeTotal - expenseTotal;
    totalBalance < 0 ? totalBalance = 0 : totalBalance;
    return [totalBalance, incomeTotal, expenseTotal];
  }

  // month wise transaction statistics
  List<dynamic> customMonthStatistics(customSelected) {
    double customMonthIncome = 0;
    double customMonthExpense = 0;

    final customMonthData = transactionList
        .where((element) =>
            DateFormat.yMMMM().format(element.selectedDate) ==
            DateFormat.yMMMM().format(customSelected))
        .toList();

    for (int i = 0; i < customMonthData.length; i++) {
      customMonthData[i].incomeOrExpense == 'Income'
          ? customMonthIncome += customMonthData[i].amount
          : customMonthExpense += customMonthData[i].amount;
    }
    notifyListeners();
    return [customMonthIncome, customMonthExpense, customMonthData];
  }
}