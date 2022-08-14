import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/on_boarding/starting_two.dart';

class StartingScreenOne extends StatelessWidget {
  const StartingScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
            child: SvgPicture.asset('assets/images/startingSvg1.svg')),
        const SizedBox(height: 6),
        Text(
          'Welcome to',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'MyWallet',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.045,
              fontWeight: FontWeight.bold,
              color: kIndigoColor),
        ),
        const SizedBox(height: 20),
        Text(
          "Let's build a financial habit",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            CoreFunctions.pushToNext(context, StartingScreenTwo());
          },
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.008),
            child: Text(
              'Go Ahead',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}
