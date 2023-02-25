// ignore_for_file: file_names, camel_case_types, must_be_immutable, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'common/color.dart';
import 'common/widget.dart';

class Article_Screen extends StatefulWidget {
Map? Article;

  Article_Screen({super.key, this.Article});

  @override
  State<Article_Screen> createState() => _Article_ScreenState();
}

class _Article_ScreenState extends State<Article_Screen> {
 List<dynamic> tempList = [];
  @override
  void initState() {
    print(widget.Article);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: appText(title: "Your Article"),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Html(data: widget.Article!['name'].toString()),
          ],
        ),
      ),
    );
  }
}
