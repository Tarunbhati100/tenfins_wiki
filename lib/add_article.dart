// ignore_for_file: camel_case_types, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenfins_wiki/homepage.dart';

class addArticlePage extends StatefulWidget {
    String? editArticle;
    String? Create;

 addArticlePage({super.key, this.editArticle, this.Create});

  @override
  State<addArticlePage> createState() => _addArticlePageState();
}

class _addArticlePageState extends State<addArticlePage> {
  String result = '';
  bool isLoading = false;
  final HtmlEditorController controller = HtmlEditorController();

  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: appText(title: "Edit Details"),
          elevation: 0,
          //actions: [
            // IconButton(
            //     icon: const Icon(Icons.refresh),
            //     onPressed: () {
            //       if (kIsWeb) {
            //         controller.reloadWeb();
            //       } else {
            //         controller.editorController!.reload();
            //       }
            //     })
         // ],
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textField2(
                  controller: nameController,
                  hint: 'Enter Article title',
                  hight: 8.h,
                ),
              ),
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: 'Your text here...',
                  shouldEnsureVisible: true,
                  autoAdjustHeight: true,
                  adjustHeightForKeyboard: true,

                  //initialText: "<p>text content initial, if any</p>",
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.aboveEditor, //by default
                  toolbarType: ToolbarType.nativeExpandable,
                  renderBorder: true,
                  toolbarItemHeight: 40,
                  gridViewHorizontalSpacing: 5,
                  gridViewVerticalSpacing: 5,
                  buttonBorderWidth: 2,
                  //initiallyExpanded: true,
                  defaultToolbarButtons: [
                    const StyleButtons(),
                    const FontButtons(),
                    const FontSettingButtons(),
                    const ColorButtons(),
                    const ListButtons(),
                    const ParagraphButtons(caseConverter: false),
                    const InsertButtons(),
                    const OtherButtons(
                        copy: true,
                        codeview: false,
                        undo: false,
                        redo: false,
                        paste: true),
                  ],
                  customToolbarButtons: <Widget>[
                    OutlinedButton(
                      onPressed: showdialog,
                      child: const Icon(
                        Icons.coffee,
                        color: Colors.black,
                      ),
                    ),
                  ],
                  onButtonPressed:
                      (ButtonType type, bool? status, Function? updateStatus) {
                    return true;
                  },
                  onDropdownChanged: (DropdownType type, dynamic changed,
                      Function(dynamic)? updateSelectedItem) {
                    return true;
                  },
                  mediaLinkInsertInterceptor:
                      (String url, InsertFileType type) {
                    return true;
                  },
                  mediaUploadInterceptor:
                      (PlatformFile file, InsertFileType type) async {
                    //file extension (eg jpeg or mp4)
                    return true;
                  },
                ),
                callbacks: Callbacks(onPaste: () {
                  showMsg(context, msg: 'Paste', color: Colors.black26);
                  print("");
                }),
                // ignore: prefer_const_constructors
                otherOptions: OtherOptions(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black, width: 1.5))),
                    height: 550),
                plugins: [
                  SummernoteAtMention(
                      getSuggestionsMobile: (String value) {
                        List<String> mentions = ['test1', 'test2', 'test3'];
                        return mentions
                            .where((element) => element.contains(value))
                            .toList();
                      },
                      mentionsWeb: ['test1', 'test2', 'test3'],
                      onSelect: (String value) {
                        print(value);
                      }),
                ],
              ),
              SizedBox(
                height: 0.1.h,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(result),
              // ),
              customButton(
                  width: 50.w,
                  height: 6.h,
                  title: widget.Create,
                  textColor: AppColor.whiteColor,
                  onTap: () async {
                    var txt = await controller.getText();
                    print("===========");
                    print(txt);
                    if (txt.contains('src=\"data:')) {
                      txt = '<>';
                    }
                    setState(() {
                      result = txt;
                    });
                    CreateArticleList(result);
                    showMsg(context,msg: "Article added Successfully", color: Colors.black26);
                    // Navigator.push(
                    //     context,
                    //     CupertinoPageRoute(
                    //         builder: (context) => homepage()));
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future showdialog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert Dialog Box"),
        content: const Text("You have raised a Alert Dialog Box"),
        actions: <Widget>[
          customButton(
            title: 'OK',
            textColor: AppColor.whiteColor,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void CreateArticleList(String articleList) async {
    try {
      print("%%%%%%%%%%%%%%%%%%${articleList}%%%%%%%%%%%%%%%%%%%%%");
      final prefs = await SharedPreferences.getInstance();
      List<String> tempList = [];
      tempList.add(jsonEncode({
        "name": articleList,
      }));
      prefs.setStringList("myLists", tempList);
      print(tempList);
    } catch (e) {
      print("Error : ${e.toString()}");
    }
  }
}
