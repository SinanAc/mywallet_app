// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:my_wallet/controller/providers/add_provider.dart';
import 'package:my_wallet/controller/providers/chart_provider.dart';
import 'package:my_wallet/controller/providers/edit_provider.dart';
import 'package:my_wallet/controller/providers/home_provider.dart';
import 'package:my_wallet/controller/providers/main_page_provider.dart';
import 'package:my_wallet/controller/providers/search_provider.dart';
import 'package:my_wallet/controller/providers/transaction_list_provider.dart';
import 'package:my_wallet/models/transaction_model.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/screens/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => MainPageProvider()),
        ChangeNotifierProvider(create: (context) => TransactionListProvider()),
        ChangeNotifierProvider(create: (context) => AddProvider()),
        ChangeNotifierProvider(create: (context) => EditProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => ChartProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          primarySwatch: kIndigoColor,
        ),
      ),
    );
  }
}
