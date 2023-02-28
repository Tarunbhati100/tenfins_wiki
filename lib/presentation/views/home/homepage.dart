// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:tenfins_wiki/buisness_logic/controller/articleListcontroller.dart';
import 'package:tenfins_wiki/data/article_db.dart';
import 'package:tenfins_wiki/presentation/views/article/add_article.dart';
import 'package:tenfins_wiki/presentation/views/article/article_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleListController articleListController =
      Get.put(ArticleListController());

  @override
  void initState() {
    articleListController.getArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appText(title: "Article List", color: Colors.white),
        backgroundColor: AppColor.primary,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: InkWell(
                onTap: () {
                  Get.to(AddArticlePage());
                },
                child: const ImageIcon(
                  AssetImage("assets/images/createnew.png"),
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          //   child: Container(
          //     height: 7.h,
          //     child: CupertinoSearchTextField(
          //       controller: articleListController.SearchController,
          //       onChanged: (String value) {

          //       },
          //       onSubmitted: (String value) {
          //         print('Submitted text: $value');
          //       },
          //     ),
          //   ),
          // ),
          Expanded(child: GetBuilder<ArticleListController>(
            builder: (controller) {
              return articleListController.getArticleList.length == 0
                  ? const Center(
                      child: Text(
                        'No Article',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: articleListController.getArticleList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              Get.to(Article_Screen(
                                  Article: articleListController
                                      .getArticleList[index]));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: ListTile(
                                  title: Html(
                                      data: articleListController
                                          .getArticleList[index].title),
                                  subtitle: Html(
                                      data: articleListController
                                          .getArticleList[index].description),
                                  trailing: InkWell(
                                      onTap: () {
                                        Get.to(AddArticlePage());
                                      },
                                      child: ImageIcon(
                                        const AssetImage(
                                          "assets/images/edit.png",
                                        ),
                                        color: AppColor.black,
                                      )),
                                ),
                              ),
                            ));
                      });
            },
          )

              //  }),
              ),
        ],
      ),
    );
  }
}
