import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_wallet/controller/data_base/db_functions.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/main_page/main_page.dart';
import 'package:my_wallet/view/screens/on_boarding/starting_one.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      TransactionDB.instance.refreshUi(context);
      Timer(const Duration(seconds: 3), () => _checkings(context));
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: Image.asset('assets/images/appLogoo.png')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text('My Wallet',
            textAlign: TextAlign.center,
            style: TextStyle(color: kGreyColor.shade600)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _checkings(context) async {
    final pref = await SharedPreferences.getInstance();
    final addedName = pref.getString('name');
    if (addedName == null) {
      CoreFunctions.pushReplacePage(context, const StartingScreenOne());
    } else {
      CoreFunctions.pushReplacePage(context, const MainPage());
    }
  }
}
