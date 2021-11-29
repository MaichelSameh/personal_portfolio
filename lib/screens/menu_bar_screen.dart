import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../config/palette.dart';
import '../controllers/localization_controller.dart';
import '../models/size.dart';

class MenuBarScreen extends StatelessWidget {
  // ignore: constant_identifier_names
  static const String route_name = "menu_bar_screen";
  const MenuBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemScrollController controller =
        ModalRoute.of(context)!.settings.arguments as ItemScrollController;
    Size _size = Size(context);
    return Scaffold(
      body: Container(
        height: _size.screenHeight(),
        width: _size.screenWidth(),
        color: MyPalette.secondary_color,
        child: Column(
          children: [
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("assets/icons/cross_sign.svg"),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                controller.jumpTo(index: 1);
              },
              child: Text(
                Get.find<AppLocalizationController>()
                    .getTranslatedValue("about"),
                style: _size.textTheme(TextType.btn),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                controller.jumpTo(index: 2);
              },
              child: Text(
                Get.find<AppLocalizationController>()
                    .getTranslatedValue("portfolio"),
                style: _size.textTheme(TextType.btn),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                controller.jumpTo(index: 3);
              },
              child: Text(
                Get.find<AppLocalizationController>()
                    .getTranslatedValue("skills"),
                style: _size.textTheme(TextType.btn),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                controller.jumpTo(index: 5);
              },
              child: Text(
                Get.find<AppLocalizationController>()
                    .getTranslatedValue("contact"),
                style: _size.textTheme(TextType.btn),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
