import 'package:flutter/material.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  // ignore: constant_identifier_names
  static const String route_name = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          WelcomeScreen(),
          AboutScreen(),
          PortfolioScreen(),
          CapabilityScreen(),
          RepliesScreen(),
          ContactScreen(),
          FooterScreen(),
        ],
      ),
    );
  }
}
