import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/features/wiki/bloc/ArticleBloc/article.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article.dart';
import 'package:tenfins_wiki/features/wiki/view/viewarticle/view_article_page.dart';
import 'package:tenfins_wiki/services/article_db.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/utils/imageurl.dart';
import 'package:tenfins_wiki/utils/string.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  Article articleController = Get.put(Article());
  String searchtxt = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: appText(title: AppSatring.wikilist, color: AppColor.whiteColor),
        backgroundColor: AppColor.primary,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: InkWell(
              onTap: () {
                Get.to(const AddArticlePage());
              },
              child: const ImageIcon(
                AssetImage(AppImage.createnewicon),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          //   child: SizedBox(
          //     height: 7.h,
          //     child: CupertinoSearchTextField(
          //       controller: articleController.searchArticle,
          //       onChanged: (String value) {
          //         setState(() {
          //           searchtxt = articleController.searchArticle.text;
          //         });
          //         print("searchtxt : $searchtxt");
          //         // setState(() {
          //         //   searchList = tempList
          //         //       .where((element) => element["title"]!
          //         //           .toLowerCase()
          //         //           .contains(value.toLowerCase()))
          //         //       .toList();
          //         // });
          //         // print('The text has changed to : $value');
          //       },
          //     ),
          //   ),
          // ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: ArticleDataStore.box.listenable(),
              builder: (context, Box box, widget) {
                var results = searchtxt.isEmpty
                    ? box.values.toList() // whole list
                    : box.values
                        .where((c) => c.title.toLowerCase().contains(searchtxt))
                        .toList();
                return results.isEmpty
                    ? Center(
                        child:
                            appText(title: "No Article", color: AppColor.grey),
                      )
                    : SingleChildScrollView(
                        child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: box.length,
                            itemBuilder: (BuildContext context, int index) {
                              var articleData = box.getAt(index);
                              //  print("articleData : ${articleData.categor}");
                              //  print("articleData : ${articleData.toJson()}");
                              //  print("articleData : ${inspect(articleData.toString())}");
                              //   print("articleData : ${jsonEncode(articleData)}");
                              // print("articleData : ${articleData.title}");
                              // print("articleData : ${articleData.description}");
                              return InkWell(
                                onTap: () {
                                  Get.to(ViewArticlePage(
                                      articleData: articleData));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColor.grey.withOpacity(0.1),
                                    border: Border.all(color: AppColor.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
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
                                                      text: articleData.title,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColor.black,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            ),
                                            // RichText(
                                            //   text: TextSpan(
                                            //     children: <TextSpan>[
                                            //       TextSpan(
                                            //           text: articleData
                                            //               .shortdescription,
                                            //           style: TextStyle(
                                            //               fontSize: 16,
                                            //               color: AppColor.black,
                                            //               fontWeight:
                                            //                   FontWeight.w500)),
                                            //     ],
                                            //   ),
                                            // ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Html(
                                                    data: articleData
                                                        .shortdescription,
                                                    shrinkWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     InkWell(
                                      //       onTap: () {
                                      //         Get.to(const AddArticlePage());
                                      //       },
                                      //       child: const ImageIcon(
                                      //         AssetImage(AppImage.editicon),
                                      //         size: 30,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
