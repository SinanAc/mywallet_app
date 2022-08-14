import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/providers/edit_provider.dart';
import 'package:my_wallet/models/transaction_model.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/edit/edit_screen.dart';
import 'package:my_wallet/view/widgets/delete_verification.dart';
import 'package:provider/provider.dart';

class DisplayCard extends StatelessWidget {
  const DisplayCard(
      {Key? key,
      required this.isCustom,
      required this.isSearch,
      required this.data})
      : super(key: key);
  final TransactionModel data;
  final bool isCustom;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.03,
        ),
        leading: CircleAvatar(
          radius: MediaQuery.of(context).size.height * 0.05,
          backgroundColor:
              data.incomeOrExpense == 'Income' ? kGreenColor : kRedColor,
          child: data.incomeOrExpense == 'Income'
              ? const Icon(
                  Icons.trending_up_outlined,
                  color: kWhiteColor,
                )
              : const Icon(
                  Icons.trending_down_outlined,
                  color: kWhiteColor,
                ),
        ),
        title: Text(
          data.categoryTypeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.MMMMd().format(data.selectedDate),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹ ${data.amount}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              child: Text(
                data.note,
                style: const TextStyle(),
              ),
            ),
          ],
        ),
        onTap: () {
          final editProvider =
              Provider.of<EditProvider>(context, listen: false);
          isCustom
              ? null
              : editProvider.amountController.text = data.amount.toString();
          editProvider.noteController.text = data.note;
          editProvider.categoryType = data.categoryTypeName;
          editProvider.showDate = data.selectedDate;
          editProvider.incomeOrExpense = data.incomeOrExpense;
          CoreFunctions.pushToNext(context, EditScreen(data: data));
        },
        onLongPress: () {
          DeleteVerification.deleteVerification(
            context,
            data.id!,
            isSearch: isSearch,
          );
        },
      ),
    );
  }
}
