import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/palette.dart';
import 'controllers/controller.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AppLocalizationController>(AppLocalizationController.empty());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLocalizationController>(
      builder: (localization) {
        return MaterialApp(
          locale: localization.currentLocale,
          localizationsDelegates: [
            AppLocalizationController.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: localization.locales,
          initialRoute: HomeScreen.route_name,
          routes: {
            HomeScreen.route_name: (_) =>
                HomeScreen(key: const Key(HomeScreen.route_name)),
            MenuBarScreen.route_name: (_) =>
                const MenuBarScreen(key: Key(MenuBarScreen.route_name)),
          },
          theme: ThemeData(
            scaffoldBackgroundColor: MyPalette.primary_color,
            fontFamily: "Poppins",
          ),
        );
      },
    );
  }
}
