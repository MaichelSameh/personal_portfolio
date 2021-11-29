import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/palette.dart';
import '../controllers/localization_controller.dart';
import '../models/contract_info.dart';
import '../models/size.dart';
import '../services/firebase_services.dart';
import '../widgets/widgets.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController budgetController = TextEditingController();
  String budgetErrorMessage = "";
  String errorMessage = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool showBudgetErrorMessage = false;
  bool showErrorMessage = false;
  Widget buildContactForm(Size _size) {
    return Padding(
      padding: EdgeInsets.all(_size.screensType == ScreensType.mobile ? 20 : 0),
      child: Column(
        children: [
          _size.screensType == ScreensType.mobile
              ? Column(
                  children: [
                    CustomTextField(
                      hintKey: "name",
                      width: 594,
                      controller: nameController,
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      hintKey: "email",
                      width: 594,
                      controller: emailController,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      hintKey: "name",
                      width: 594,
                      controller: nameController,
                    ),
                    const SizedBox(width: 50),
                    CustomTextField(
                      hintKey: "email",
                      width: 594,
                      controller: emailController,
                    ),
                  ],
                ),
          SizedBox(height: _size.screensType == ScreensType.mobile ? 25 : 50),
          _size.screensType == ScreensType.mobile
              ? Column(
                  children: [
                    CustomTextField(
                      hintKey: "phone",
                      width: 594,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        CustomTextField(
                          hintKey: "budget",
                          width: 594,
                          controller: budgetController,
                        ),
                        if (showBudgetErrorMessage)
                          SelectableText(
                            budgetErrorMessage,
                            style: _size
                                .textTheme(TextType.p)
                                .copyWith(color: Colors.red),
                          ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      hintKey: "phone",
                      width: 594,
                      controller: phoneController,
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: [
                        CustomTextField(
                          hintKey: "budget",
                          width: 594,
                          controller: budgetController,
                        ),
                        if (showBudgetErrorMessage)
                          SelectableText(
                            budgetErrorMessage,
                            style: _size
                                .textTheme(TextType.p)
                                .copyWith(color: Colors.red),
                          ),
                      ],
                    ),
                  ],
                ),
          SizedBox(height: _size.screensType == ScreensType.mobile ? 25 : 50),
          CustomTextField(
            hintKey: "message",
            width: 1238,
            height: 205,
            controller: messageController,
            keyboardType: TextInputType.multiline,
            alignment: Alignment.topLeft,
          ),
          if (showErrorMessage)
            SelectableText(
              errorMessage,
              style: _size.textTheme(TextType.p).copyWith(color: Colors.red),
            ),
          const SizedBox(height: 90),
          CustomElevatedButton(
            textKey: "hire_me",
            onTap: () async {
              FocusScope.of(context).unfocus();
              setState(() {
                showBudgetErrorMessage = false;
                showErrorMessage = false;
              });
              bool valid = double.tryParse(budgetController.text) != null;

              if (!valid) {
                setState(() {
                  budgetErrorMessage = "You need to enter a valid number!";
                  showBudgetErrorMessage = true;
                });
                return;
              }
              if (emailController.text.isEmpty ||
                  messageController.text.isEmpty ||
                  nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  budgetController.text.isEmpty) {
                setState(() {
                  errorMessage = "Please fill all fields";
                  showErrorMessage = true;
                });
                return;
              }
              FirebaseServices services = FirebaseServices();
              ContractInfo contract = ContractInfo(
                id: "",
                email: emailController.text,
                message: messageController.text,
                name: nameController.text,
                phone: phoneController.text,
                budget: double.parse(budgetController.text),
                createdAt: DateTime.now(),
              );
              bool done = await services.addContract(contract);
              if (done) {
                emailController.clear();
                messageController.clear();
                nameController.clear();
                phoneController.clear();
                budgetController.clear();
              }
            },
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
}
