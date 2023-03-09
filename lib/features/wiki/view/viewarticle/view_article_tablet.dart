// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
        elevation: 0,
        backgroundColor: AppColor.primary,
        title: appText(title: widget.articleData.title),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: appText(
                title: widget.articleData.shortdescription,
                color: AppColor.black,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: Html(
              data: widget.articleData.content,
              style: {
                "body": Style(
                  color: AppColor.black.withOpacity(0.6),
                )
              },
            ),
          ),
        ],
      )),
    );
  }
}
