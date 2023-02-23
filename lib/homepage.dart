// ignore_for_file: camel_case_types

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
  ArticleListController articleListController = Get.put(ArticleListController());
  List articalList = [];
  List<dynamic> tempList = [];

  @override
  void initState() {
    super.initState();
    _getArticlelist();
  }

  _getArticlelist() async {
    final prefs = await SharedPreferences.getInstance();
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
        title: appText(title: "Articel",color: Colors.white),
        backgroundColor: AppColor.primary,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
           Padding(
             padding:  EdgeInsets.only(right:2.w),
             child:   InkWell(
              onTap: () {
                Get.to( addArticlePage(Create : "CREATE"));
              },
              child: const ImageIcon( AssetImage("assets/images/createnew.png"),)),
           ),
          
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 3.h),
            child: Container(
              height: 7.h,
              child: CupertinoSearchTextField(
                controller: articleListController.SearchController,
                onChanged: (String value) {
                  print('The text has changed to: $value');
                },
                onSubmitted: (String value) {
                  print('Submitted text: $value');
                },
              ),
            ),
          ),
          // Html(data: tempList[0]['name'].toString()),
          Expanded(
            child: ListView.builder(
                itemCount: articleListController.article.length,
                itemBuilder: (BuildContext context, int index) {
                 final articelData = articleListController.article[index];
                  return InkWell(
                    onTap: () {
                      Get.to( Articel_Screen(ariceltitle: articelData.title,articelSubTitle: articelData.subtitle,));              // Navigator.push(context, CupertinoPageRoute(builder: (context) => Dictation_Screen( drimage: drList[index].image,drname: drList[index].name,),));
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal:3.w),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                        child: ListTile(
                          title: appText(title: articelData.title),
                          subtitle: appText(title: articelData.subtitle,),
                          trailing: InkWell(
                            onTap: () {
                              Get.to( addArticlePage(editArticel: articelData.subtitle, Create: "UPDATE",));
                            },
                            child: ImageIcon(const AssetImage("assets/images/edit.png",),color: AppColor.black,)),    
                        ),
                      ),
                    )
                  );
                }),
          ),
        ],
      ),
    
    );
  }
}
