import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/size.dart';
import '../models/comment_info.dart';

class RepliesScreen extends StatefulWidget {
  const RepliesScreen({Key? key}) : super(key: key);

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  List<CommentInfo> comments = [];
  CarouselController controller = CarouselController();
  String currentComment = "";
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    QuerySnapshot<Map<String, dynamic>> commentSnapshot =
        await instance.collection("comments").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> commentsData =
        commentSnapshot.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> comment in commentsData) {
      comments.add(CommentInfo.fromFirebase(comment.data(), comment.id));
    }
    currentComment = comments[0].id;
    setState(() {});
  }

  Widget buildCommentSection(Size _size) {
    CarouselOptions carouselOptions = CarouselOptions(
      autoPlay: true,
      autoPlayAnimationDuration: const Duration(seconds: 3),
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      aspectRatio: 1,
      onPageChanged: (value, _) {
        currentComment = comments[value].id;
        setState(() {});
      },
    );
    // ignore: unrelated_type_equality_checks
    if (_size.screenType != ScreenType.Phone) {
      return Row(
        children: [
          Transform.rotate(
            angle: pi,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: MyPalette.secondary_color,
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.all(30),
              child: SvgPicture.asset("assets/icons/to_icon.svg"),
            ),
          ),
          SizedBox(
            width: _size.width(841),
            height: _size.height(647),
            child: CarouselSlider(
              items: comments
                  .map<Widget>((comment) => buildComment(_size, comment))
                  .toList(),
              options: carouselOptions,
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: MyPalette.secondary_color,
              borderRadius: BorderRadius.circular(34),
            ),
            padding: const EdgeInsets.all(30),
            child: SvgPicture.asset("assets/icons/to_icon.svg"),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: _size.width(841),
            height: _size.height(647),
            child: CarouselSlider(
              items: comments
                  .map<Widget>((comment) => buildComment(_size, comment))
                  .toList(),
              options: carouselOptions,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: comments
                .map<Widget>(
                  (comment) => Container(
                    width: _size.width(5),
                    height: _size.width(5),
                    margin: EdgeInsets.symmetric(horizontal: _size.width(40)),
                    decoration: BoxDecoration(
                      color: comment.id == currentComment
                          ? MyPalette.secondary_color
                          : const Color.fromRGBO(250, 250, 250, 0.63),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: _size.height(27)),
        ],
      );
    }
  }

  Widget buildComment(Size _size, CommentInfo comment) {
    return Column(
      children: [
        Row(
          children: [
            Text("\"",
                style: _size
                    .textTheme(TextType.h1)
                    .copyWith(color: MyPalette.secondary_color)),
          ],
        ),
        SelectableText(
          comment.comment.trimLeft().trimRight(),
          style: _size.textTheme(TextType.btn),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("\"",
                style: _size
                    .textTheme(TextType.h1)
                    .copyWith(color: MyPalette.secondary_color)),
          ],
        ),
        SelectableText(
          "-" + comment.name,
          style: _size
              .textTheme(TextType.btn)
              .copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SelectableText(
          comment.role,
          style: _size.textTheme(TextType.p),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      padding: EdgeInsets.symmetric(horizontal: _size.width(161)),
      color: MyPalette.primary_color,
      child: Column(
        children: [
          const SizedBox(width: double.infinity),
          SelectableText(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("what_clients_says"),
            style: _size.textTheme(TextType.h2),
          ),
          Container(
            width: _size.width(345),
            height: 2,
            decoration: BoxDecoration(
              color: MyPalette.secondary_color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: _size.height(40)),
          SelectableText(
            Get.find<AppLocalizationController>()
                .getTranslatedValue("what_clients_says_text"),
            style: _size.textTheme(TextType.btn),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _size.height(40)),
          SizedBox(
            child: buildCommentSection(_size),
            width: _size.width(1288),
          ),
          Container(
            width: 3,
            height: 187,
            decoration: BoxDecoration(
              color: MyPalette.secondary_color,
              borderRadius: BorderRadius.circular(3),
            ),
          )
        ],
      ),
    );
  }
}
