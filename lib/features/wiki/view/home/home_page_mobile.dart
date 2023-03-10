// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
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
      backgroundColor: AppColor.whiteColor,
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
                Get.to( AddArticlePage(newArticle: true,oldArticle: false,));
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
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            child: SizedBox(
              height: 7.h,
              child: CupertinoSearchTextField(
                controller: articleController.searchArticle,
                onChanged: (String value) {
                  setState(() {
                    searchtxt = articleController.searchArticle.text;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: ArticleDataStore.box.listenable(),
              builder: (context, Box box, widget) {
               var results = searchtxt.isEmpty
                    ? box.values.toList() // whole list
                    : box.values
                        .where((c) => c.title.toLowerCase().contains(searchtxt))
                        .toList();
                print("results : $results");
                return results.isEmpty
                    ? Center(
                        child:
                            appText(title: "No Article", color: AppColor.grey),
                      )
                    : SingleChildScrollView(
                        child: GetBuilder<Article>(
                          builder: (controller) {
                            return  ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: results.length,
                              itemBuilder: (BuildContext context, int index) {
                                var articleData = searchtxt.isEmpty
                                  ? box.getAt(index) // whole list
                                  : results[index];
                              print("articleData : $articleData");
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
                                      color: AppColor.whiteColor,
                                      gradient:LinearGradient(
                                        colors: [
                                          AppColor.gradient,
                                          AppColor.whiteColor,

                                        ],
                                        begin:Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                       
                                        ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.grey.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2)
                                        )
                                      ],
                                      borderRadius:  BorderRadius.circular(3.w),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        appText(
                                          title: articleData.title,
                                          fontSize: 3.3.h,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500
                                        ),
                                          SizedBox(height:1.5.h),
                                          Padding(
                                            padding:  EdgeInsets.only(left:1.w),
                                            child: appText(
                                            title: articleData.shortdescription,
                                            fontSize: 1.5.h,
                                            color: AppColor.black.withOpacity(0.9),
                                            maxLines: 2,
                                            
                                            ),
                                          ),
                                           Row(
                                              children: [
                                                Flexible(
                                                  child: Html(
                                                    data: articleData.content,
                                                    shrinkWrap: true,
                                                     style:{
                                                      "body":Style(fontSize: FontSize(2.h),
                                                      color: AppColor.grey,
                                                      textOverflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      ),}

                                                  ),
                                                ),
                                              ],
                                            ),

                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          // InkWell(
                                          //   onTap: () {
                                          //     Get.to(AddArticlePage(newArticle: false,oldArticle: true,index: index,articlemodel: articleData,));
                                          //   },
                                          //   child:  ImageIcon(
                                          //     const AssetImage(AppImage.editicon),
                                          //     size: 2.7.h,
                                          //     color: AppColor.black,
                                          //   ),
                                          // ),
                                          // SizedBox(width: 4.w,),
                                          InkWell(
                                            onTap: () {
                                            articleController.deleteArticle(index);
                                            },
                                            child:  ImageIcon(
                                              const AssetImage(AppImage.deleticon),
                                              size: 2.7.h,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                          },
                        ),
                      );
              },
            ),
          ),
          SizedBox(height: 2.h,),
        ],
      ),
    );
  }
}
