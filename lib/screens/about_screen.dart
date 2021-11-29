import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';
import '../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  Widget buildAboutInfo(Size _size) {
    return SizedBox(
      width: _size.screensType == ScreensType.mobile ? null : _size.width(846),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: SelectableText(
                  Get.find<AppLocalizationController>()
                      .getTranslatedValue("about_me"),
                  style: _size.textTheme(TextType.h2),
                ),
              ),
              _size.screensType == ScreensType.mobile
                  ? const Spacer()
                  : SizedBox(width: _size.width(45)),
              Container(
                height: _size.height(12),
                width: _size.screensType == ScreensType.mobile
                    ? 144
                    : _size.width(345),
                decoration: BoxDecoration(
                  color: MyPalette.secondary_color,
                  borderRadius: BorderRadius.circular(
                    _size.height(
                        _size.screensType == ScreensType.mobile ? 0 : 12),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(_size.width(66)),
            child: Column(
              children: [
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      padding: EdgeInsets.symmetric(
          vertical:
              _size.height(_size.screensType == ScreensType.mobile ? 136 : 0)),
      child: _size.screensType == ScreensType.mobile
          ? Column(
              children: [
                buildAboutInfo(_size),
                SizedBox(height: _size.height(48)),
                Container(
                  height: _size.screensType == ScreensType.mobile ? 320 : 955,
                  width: double.infinity,
                  color: MyPalette.secondary_color.withOpacity(0.14),
                  margin: EdgeInsets.symmetric(
                    horizontal: _size.width(87),
                  ),
                  padding: EdgeInsets.all(_size.width(66)),
                  child: Image.asset(
                    "assets/images/about.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildAboutInfo(_size),
                SizedBox(width: _size.width(48)),
                Container(
                  height: _size.height(955),
                  width: _size.width(850),
                  color: MyPalette.secondary_color.withOpacity(0.14),
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
}
