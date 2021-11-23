import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';
import '../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.secondary_color,
      padding: EdgeInsets.symmetric(
        vertical: _size.height(141),
        horizontal: _size.width(87),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAboutInfo(_size),
          SizedBox(width: _size.width(48)),
          Container(
            height: _size.height(955),
            width: _size.width(850),
            color: MyPalette.primary_color,
            padding: EdgeInsets.all(_size.width(66)),
            child: Image.asset(
              "assets/images/about.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget buildAboutInfo(Size _size) {
    return SizedBox(
      width: _size.width(846),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("about_me"),
            style: _size.textTheme(TextType.h2),
          ),
          SizedBox(height: _size.height(75)),
          SelectableText(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("about_text"),
            style: _size.textTheme(TextType.p),
          ),
          SizedBox(height: _size.height(50)),
          const CustomBorderedButton(textKey: "download_cv"),
        ],
      ),
    );
  }
}
