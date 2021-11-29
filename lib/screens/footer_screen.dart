import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({Key? key, required this.controller}) : super(key: key);

  final ItemScrollController controller;

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: _size.screensType == ScreensType.mobile ? 57 : 166,
          ),
          Container(
            width: 2,
            height: 83,
            decoration: BoxDecoration(
              color: MyPalette.secondary_color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 38),
          SelectableText(
            Get.find<AppLocalizationController>().getTranslatedValue("Maichel"),
            style: _size.textTheme(TextType.h3),
          ),
          const SizedBox(height: 74),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  controller.jumpTo(index: 1);
                },
                child: Text(
                  Get.find<AppLocalizationController>()
                      .getTranslatedValue("about"),
                  style: _size.textTheme(TextType.p),
                ),
              ),
              Text(
                " | ",
                style: _size.textTheme(TextType.p),
              ),
              GestureDetector(
                onTap: () {
                  controller.jumpTo(index: 2);
                },
                child: Text(
                  Get.find<AppLocalizationController>()
                      .getTranslatedValue("portfolio"),
                  style: _size.textTheme(TextType.p),
                ),
              ),
              Text(
                " | ",
                style: _size.textTheme(TextType.p),
              ),
              GestureDetector(
                onTap: () {
                  controller.jumpTo(index: 5);
                },
                child: Text(
                  Get.find<AppLocalizationController>()
                      .getTranslatedValue("contact"),
                  style: _size.textTheme(TextType.p),
                ),
              ),
            ],
          ),
          SelectableText(
            Get.find<AppLocalizationController>().getTranslatedValue("egypt") +
                " / " +
                "+201205082038" +
                " / " +
                "maichelsameh622@gmail.com",
            style: _size.textTheme(TextType.p),
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
            height: _size.height(160),
          ),
          SelectableText(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("copyright_text"),
            style: _size.textTheme(TextType.p),
          ),
          SizedBox(height: _size.height(80)),
        ],
      ),
    );
  }
}
