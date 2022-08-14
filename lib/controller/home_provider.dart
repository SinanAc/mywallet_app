import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  String userName = '';
  void getSharedPrefName() async {
    final SharedPreferences pref;
    pref = await SharedPreferences.getInstance();
    userName = pref.getString('name').toString();
    notifyListeners();
  }
}
