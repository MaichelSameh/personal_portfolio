import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/palette.dart';
import '../models/size.dart';
import '../controllers/localization_controller.dart';
import '../widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      padding: EdgeInsets.symmetric(horizontal: _size.width(87)),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(width: double.infinity),
              buildHeader(_size),
              SizedBox(height: _size.height(42)),
              buildInfoRow(_size),
            ],
          ),
          Positioned(
            top: 0,
            left: _size.screenWidth() / 2 - _size.width(400),
            child: DottelsContainer(
              width: _size.width(590),
              height: _size.height(243),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(Size _size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("portfolio"),
          style: TextStyle(
            fontSize: _size.screenType == ScreensType.pc
                ? 100
                : _size.screenType == ScreensType.tablet
                    ? 70
                    : 45,
            color: Colors.white,
            fontFamily: "Freestyle Script",
          ),
        ),
        buildNavigatorRow(_size),
      ],
    );
  }

  Widget buildNavigatorRow(Size _size) {
    return SizedBox(
      height: _size.height(147),
      child: Row(
        children: [
          SizedBox(
            width: _size.width(460),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: _size.width(20)),
                  child: Column(
                    children: [
                      Container(
                        width: _size.width(123),
                        height: _size.height(117),
                        color: MyPalette.third_color,
                        margin: EdgeInsets.only(bottom: _size.height(3)),
                      ),
                      SizedBox(
                        width: _size.width(123),
                        child: const Divider(color: MyPalette.third_color),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: _size.height(35)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        Get.find<AppLocalizationController>()
                            .getTranslatedValue("about"),
                        style: _size.textTheme(TextType.p),
                      ),
                      Text(
                        Get.find<AppLocalizationController>()
                            .getTranslatedValue("portfolio"),
                        style: _size.textTheme(TextType.p),
                      ),
                      Text(
                        Get.find<AppLocalizationController>()
                            .getTranslatedValue("contact"),
                        style: _size.textTheme(TextType.p),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomBorderedButton(
            textKey: "get_start",
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(Size _size) {
    return Stack(
      alignment: Get.find<AppLocalizationController>().isRTLanguage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      children: [
        const BackgroundCircle(),
        Row(
          children: [
            SizedBox(
              width: _size.width(770),
              child: buildInfoColumn(_size),
            ),
            Image.asset(
              "assets/images/me.png",
              fit: BoxFit.cover,
              width: _size.width(908),
              height: _size.height(1033),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInfoColumn(Size _size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("hello"),
          style: _size.textTheme(TextType.h2),
        ),
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("Maichel"),
          style: _size.textTheme(TextType.h1),
        ),
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("Sameh"),
          style: _size.textTheme(TextType.h1),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: Get.find<AppLocalizationController>()
                        .getTranslatedValue("a_young") +
                    " ",
                style: _size.textTheme(TextType.p),
              ),
              TextSpan(
                text: Get.find<AppLocalizationController>()
                        .getTranslatedValue("app") +
                    " ",
                style: _size.textTheme(TextType.p).copyWith(
                      color: MyPalette.third_color,
                    ),
              ),
              TextSpan(
                text: Get.find<AppLocalizationController>()
                        .getTranslatedValue("developer") +
                    "",
                style: _size.textTheme(TextType.p),
              ),
            ],
          ),
        ),
        SizedBox(height: _size.height(40)),
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("find_me"),
          style: _size.textTheme(TextType.p).copyWith(
                fontWeight: FontWeight.normal,
              ),
        ),
        Row(),
        SizedBox(height: _size.height(70)),
        Row(
          children: [
            CustomElevatedButton(
              textKey: "hire_me",
              horizontalPadding: _size.width(79),
              verticalPadding: _size.height(32),
            ),
            SizedBox(width: _size.width(30)),
            CustomBorderedButton(
              textKey: "portfolio",
              horizontalPadding: _size.width(79),
              verticalPadding: _size.height(32),
            ),
          ],
        ),
      ],
    );
  }
}
