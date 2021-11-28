import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';
import '../widgets/widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      child: Column(
        children: [
          SizedBox(width: double.infinity, height: _size.height(47)),
          SizedBox(
            width: _size.width(666),
            child: SelectableText(
              Get.find<AppLocalizationController>()
                  .getTranslatedValue('hire_me_title'),
              textAlign: TextAlign.center,
              style: _size.textTheme(TextType.h2),
            ),
          ),
          SizedBox(
            width: _size.width(1000),
            child: SelectableText(
              Get.find<AppLocalizationController>()
                  .getTranslatedValue('hire_me_text'),
              textAlign: TextAlign.center,
              style: _size.textTheme(TextType.btn),
            ),
          ),
          SizedBox(height: _size.height(89)),
          buildContactForm(_size),
        ],
      ),
    );
  }

  Widget buildContactForm(Size _size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hintKey: "name", width: 594),
            const SizedBox(width: 50),
            CustomTextField(hintKey: "email", width: 594),
          ],
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hintKey: "phone", width: 594),
            const SizedBox(width: 50),
            CustomTextField(hintKey: "budget", width: 594),
          ],
        ),
        const SizedBox(height: 50),
        CustomTextField(
          hintKey: "message",
          width: 1238,
          height: 205,
        ),
        const SizedBox(height: 90),
        const CustomElevatedButton(textKey: "hire_me"),
      ],
    );
  }
}
