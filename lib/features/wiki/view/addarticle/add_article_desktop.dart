// ignore_for_file: must_be_immutable, avoid_print, invalid_use_of_protected_member, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/features/wiki/bloc/ArticleBloc/article.dart';
import 'package:tenfins_wiki/features/wiki/view/home/homepage.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

class AddArticleDesktop extends StatefulWidget {
  final bool? type;
  final int? index;
  final Articlemodel? articleData;
  AddArticleDesktop({super.key, this.type, this.index, this.articleData});

  @override
  State<AddArticleDesktop> createState() => _AddArticleDesktopState();
}

class _AddArticleDesktopState extends State<AddArticleDesktop> {
  Article addArticleController = Get.put(Article());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (widget.type!)
          ? addArticleController.setArticleData(widget.articleData)
          : addArticleController.cleanArticleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          addArticleController.controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: appText(
              title: (widget.type!) ? "Update Article" : "Create New Article"),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 1.w),
              child: TextButton(
                  onPressed: () async {
                    (widget.type!)
                        ? await addArticleController.updateArticle(widget.index)
                        : await addArticleController.addArticle();
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    });
                  },
                  child: appText(
                      title: (widget.type!) ? "Update" : "Save",
                      color: AppColor.whiteColor,
                      fontSize: 20)),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          child: Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(1.5.w),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.grey.withOpacity(0.7), blurRadius: 15)
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Obx(
                  () {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 1.h,
                          ),
                          textField2(
                              controller: addArticleController.titleController,
                              hint: "Enter Title",
                              hight: 8.h,
                              readOnly: false,
                              textInputAction: TextInputAction.done),
                          SizedBox(
                            height: 3.h,
                          ),

                          textField2(
                              controller: addArticleController.shortDescription,
                              hint: "Short Description",
                              hight: 8.h,
                              readOnly: false,
                              textInputAction: TextInputAction.done),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFACAAA0)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blueGrey[50]!,
                                          blurRadius: 1)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      hint: const Text('Select Category'),
                                      value:
                                          addArticleController.selectedCategory,
                                      onChanged: (newValue) {
                                        setState(() {
                                          addArticleController
                                              .selectedCategory = newValue;
                                        });
                                      },
                                      items: addArticleController
                                          .articleCategoryList.value
                                          .map((category) {
                                        return DropdownMenuItem(
                                          value: category['categoryname'],
                                          child: Text(
                                              "${category['categoryname']}"),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: Container(
                                  // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFACAAA0)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blueGrey[50]!,
                                          blurRadius: 1)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      hint: const Text('Select Type'),
                                      value: addArticleController.selectedType,
                                      onChanged: (newValue) {
                                        setState(() {
                                          addArticleController.selectedType =
                                              newValue;
                                        });
                                      },
                                      items: addArticleController
                                          .articleTypeList.value
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value['title'],
                                          child: Text("${value['title']}"),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: textField2(
                                    controller: addArticleController.keywords,
                                    hint: "Keywords",
                                    hight: 8.h,
                                    readOnly: false,
                                    textInputAction: TextInputAction.done),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: textField2(
                                    controller: addArticleController.author,
                                    hint: "Author",
                                    hight: 8.h,
                                    readOnly: false,
                                    textInputAction: TextInputAction.done),
                              )
                            ],
                          ),

                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: textField2(
                                    controller: addArticleController.stars,
                                    hint: "Stars",
                                    hight: 8.h,
                                    readOnly: false,
                                    textInputAction: TextInputAction.done),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: textField2(
                                    controller: addArticleController.tags,
                                    hint: "Tags",
                                    hight: 8.h,
                                    readOnly: false,
                                    textInputAction: TextInputAction.done),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          HtmlEditor(
                            controller: addArticleController.controller,
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
                              onDropdownChanged: (DropdownType type,
                                  dynamic changed,
                                  Function(dynamic)? updateSelectedItem) {
                                return true;
                              },
                              mediaLinkInsertInterceptor:
                                  (String url, InsertFileType type) {
                                return true;
                              },
                              mediaUploadInterceptor: (PlatformFile file,
                                  InsertFileType type) async {
                                print(file.name); //filename
                                print(file.size); //size in bytes
                                print(file.extension);
                                return true;
                              },
                            ),
                           callbacks: Callbacks(onPaste: () {
                              showMsg(context,
                                  msg: 'Paste', color: Colors.black26);
                              print("");
                            }, onInit: () {
                              print("on init");
                              addArticleController.controller
                                  .insertHtml(widget.articleData!.content!);
                            }, onImageUploadError: (FileUpload? file,
                                String? base64Str, UploadError error,) {
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black, width: 1.5))),
                                height: 550),
                            // plugins: [
                            //   SummernoteAtMention(
                            //       getSuggestionsMobile: (String value) {
                            //         List<String> mentions = [
                            //           'test1',
                            //           'test2',
                            //           'test3'
                            //         ];
                            //         return mentions
                            //             .where((element) => element.contains(value))
                            //             .toList();
                            //       },
                            //       mentionsWeb: ['test1', 'test2', 'test3'],
                            //       onSelect: (String value) {
                            //         print(value);
                            //       }),
                            // ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          // customButton(
                          //   width: 50.w,
                          //   height: 6.h,
                          //   title: "Create Article",
                          //   textColor: AppColor.whiteColor,
                          //   onTap: addArticleController.addArticle,
                          // ),
                          // SizedBox(
                          //   height: 3.h,
                          // ),
                        ]);
                  },
                ),
              ),
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
}
