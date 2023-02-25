// ignore_for_file: camel_case_types, depend_on_referenced_packages, use_build_context_synchronously, must_be_immutable, non_constant_identifier_names, prefer_const_constructors

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
  Map? editArticle;
  String? Create;
  bool? Iscreate;
  bool? isvisible;

  addArticlePage(
      {super.key,
      this.editArticle,
      this.Create,
      this.Iscreate,
      this.isvisible});

  @override
  State<addArticlePage> createState() => _addArticlePageState();
}

class _addArticlePageState extends State<addArticlePage> {
  String result = '';
  bool isLoading = false;
  List<dynamic> articleList = [];
  final HtmlEditorController controller = HtmlEditorController();

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    _getArticlelist();
    super.initState();
  }

  _getArticlelist() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getStringList("myLists").toString().isEmpty) {
        articleList = [];
      } else {
        print(prefs.getStringList("myLists").toString());
        articleList = jsonDecode(prefs.getStringList("myLists").toString());
      }
      print("==============${articleList}==============");
    });
  }

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
          title: appText(title: widget.isvisible == true ? "Edit Article" : "Create Article"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  initialText: widget.Iscreate == true
                      ? widget.editArticle!["name"].toString()
                      : "",
                  hint: "Write Your Article..",
                  shouldEnsureVisible: true,
                  autoAdjustHeight: true,
                  adjustHeightForKeyboard: true,
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.aboveEditor,
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
                    const ParagraphButtons(caseConverter: true),
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
                    print(file.name); //filename
                    print(file.size); //size in bytes
                    print(file.extension);
                    return true;
                  },
                ),
                callbacks: Callbacks(onPaste: () {
                  showMsg(context, msg: 'Paste', color: Colors.black26);
                  print("");
                }, onImageUploadError:
                    (FileUpload? file, String? base64Str, UploadError error) {
                  print(describeEnum(error));
                  print(base64Str ?? '');
                  if (file != null) {
                    print(file.name);
                    print(file.size);
                    print(file.type);
                  }
                }),
                otherOptions: const OtherOptions(
                    decoration: BoxDecoration(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textField2(
                    controller: nameController,
                    hint: widget.isvisible == true
                        ? widget.editArticle!["title"].toString()
                        : 'Enter Article title',
                    hight: 8.h,
                    readOnly: widget.isvisible == true ? true : false,
                    textInputAction: TextInputAction.done),
              ),
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
                    print("===============");
                    print(txt);
                    setState(() {
                      result = txt;
                    });
                    widget.isvisible == true ?"":CreateArticleList(result, nameController.text);
                    showMsg(context,
                        msg: widget.isvisible == true ? "Article update Successfully" : "Article added Successfully",
                        color: Colors.black26);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const homepage()));
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

  void CreateArticleList(String articleList, String title) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> tempList;
      if (prefs.getStringList("myLists") != null) {
        tempList = prefs.getStringList("myLists")!;
      } else {
        tempList = [];
      }
      if (tempList.isNotEmpty) {
        for (var i = 0; i < tempList.length; i++) {
          var t = jsonDecode(tempList[i]);
          if (articleList.toLowerCase() != t["title"].toString().toLowerCase()) {
            tempList.add(jsonEncode({
              "title": title,
              "name": articleList,
            }));
            break;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Article alredy exists")));
          }
        }
        // tempList.add(jsonEncode({
        //   "title": title,
        //   "name": articleList,
        // }));
      } else {
        tempList.add(jsonEncode({
          "title": title,
          "name": articleList,
        }));
      }
      prefs.setStringList("myLists", tempList);
      _getArticlelist();
      print(tempList);
    } catch (e) {
      print("Error : ${e.toString()}");
    }
  }
}
