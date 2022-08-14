import 'package:my_wallet/models/transaction_model.dart';

class AllChartData {
  String? incomeOrExpense;
  double? amount;

  AllChartData({
    this.incomeOrExpense,
    this.amount,
  });

  static allChartLogic(List<TransactionModel> transactionList) {
    double value = 0;
    String incomeExpense;
    List visited = [];
    List<AllChartData> newChartData = [];

    for (var i = 0; i < transactionList.length; i++) {
      visited.add(0);
    }

    for (var i = 0; i < transactionList.length; i++) {
      value = transactionList[i].amount;
      incomeExpense = transactionList[i].incomeOrExpense;
      for (var j = i + 1; j < transactionList.length; j++) {
        if (transactionList[i].incomeOrExpense ==
            transactionList[j].incomeOrExpense) {
          value += transactionList[j].amount;
          visited[j] = -1;
        }
      }

      if (visited[i] != -1) {
        newChartData
            .add(AllChartData(incomeOrExpense: incomeExpense, amount: value));
      }
    }
    return newChartData;
  }
}
