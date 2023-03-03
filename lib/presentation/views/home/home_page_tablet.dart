// ignore_for_file: avoid_print, sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/buisness_logic/controller/articleController.dart';
import 'package:tenfins_wiki/buisness_logic/controller/articleListcontroller.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:tenfins_wiki/data/article_db.dart';
import 'package:tenfins_wiki/presentation/views/addArticle/add_article.dart';
import 'package:tenfins_wiki/presentation/views/viewArticle/view_article_page.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({super.key});

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  // ArticleListController articleListController =
  //     Get.put(ArticleListController());

  ArticleController addArticleController = Get.put(ArticleController());

  @override
  void initState() {
    // articleListController.getArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: appText(title: "Article List", color: Colors.white),
          backgroundColor: AppColor.primary,
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: InkWell(
                  onTap: () {
                    Get.to(const AddArticlePage());
                  },
                  child: const ImageIcon(
                    AssetImage("assets/images/createnew.png"),
                  )),
            ),
          ],
        ),
        body: ValueListenableBuilder(
            valueListenable: ArticleDataStore.box.listenable(),
            builder: (context, Box box, widget) {
              print("box============$box");
              return box.length == 0
                  ? Center(
                      child: appText(title: "No Article", color: Colors.grey),
                    )
                  : SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: box.length,
                          itemBuilder: (BuildContext context, int index) {
                            var ArticleData = box.getAt(index);
                            print("ArticleData---------------$ArticleData");
                            print(ArticleData.title);
                            return InkWell(
                              onTap: () {
                                Get.to(ViewArticlePage(
                                    articleTitle: ArticleData.title,
                                    articleDescription:
                                        ArticleData.description));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(color: AppColor.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ArticleData.title,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: AppColor.black,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Html(
                                                  data: ArticleData.description,
                                                  shrinkWrap: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(AddArticlePage());
                                            // addArticleController
                                            //     .isUpdate.value = true;
                                            // addArticleController
                                            //     .titleController
                                            //     .text = ArticleData.title;
                                            // addArticleController.controller =
                                            //     ArticleData.description;
                                            // addArticleController.AddArticle;
                                          },
                                          child: const ImageIcon(
                                            AssetImage(
                                                "assets/images/edit.png"),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
            }));
  }
}
