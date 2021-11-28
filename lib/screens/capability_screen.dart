import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';
import '../models/capability_info.dart';

class CapabilityScreen extends StatefulWidget {
  const CapabilityScreen({Key? key}) : super(key: key);

  @override
  State<CapabilityScreen> createState() => _CapabilityScreenState();
}

class _CapabilityScreenState extends State<CapabilityScreen> {
  List<CapabilityInfo> capabilities = [];

  Future<void> init() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> capabilitiesSnapshot =
        await instance.collection("/capabilities").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> capabilitiesData =
        capabilitiesSnapshot.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> capability
        in capabilitiesData) {
      capabilities
          .add(CapabilityInfo.fromFirebase(capability.data(), capability.id));
    }
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      padding: EdgeInsets.symmetric(
        horizontal: _size.width(185),
        vertical: _size.height(96),
      ),
      child: Column(
        children: [
          const SizedBox(width: double.infinity),
          Text(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("capability"),
            style: _size.textTheme(TextType.h2),
          ),
          SizedBox(
            width: _size.width(345),
            child: const Divider(
              color: MyPalette.secondary_color,
              thickness: 2,
            ),
          ),
          Text(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("capability_text"),
            style: _size.textTheme(TextType.p),
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: (capabilities.length ~/ 3) * 345 +
                            capabilities.length % 3 !=
                        0
                    ? 345
                    : 0),
            margin: EdgeInsets.symmetric(vertical: _size.height(113)),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 326,
                mainAxisExtent: 258,
                crossAxisSpacing: _size.width(229),
                mainAxisSpacing: _size.height(174),
              ),
              itemCount: capabilities.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    Image.network(
                      capabilities[index].imageURL,
                      fit: BoxFit.cover,
                      height: 106,
                      width: double.infinity,
                    ),
                    SizedBox(height: _size.height(20)),
                    Text(
                      capabilities[index].title,
                      style: _size
                          .textTheme(TextType.h3)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      capabilities[index].description,
                      style: _size.textTheme(TextType.p),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
