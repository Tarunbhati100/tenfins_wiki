// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, invalid_use_of_protected_member, prefer_const_constructors_in_immutables, unnecessary_null_comparison, prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/features/wiki/bloc/AddArticleBloc/add_article_bloc.dart';
import 'package:tenfins_wiki/features/wiki/bloc/AddArticleBloc/add_article_event.dart';
import 'package:tenfins_wiki/features/wiki/bloc/AddArticleBloc/add_article_state.dart';
import 'package:tenfins_wiki/features/wiki/view/home/homepage.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';
import 'package:tenfins_wiki/repos/article_repository.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

class AddArticleMobile extends StatefulWidget {
  final bool? type;
  final int? index;
  final Articlemodel? articleData;
  AddArticleMobile({super.key, this.type, this.index, this.articleData});

  @override
  State<AddArticleMobile> createState() => _AddArticleMobileState();
}

class _AddArticleMobileState extends State<AddArticleMobile> {
  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescription = TextEditingController();
  TextEditingController keywords = TextEditingController();
  TextEditingController searchArticle = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController mentions = TextEditingController();
  TextEditingController stars = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  ValueNotifier<bool> isUpdate = ValueNotifier<bool>(false);

  bool isLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  var selectedType;
  // ignore: prefer_typing_uninitialized_variables
  var selectedCategory;

  AddArticleBloc addarticleBloc = AddArticleBloc(ArticleRepository());

  @override
  void initState() {
    super.initState();
    if (widget.type!) {
      titleController.text = widget.articleData!.title!;
      shortDescription.text = widget.articleData!.shortdescription!;
      selectedCategory = widget.articleData!.category!;
      keywords.text = widget.articleData!.keywords!;
      author.text = widget.articleData!.author!;
      selectedType = widget.articleData!.type!;
      stars.text = widget.articleData!.stars!;
      tags.text = widget.articleData!.tags!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddArticleBloc>(
      create: (context) => addarticleBloc..add(LoadApiEvent()),
      child: GestureDetector(
        onTap: () {
          if (!kIsWeb) {
            controller.clearFocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primary,
            title: appText(
                title:
                    (widget.type!) ? "Update Article" : "Create New Article"),
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 1.w),
                child: InkWell(
                  onTap: () async {
                    if (selectedCategory != null && selectedType != null) {
                      var description = await controller.getText();
                      if (description.contains('src="data:') &&
                          description.contains('src="img:')) {
                        description = '<>';
                      }

                      final article = Articlemodel()
                        ..id = 1
                        ..title = titleController.text
                        ..shortdescription = shortDescription.text
                        ..category = selectedCategory.toString()
                        ..keywords = keywords.text
                        ..author = author.text
                        ..views = ""
                        ..likes = ""
                        ..mentions = mentions.text
                        ..stars = stars.text
                        ..tags = tags.text
                        ..type = selectedType.toString()
                        ..lastUpdated = ""
                        ..dateTime = ""
                        ..content = description;

                      if (widget.type!) {
                        addarticleBloc
                            .add(UpdateArticleEvent(article, widget.index!));
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        addarticleBloc.add(SaveArticleEvent(article));
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please fill Category and Type",
                          backgroundColor: AppColor.primary,
                          textColor: AppColor.whiteColor);
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.all(1.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.whiteColor),
                          borderRadius: BorderRadius.circular(3.w)),
                      child: Center(
                        child: appText(
                            title: (widget.type!) ? "Update" : "Save",
                            color: AppColor.whiteColor,
                            fontSize: 2.h),
                      )),
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.grey.withOpacity(0.7), blurRadius: 15)
                  ]),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 1.h,
                      ),
                      textField2(
                          controller: titleController,
                          hint: "Enter Title",
                          hight: 8.h,
                          readOnly: false,
                          textInputAction: TextInputAction.done),
                      SizedBox(
                        height: 3.h,
                      ),
                      textField2(
                          controller: shortDescription,
                          hint: "Short Description",
                          hight: 8.h,
                          readOnly: false,
                          textInputAction: TextInputAction.done),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocConsumer<AddArticleBloc, AddArticleState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is AddArticleLoadedState) {
                            return Container(
                              // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFACAAA0)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey[50]!,
                                      blurRadius: 1)
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: const Text('Select Category'),
                                  value: selectedCategory,
                                  onChanged: (newValue) {
                                    if (mounted) {
                                      setState(() {
                                        selectedCategory = newValue;
                                      });
                                    }
                                  },
                                  items: state.categorylist.map((category) {
                                    return DropdownMenuItem(
                                      value: category['categoryname'],
                                      child:
                                          Text("${category['categoryname']}"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }
                          if (state is AddArticleLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Center(
                            child: appText(
                                title: "No Category", color: AppColor.grey),
                          );
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      textField2(
                          controller: keywords,
                          hint: "Keywords",
                          hight: 8.h,
                          readOnly: false,
                          textInputAction: TextInputAction.done),
                      SizedBox(
                        height: 3.h,
                      ),
                      textField2(
                          controller: author,
                          hint: "Author",
                          hight: 8.h,
                          readOnly: false,
                          textInputAction: TextInputAction.done),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocConsumer<AddArticleBloc, AddArticleState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is AddArticleLoadedState) {
                            return Container(
                              // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFACAAA0)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey[50]!,
                                      blurRadius: 1)
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: const Text('Select Type'),
                                  value: selectedType,
                                  onChanged: (newValue) {
                                    if (mounted) {
                                      setState(() {
                                        selectedType = newValue;
                                      });
                                    }
                                  },
                                  items: state.typelist.map((value) {
                                    return DropdownMenuItem(
                                      value: value['title'],
                                      child: Text("${value['title']}"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }
                          if (state is AddArticleLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Center(
                            child: appText(
                                title: "No Category", color: AppColor.grey),
                          );
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      textField2(
                          controller: stars,
                          hint: "Stars",
                          hight: 8.h,
                          readOnly: false,
                          textInputAction: TextInputAction.done),
                      SizedBox(
                        height: 3.h,
                      ),
                      textField2(
                          controller: tags,
                          hint: "Tags",
                          hight: 8.h,
                          readOnly: false,
                          textInputAction: TextInputAction.done),
                      SizedBox(
                        height: 3.h,
                      ),
                      HtmlEditor(
                        controller: controller,
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: "Write Your Article..",
                          shouldEnsureVisible: true,
                          autoAdjustHeight: true,
                          adjustHeightForKeyboard: true,
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(
                          buttonSelectedColor: AppColor.primary,
                          toolbarPosition: ToolbarPosition.aboveEditor,
                          toolbarType: ToolbarType.nativeScrollable,
                          renderBorder: true,
                          // toolbarItemHeight: 50,
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
                        }, onInit: () {
                          print("on init");
                          (widget.type!)
                              ? controller
                                  .insertHtml(widget.articleData!.content!)
                              : null;
                        }, onImageUploadError: (
                          FileUpload? file,
                          String? base64Str,
                          UploadError error,
                        ) {
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
                        plugins: [
                          SummernoteAtMention(
                              getSuggestionsMobile: (String value) {
                                List<String> mentions = [
                                  'test1',
                                  'test2',
                                  'test3'
                                ];
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
                    ],
                  ),
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
