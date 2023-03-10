// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/features/wiki/bloc/ArticleBloc/article.dart';
import 'package:tenfins_wiki/features/wiki/view/viewarticle/view_article_page.dart';

import 'package:tenfins_wiki/services/article_db.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/utils/imageurl.dart';
import 'package:tenfins_wiki/utils/string.dart';
import 'package:tenfins_wiki/widgets/widget.dart';
import '../addArticle/add_article.dart';

class HomePageDesktop extends StatefulWidget {

   const HomePageDesktop({super.key,});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
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
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: SizedBox(
              height: 7.h,
              child: CupertinoSearchTextField(
                borderRadius: BorderRadius.circular(1.w),
                backgroundColor: Colors.grey.withOpacity(0.3),
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
                                    padding:  EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 2.h),
                                    margin:  EdgeInsets.symmetric(horizontal:5.w,vertical:2.h ),
                                    decoration: BoxDecoration(
                                      color: AppColor.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.grey.withOpacity(0.6),
                                          blurRadius: 15,
                                          offset: const Offset(1, 2)
                                        
                                        )
                                      ],
                                      borderRadius:  BorderRadius.circular(1.w),
                                        gradient:LinearGradient(
                                        colors: [
                                          AppColor.gradient,
                                          AppColor.whiteColor,

                                        ],
                                        begin:Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                       
                                        ),
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
                                            padding:  EdgeInsets.only(left: 0.2.w),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: appText(
                                                  title: articleData.shortdescription,
                                                  fontSize: 1.5.h,
                                                  color: AppColor.black.withOpacity(0.9),
                                                                                
                                                  
                                                  
                                                  ),
                                                ),
                                              ],
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
                                          // SizedBox(width: 2.w,),
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
        ],
      ),
    );
  }
}
