import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_wallet/controller/main_page_provider.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/main_page/main_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingScreenTwo extends StatelessWidget {
  StartingScreenTwo({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.21,
          child: SvgPicture.asset('assets/images/startingSvg2.svg'),
        ),
        const SizedBox(height: 7),
        Text(
          'What should we call you ?',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.026,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.018),
          child: TextField(
            controller: nameController,
            maxLength: 15,
            decoration: const InputDecoration(
              hintText: 'Please enter your name',
              counterText: '',
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              nameVerification(context);
            },
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.008),
              child: Text(
                'Get Started',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.033,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ]),
    );
  }

  nameVerification(BuildContext context) {
    final name = nameController.text.trim().toUpperCase();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your name',
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
      addName(name);
      Provider.of<MainPageProvider>(context, listen: false).bottomNavIndex = 0;
      CoreFunctions.pushAndRemoveUntilNext(context, const MainPage());
    }
  }

  void addName(String name) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('name', name);
  }
}
