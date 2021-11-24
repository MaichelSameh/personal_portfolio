import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/models.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  List<CategoryInfo> categories = [];
  List<ProjectInfo> projects = [];

  String? selectedCategory;
  String? hoveredProject;

  Future<void> init() async {
    categories.clear();
    QuerySnapshot<Map<String, dynamic>> categorySnapshot =
        await instance.collection("categories").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> categoriesData =
        categorySnapshot.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> category
        in categoriesData) {
      categories.add(CategoryInfo.fromFirebase(category.data(), category.id));
    }
    projects.clear();
    QuerySnapshot<Map<String, dynamic>> projectsSnapshot = await instance
        .collection("projects")
        .where("category_id",
            isEqualTo: selectedCategory == null
                ? null
                : "/categories/$selectedCategory")
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> projectsData =
        projectsSnapshot.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> project in projectsData) {
      projects.add(ProjectInfo.fromFirebase(project.data(), project.id));
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
      color: MyPalette.secondary_color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _size.width(96)),
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            Row(
              children: [
                SelectableText(
                  Get.find<AppLocalizationController>()
                      .getTranslatedValue("portfolio"),
                  style: _size.textTheme(TextType.h2),
                ),
              ],
            ),
            buildCategoriesRow(_size),
            Container(
              constraints:
                  BoxConstraints(maxHeight: projects.length > 3 ? 1400 : 700),
              padding: EdgeInsets.symmetric(vertical: _size.height(113)),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 505,
                  mainAxisExtent: 510,
                  crossAxisSpacing: _size.width(57),
                  mainAxisSpacing: _size.height(53),
                ),
                itemCount: projects.length >= 6 ? 6 : projects.length,
                itemBuilder: (ctx, index) {
                  return ImageSlideshow(
                      isLoop: true,
                      indicatorBackgroundColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      children: projects[index].imageURL.map<Widget>(
                        (image) {
                          return MouseRegion(
                            onHover: (_) {
                              hoveredProject = projects[index].id;
                              setState(() {});
                            },
                            onExit: (_) {
                              hoveredProject = null;
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              padding: EdgeInsets.all(
                                _size.width(projects[index].id == hoveredProject
                                    ? 0
                                    : 50),
                              ),
                              child: ClipRRect(
                                child: Stack(
                                  children: [
                                    Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                    if (projects[index].id == hoveredProject)
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: MyPalette.third_color
                                            .withOpacity(0.82),
                                        alignment: Alignment.bottomCenter,
                                        padding:
                                            EdgeInsets.all(_size.width(80)),
                                        child: Text(
                                          projects[index].name,
                                          textAlign: TextAlign.center,
                                          style: _size.textTheme(TextType.h2),
                                        ),
                                      ),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(_size.width(40)),
                              ),
                            ),
                          );
                        },
                      ).toList());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildCategoriesRow(Size _size) {
    return Row(
      children: [
        MouseRegion(
          child: GestureDetector(
            onTap: () {
              setState(() {
                setState(() {
                  selectedCategory = null;
                });
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: _size.width(30)),
              child: SelectableText(
                Get.find<AppLocalizationController>().getTranslatedValue("all"),
                style: _size.textTheme(TextType.p).copyWith(
                      color: selectedCategory == null
                          ? MyPalette.third_color
                          : _size.textTheme(TextType.p).color,
                    ),
              ),
            ),
          ),
        ),
        ...categories
            .map<Widget>(
              (category) => MouseRegion(
                onHover: (_) {},
                child: GestureDetector(
                  onTap: () {
                    selectedCategory = category.id;
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: _size.width(30)),
                    child: SelectableText(
                      category.title,
                      style: _size.textTheme(TextType.p).copyWith(
                            color: selectedCategory != null &&
                                    selectedCategory == category.id
                                ? MyPalette.third_color
                                : _size.textTheme(TextType.p).color,
                          ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
