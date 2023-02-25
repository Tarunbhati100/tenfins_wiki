// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/Article_screen.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:tenfins_wiki/controller/articleListcontroller.dart';
import 'package:tenfins_wiki/add_article.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  ArticleListController articleListController =
      Get.put(ArticleListController());
  List<dynamic> tempList = [];
  List<dynamic> searchList = [];
  bool iscreate = true;
  bool isvisible = true;
   late final String photo;

  @override
  void initState() {
    super.initState();
    _getArticlelist();
  }

  _getArticlelist() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove("myLists");
    setState(() {
      if (prefs.getStringList("myLists").toString().isEmpty) {
        tempList = [];
      } else {
        print(prefs.getStringList("myLists").toString());
        tempList = jsonDecode(prefs.getStringList("myLists").toString());
      }
      print("==============${tempList}==============");
    });
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
                  Get.to(addArticlePage(Create: "CREATE"));
                },
                child: const ImageIcon(
                  AssetImage("assets/images/createnew.png"),
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            child: Container(
              height: 7.h,
              child: CupertinoSearchTextField(
                controller: articleListController.SearchController,
                onChanged: (String value) {
                  setState(() {
                    searchList = tempList
                        .where((element) => element["title"]!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                  print('The text has changed to : $value');
                },
                onSubmitted: (String value) {
                  print('Submitted text: $value');
                },
              ),
            ),
          ),
          Expanded(
            child:
             articleListController.SearchController.text.isNotEmpty &&
                    searchList.isEmpty
                ?Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            'No results',
                            style: TextStyle(
                                fontSize: 22, color: Color(0xff848484)),
                          ),
                        ),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount:
                        articleListController.SearchController.text.isNotEmpty
                            ? searchList.length
                            : tempList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            Get.to(Article_Screen(Article: tempList[index]));
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
                                            .SearchController.text.isNotEmpty
                                        ? searchList[index]['title'].toString()
                                        : tempList[index]['title'].toString()),
                                subtitle: Html(
                                    data: tempList[index]['name'].toString()),
                                    leading: Container(
                                        height: 70.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.network(
                                            "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                trailing: InkWell(
                                    onTap: () {
                                      Get.to(addArticlePage(
                                        editArticle: tempList[index],
                                        Iscreate: iscreate,
                                        isvisible: isvisible,
                                        Create: "UPDATE",
                                      ));
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
                    }),
          ),
        ],
      ),
    );
  }
}
