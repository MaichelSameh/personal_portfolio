import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../controllers/localization_controller.dart';
import '../config/palette.dart';
import '../models/models.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  List<CategoryInfo> categories = [];
  String? hoveredProject;
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<ProjectInfo> projects = [];
  String? selectedCategory;

  @override
  void initState() {
    initCategories();
    initProjects();
    super.initState();
  }

  Future<void> initCategories() async {
    categories.clear();
    QuerySnapshot<Map<String, dynamic>> categorySnapshot = await instance
        .collection("categories")
        .orderBy("created_at", descending: true)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> categoriesData =
        categorySnapshot.docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> category
        in categoriesData) {
      categories.add(CategoryInfo.fromFirebase(category.data(), category.id));
    }
  }

  Future<void> initProjects([bool getNextPage = false]) async {
    projects.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> projectsSnapshot = await instance
          .collection("projects")
          .where("category_id", isEqualTo: selectedCategory)
          .orderBy("created_at")
          .startAt([
            categories.isNotEmpty && getNextPage
                ? {
                    "created_at":
                        DateFormat("yyyy-MM-dd").format(projects.last.createdAt)
                  }
                : null,
          ])
          .limit(1)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> projectsData =
          projectsSnapshot.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> project
          in projectsData) {
        projects.add(ProjectInfo.fromFirebase(project.data(), project.id));
      }
    } on Exception catch (error) {
      // ignore: avoid_print
      print("error downloading the selected project, error: $error");
    }
    setState(() {});
  }

  Row buildCategoriesRow(Size _size) {
    return Row(
      children: [
        MouseRegion(
          child: GestureDetector(
            onTap: () async {
              selectedCategory = null;
              await initProjects();
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(_size.width(15)),
              child: Text(
                Get.find<AppLocalizationController>().getTranslatedValue("all"),
                style: _size.textTheme(TextType.p).copyWith(
                      color: selectedCategory == null
                          ? MyPalette.secondary_color
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
                  onTap: () async {
                    selectedCategory = category.id;
                    await initProjects();
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(_size.width(15)),
                    child: Text(
                      category.title,
                      style: _size.textTheme(TextType.p).copyWith(
                            color: selectedCategory != null &&
                                    selectedCategory == category.id
                                ? MyPalette.secondary_color
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

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _size.screensType == ScreensType.mobile ? 0 : 96,
        ),
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        _size.screensType == ScreensType.mobile ? 30 : 0,
                  ),
                  child: SelectableText(
                    Get.find<AppLocalizationController>()
                        .getTranslatedValue("portfolio"),
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
              padding: EdgeInsets.symmetric(
                  horizontal: _size
                      .width(_size.screensType == ScreensType.mobile ? 96 : 0)),
              child: Column(
                children: [
                  buildCategoriesRow(_size),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: projects.length > 3 ? 1400 : 700),
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 505,
                        mainAxisExtent:
                            _size.screensType == ScreensType.mobile ? 400 : 510,
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
                                      _size.width(
                                          projects[index].id == hoveredProject
                                              ? 0
                                              : 20),
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
                                          if (projects[index].id ==
                                              hoveredProject)
                                            Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color: MyPalette.secondary_color
                                                  .withOpacity(0.82),
                                              alignment: Alignment.bottomCenter,
                                              padding: EdgeInsets.all(
                                                  _size.width(80) +
                                                      (projects[index].id ==
                                                              hoveredProject
                                                          ? 0
                                                          : 20)),
                                              child: Text(
                                                projects[index].name,
                                                textAlign: TextAlign.center,
                                                style: _size
                                                    .textTheme(TextType.h2),
                                              ),
                                            ),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _size.width(40)),
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
          ],
        ),
      ),
    );
  }
}
