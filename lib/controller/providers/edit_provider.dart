import 'package:flutter/material.dart';
import 'package:my_wallet/controller/data_base/db_functions.dart';
import 'package:my_wallet/models/transaction_model.dart';
import 'package:my_wallet/view/core/colors.dart';

class EditProvider extends ChangeNotifier {
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

  // update method
  updateSubmission(BuildContext context, String id, TransactionModel data) {
    final incomeOrExpenseValue = incomeOrExpense.toString();
    final amount = amountController.text.isEmpty
        ? 0.0
        : double.parse(amountController.text);
    final categoryTypeName = categoryType.toString();
    final selectedDateNew = showDate;
    final note = noteController.text;

    if (amount == 0 || amount.isNegative) {
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
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      final transaction = TransactionModel(
        id: data.id,
        incomeOrExpense: incomeOrExpenseValue,
        amount: amount,
        categoryTypeName: categoryTypeName,
        selectedDate: selectedDateNew,
        note: note,
      );
      TransactionDB.instance.updateTransaction(data: transaction, id: id);
      Navigator.of(context).pop();
      TransactionDB.instance.refreshUi(context);
      if (amount != data.amount ||
          categoryTypeName != data.categoryTypeName ||
          selectedDateNew != data.selectedDate ||
          note != data.note) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Successfully Updated',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: kGreenColor.shade800,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // select date method
  Future<void> selectDate(context) async {
    final selectedDateNow = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (selectedDateNow == null) {
      return;
    } else {
      showDate = selectedDateNow;
    }
  }
}
