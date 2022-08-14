import 'package:flutter/material.dart';
import 'package:my_wallet/controller/data_base/db_functions.dart';
import 'package:my_wallet/models/transaction_model.dart';
import 'package:my_wallet/view/core/colors.dart';

class AddProvider extends ChangeNotifier {
  // variables
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  DateTime _showDate = DateTime.now();
  String? _categoryType;
  String? _incomeOrExpense;
  // getters
  get categoryType => _categoryType;
  get incomeOrExpense => _incomeOrExpense;
  get showDate => _showDate;

  // setters
  set categoryType(value) {
    _categoryType = value;
    notifyListeners();
  }

  set incomeOrExpense(value) {
    _incomeOrExpense = value;
    notifyListeners();
  }

  set showDate(selectedDate) {
    _showDate = selectedDate;
    notifyListeners();
  }

  // submit method
  submission(context) async {
    final incomeOrExpenseValue = incomeOrExpense.toString();
    final amount = amountController.text.isEmpty
        ? 0.0
        : double.parse(amountController.text);
    final categoryTypeName = categoryType.toString();
    final selectedDate = showDate;
    final note = noteController.text;
    if (amount == 0 || amount.isNegative || categoryType == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all the fields',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kRedColor,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        incomeOrExpense: incomeOrExpenseValue,
        amount: amount,
        categoryTypeName: categoryTypeName,
        selectedDate: selectedDate,
        note: note,
      );
      TransactionDB.instance.addTransaction(transaction, context);
      Navigator.of(context).pop();
      TransactionDB.instance.refreshUi(context);
    }
  }

  // date select method
  Future<void> selectDate(context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (selectedDate == null) {
      return;
    } else {
      showDate = selectedDate;
    }
  }
}
