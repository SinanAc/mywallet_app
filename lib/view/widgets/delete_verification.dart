import 'package:flutter/material.dart';
import 'package:my_wallet/controller/data_base/db_functions.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/search/search_screen.dart';

class DeleteVerification {
  static deleteVerification(context, String id, {bool isSearch = false}) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Delete !!',
              style: TextStyle(color: kRedColor),
            ),
            content: const Text(
                'This transaction will be deleted permanently. Are you sure?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: kIndigoColor, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  TransactionDB.instance.deleteTransaction(id, context);
                  Navigator.of(ctx).pop();
                  isSearch
                      ? CoreFunctions.pushReplacePage(
                          context, const SearchScreen())
                      : null;
                },
                child: const Text('Delete',
                    style: TextStyle(
                        color: kIndigoColor, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }
}
