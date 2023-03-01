
// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/buisness_logic/controller/addArticle_Controller.dart';
import 'package:tenfins_wiki/buisness_logic/controller/articleListcontroller.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:tenfins_wiki/data/article_db.dart';
import 'package:tenfins_wiki/presentation/views/addArticle/add_article.dart';
import 'package:tenfins_wiki/presentation/views/viewArticle/view_article_page.dart';


class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  ArticleListController articleListController =
      Get.put(ArticleListController());

  AddArticleController addArticleController = Get.put(AddArticleController());

  @override
  void initState() {
    articleListController.getArticle();
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
              return box.length == 0 ?  Center(
                      child: appText(title: "No Article",color: Colors.grey),
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
                              Get.to(ViewArticlePage(articleTitle: ArticleData.title, articleDescription: ArticleData.description));
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
                                          AssetImage("assets/images/edit.png"),
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
            })
        // Column(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        //       child: Container(
        //         height: 7.h,
        //         child: CupertinoSearchTextField(
        //           controller: articleListController.SearchController,
        //           onChanged: (String value) {},
        //           onSubmitted: (String value) {
        //             print('Submitted text: $value');
        //           },
        //         ),
        //       ),
        //     ),
        //     Expanded(child: GetBuilder<ArticleListController>(
        //       builder: (controller) {
        //         return articleListController.getArticleList.isEmpty
        //             ? const Center(
        //                 child: Text(
        //                   'No Article',
        //                   style: TextStyle(
        //                     color: Colors.black,
        //                     letterSpacing: 0.5,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               )
        //             : ListView.builder(
        //             itemCount:
        //                 articleListController.getArticleList.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               return InkWell(
        //                   onTap: () {
        //                     Get.to(ViewArticlePage(articleTitle:articleListController.getArticleList[index].title,articleDescription: articleListController.getArticleList[index].description,));
        //                   },
        //                   child: Padding(
        //                     padding:
        //                         EdgeInsets.symmetric(horizontal: 3.w),
        //                     child: Card(
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(2.h),
        //                       ),
        //                       child: ListTile(
        //                         title: appText(
        //                             title: articleListController
        //                                 .getArticleList[index].title,
        //                                 color: AppColor.black,
        //                                 fontSize: 20,
        //                                 fontWeight: FontWeight.w500,
        //                                 ),
        //                         subtitle: Html(
        //                              data:articleListController
        //                                 .getArticleList[index]
        //                                 .description,
        //                               shrinkWrap: true,

        //                                 ),
        //                         trailing: InkWell(
        //                             onTap: () {
        //                               Get.to(AddArticlePage());
        //                             },
        //                             child: ImageIcon(
        //                               const AssetImage(
        //                                 "assets/images/edit.png",
        //                               ),
        //                               color: AppColor.black,
        //                             )),
        //                       ),
        //                     ),
        //                   ));
        //             });
        //       },
        //     )

        //         //  }),
        //         ),
        //   ],
        // ),
        );
  }
}
