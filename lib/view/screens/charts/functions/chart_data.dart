import 'package:my_wallet/models/transaction_model.dart';

class ChartData {
  String? categoryTypeName;
  double? amount;

  ChartData({
    this.categoryTypeName,
    this.amount,
  });

  static chartLogic(List<TransactionModel> transactionList) {
    double value;
    String category;
    List visited = [];
    List<ChartData> newChartData = [];

    for (var i = 0; i < transactionList.length; i++) {
      visited.add(0);
    }

    for (var i = 0; i < transactionList.length; i++) {
      value = transactionList[i].amount;
      category = transactionList[i].categoryTypeName;
      for (var j = i + 1; j < transactionList.length; j++) {
        if (transactionList[i].categoryTypeName ==
            transactionList[j].categoryTypeName) {
          value += transactionList[j].amount;
          visited[j] = -1;
        }
      }
      if (visited[i] != -1) {
        newChartData.add(ChartData(categoryTypeName: category, amount: value));
      }
    }
    return newChartData;
  }
}
