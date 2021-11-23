import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.secondary_color,
      padding:
          EdgeInsets.only(top: _size.height(141), bottom: _size.height(140)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [],
      ),
    );
  }

  Widget buildAboutInfo(Size _size) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              Get.find<AppLocalizationController>()
                  .getTranslatedValue("about_me"),
              style: _size.textTheme(TextType.h2),
            ),
          ],
        ),
        Text(
          Get.find<AppLocalizationController>()
              .getTranslatedValue("about_text"),
          style: _size.textTheme(TextType.p),
        ),
      ],
    );
  }
}
