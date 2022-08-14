import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/controller/data_base/db_abstract.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/models/transaction_model.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TransactionDB implements TransactionDbFunctions {
  final String transactionDbName = 'transaction_db';
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel value, context) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDB.put(value.id, value);
    refreshUi(context);
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    return transactionDB.values.toList();
  }

  Future<void> refreshUi(context) async {
    final transactionList = await getAllTransaction();
    transactionList.sort((a, b) => b.selectedDate.compareTo(a.selectedDate));
    Provider.of<TransactionListProvider>(context, listen: false)
        .addAllTransactions(data: transactionList);
  }

  @override
  Future<void> updateTransaction({required data, required id, context}) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDB.put(id, data);
    refreshUi(context);
  }

  @override
  Future<void> deleteTransaction(String id, context) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionDB.delete(id);
    refreshUi(context);
  }

  Future<void> appReset(ctx) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDB.clear();
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    CoreFunctions.pushAndRemoveUntilNext(ctx, const SplashScreen());
  }
}
