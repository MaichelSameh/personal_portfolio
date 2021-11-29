import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  // ignore: constant_identifier_names
  static const String route_name = "home_screen";
  HomeScreen({Key? key}) : super(key: key);

  final ItemScrollController controller = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      WelcomeScreen(controller: controller),
      const AboutScreen(),
      const PortfolioScreen(),
      const CapabilityScreen(),
      const RepliesScreen(),
      const ContactScreen(),
      FooterScreen(controller: controller),
    ];
    return Scaffold(
      body: SizedBox(
        // height: 4000,
        child: ScrollablePositionedList.builder(
          itemScrollController: controller,
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, index) {
            return screens[index];
          },
          itemCount: screens.length,
        ),
      ),
    );
  }
}
