import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/controller/providers/add_provider.dart';
import 'package:my_wallet/controller/providers/main_page_provider.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/add/add_screen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainPageProvider = Provider.of<MainPageProvider>(context);
    final addProvider = Provider.of<AddProvider>(context, listen: false);
    return Scaffold(
      extendBody: true,
      body: mainPageProvider.screenList[mainPageProvider.bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: kWhiteColor,
        ),
        onPressed: () {
          addProvider.incomeOrExpense = 'Income';
          addProvider.categoryType = null;
          addProvider.showDate = DateTime.now();
          addProvider.amountController.text = '';
          addProvider.noteController.text = '';
          CoreFunctions.pushToNext(context, const AddScreen());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? kWhiteColor : kGreyColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                mainPageProvider.iconList[index],
                size: 24,
                color: color,
              ),
              AutoSizeText(
                mainPageProvider.bottomNavNameList[index],
                maxLines: 1,
                style: TextStyle(color: color, fontSize: 5),
                group: mainPageProvider.autoSizeGroup,
              )
            ],
          );
        },
        backgroundColor: kIndigoColor,
        activeIndex: mainPageProvider.bottomNavIndex,
        splashSpeedInMilliseconds: 300,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          mainPageProvider.bottomNavIndex = index;
        },
      ),
    );
  }
}
