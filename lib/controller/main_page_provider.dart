import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/view/screens/charts/chart_screen.dart';
import 'package:my_wallet/view/screens/home/home_screen.dart';
import 'package:my_wallet/view/screens/settings/settings_screen.dart';
import 'package:my_wallet/view/screens/view_all/view_all_screen.dart';

class MainPageProvider extends ChangeNotifier {
  // variables
  final autoSizeGroup = AutoSizeGroup();
  int _bottomNavIndex = 0;

  // getters
  get bottomNavIndex => _bottomNavIndex;

  // setters
  set bottomNavIndex(index) {
    _bottomNavIndex = index;
    notifyListeners();
  }

  // main page icon list
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.category_outlined,
    Icons.pie_chart_rounded,
    Icons.settings_outlined,
  ];

  // main page bottom nav name list
  final bottomNavNameList = <String>[
    'Home',
    'View All',
    'Charts',
    'Settings',
  ];

  // main page screen list
  final screenList = <Widget>[
    const HomeScreen(),
    const ViewAllScreen(),
    const ChartScreen(),
    const SettingsScreen(),
  ];
}
