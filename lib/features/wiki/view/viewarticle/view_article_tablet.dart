// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

class ViewArticleTablet extends StatefulWidget {
  var articleData;

  ViewArticleTablet({super.key, required this.articleData});

  @override
  State<ViewArticleTablet> createState() => _ViewArticleTabletState();
}

class _ViewArticleTabletState extends State<ViewArticleTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: appText(title: widget.articleData.title),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(1.5.w),
              boxShadow: [
                BoxShadow(
                  color: AppColor.grey.withOpacity(0.7),
                  blurRadius: 15
                )
              ]
        ),
        child: SingleChildScrollView(
            child: AnimationConfiguration.staggeredList(
              position: 3, 
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                verticalOffset: 44,
                child: FadeInAnimation(
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Html(
                        data: widget.articleData.shortdescription,
                        style: {
                     "body": Style(
                      color: AppColor.primary,
                      fontSize: FontSize(2.h)
                    )
                  },
                        ),
                  ),
                  ),
                   Divider(color: AppColor.grey.withOpacity(0.4),endIndent: 2.w,indent: 2.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Html(
                      data: widget.articleData.content,
                      style: {
                        "body": Style(
                          color: AppColor.primary,
                          fontSize: FontSize(1.h)
                        )
                      },
                    ),
                  ),
                  Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 2.h),
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(3.w),
                        gradient: LinearGradient(
                       colors: [
                               AppColor.gradient,
                               AppColor.black,
                              ],
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,                   
                     ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.grey.withOpacity(0.7),
                          blurRadius: 15
                        )
                      ]
                          ),
                          child: Center(
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                     appText(title: "Author : ${widget.articleData.author}",color: AppColor.whiteColor,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                     SizedBox(height:1.h),
                    appText(title: "Category : ${widget.articleData.category}",color: AppColor.whiteColor,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                     SizedBox(height:1.h),
                    appText(title: "Star : ${widget.articleData.stars}",color: AppColor.whiteColor,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                    SizedBox(height:1.h),
                    appText(title: "Tag : ${widget.articleData.tags}",color: AppColor.whiteColor,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                                ]), 
                  )))
                          ],
                        ),
                ),
              ),
            )),
      ),
    );
  }
}
