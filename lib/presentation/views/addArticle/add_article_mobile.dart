// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:tenfins_wiki/model/databaseModel.dart';
import '../../../buisness_logic/controller/articleController.dart';

class AddArticleMobile extends StatefulWidget {
  ArticleModel? articleModel;
  AddArticleMobile({super.key, this.articleModel});

  @override
  State<AddArticleMobile> createState() => _AddArticleMobileState();
}

class _AddArticleMobileState extends State<AddArticleMobile> {
  ArticleController articleController = Get.put(ArticleController());
  @override
  Widget build(BuildContext context) {
    if (widget.articleModel != null) {
      articleController.titleController.text = widget.articleModel!.title!;
    }
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          articleController.controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: appText(title: "Create New Article"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 1.h,
                ),
                textField2(
                    controller: articleController.titleController,
                    hint: "Enter Title",
                    hight: 8.h,
                    readOnly: false,
                    textInputAction: TextInputAction.done),
                SizedBox(
                  height: 3.h,
                ),
                HtmlEditor(
                  controller: articleController.controller,
                  htmlEditorOptions: const HtmlEditorOptions(
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
                    onButtonPressed: (ButtonType type, bool? status,
                        Function? updateStatus) {
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
                  height: 3.h,
                ),
                customButton(
                  width: 50.w,
                  height: 6.h,
                  title: "Create Article",
                  textColor: AppColor.whiteColor,
                  onTap: articleController.saveArticle,
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
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

  // AddArticle() async {
  //   var description = await articleController.controller.getText();
  //   if (description.contains('src=\"data:')) {
  //     description = '<>';
  //   }
  //   if (articleController.isUpdate.value) {
  //     final Article = Articlemodel(
  //       id: 1,
  //       title: articleController.titleController.text,
  //       description: description,
  //     );
  //     articleController.Articledata.updateArticle(
  //             articlemodel: Article, index: Article.id)
  //         .then((value) {
  //       articleController.titleController.clear();
  //       description;
  //     });
  //   } else {
  //     final Article = Articlemodel(
  //       id: 2,
  //       title: articleController.titleController.text,
  //       description: description,
  //     );
  //     articleController.Articledata.addArticle(articlemodel: Article)
  //         .then((value) {
  //       articleController.titleController.clear();
  //       description;
  //       print("Articledata------------$Article");
  //       print(Article.title);
  //       Get.to(const HomePage());
  //     });
  //   }
  // }
}
