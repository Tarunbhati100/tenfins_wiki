// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
      // appBar: AppBar(
      //   backgroundColor: AppColor.primary,
      //   title: appText(title: widget.articleData.title),
      //   centerTitle: true,
      //   leading: InkWell(
      //       onTap: () {
      //         Get.back();
      //       },
      //       child: const Icon(Icons.arrow_back_rounded)),
      // ),
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
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 1.h,),
             appText(
              title: widget.articleData.title,
              fontSize: 3.h,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic

              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: appText(
                  title: widget.articleData.shortdescription,
                  color: AppColor.black.withOpacity(0.8),
                  fontSize: 2.h,
                  fontWeight: FontWeight.w600,
                  ),
            ),
             Divider(color: AppColor.grey.withOpacity(0.4),endIndent: 2.w,indent: 2.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Html(
                data: widget.articleData.content,
                style: {
                  "body": Style(
                    color: AppColor.black.withOpacity(0.4),
                    fontSize: FontSize(1.h)
                  )
                },
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 2.h),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(1.5.w),
              boxShadow: [
                BoxShadow(
                  color: AppColor.grey.withOpacity(0.7),
                  blurRadius: 20
                )
              ]
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
    
            children: 
              [
                Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  appText(title: "Author : ${widget.articleData.author}",color: AppColor.primary,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                  SizedBox(height:1.h),
                  appText(title: "Category : ${widget.articleData.category}",color: AppColor.primary,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                  ]),
              SizedBox(width: 3.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  appText(title: "Star : ${widget.articleData.stars}",color: AppColor.primary,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                  SizedBox(height:1.h),
                  appText(title: "Tag : ${widget.articleData.tags}",color: AppColor.primary,fontWeight: FontWeight.w600,fontSize: 1.7.h),
                            ]),
            ],
          ),
        ),
            )
          ],
        )),
      ),
    );
  }
}
