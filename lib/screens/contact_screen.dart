import 'package:flutter/material.dart';

import '../config/palette.dart';
import '../models/size.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      height: _size.height(200) + _size.screenHeight(),
      color: MyPalette.primary_color,
      child: Column(
        children: const [
          SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}
