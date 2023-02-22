// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/common/color.dart';
import 'package:tenfins_wiki/common/widget.dart';
import 'package:file_picker/file_picker.dart';

class htmlEditorPage extends StatefulWidget {
  const htmlEditorPage({super.key});

  @override
  State<htmlEditorPage> createState() => _htmlEditorPageState();
}

class _htmlEditorPageState extends State<htmlEditorPage> {
  String result = '';
  bool isLoading = false;
  final HtmlEditorController controller = HtmlEditorController();
   TextEditingController bioController = TextEditingController();
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
          title: appText(title: "HTML Editor"),
          elevation: 0,
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (kIsWeb) {
                    controller.reloadWeb();
                  } else {
                    controller.editorController!.reload();
                  }
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () {
            controller.toggleCodeView();
          },
          child: const Text(r'<\>',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  tooltip();
                  showMsg(context, msg: 'Paste', color: Colors.black26);
                  print("");
                }),
                // ignore: prefer_const_constructors
                otherOptions: OtherOptions(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black, width: 1.5))),
                    height: 400),
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
                child: Text(result),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    customButton(
                        title: 'Undo',
                        onTap: () {
                          controller.undo();
                        },
                        textColor: AppColor.whiteColor),
                    const SizedBox(
                      width: 16,
                    ),
                    customButton(
                        title: 'Reset',
                        onTap: () {
                          controller.clear();
                        },
                        textColor: AppColor.whiteColor),
                    const SizedBox(
                      width: 16,
                    ),
                    customButton(
                        title: 'Submit',
                        onTap: () async {
                          var txt = await controller.getText();
                          if (txt.contains('src=\"data:')) {
                            txt =
                                '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                          }
                          setState(() {
                            result = txt;
                          });
                        },
                        textColor: AppColor.whiteColor),
                    const SizedBox(
                      width: 16,
                    ),
                    customButton(
                        title: 'Redo',
                        onTap: () {
                          controller.redo();
                        },
                        textColor: AppColor.whiteColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    customButton(
                        width: 25.w,
                        title: 'Insert Link',
                        onTap: () {
                          controller.insertLink(
                              "Insert Link", 'https://google.com', true);
                        },
                        textColor: AppColor.whiteColor),
                    const SizedBox(
                      width: 16,
                    ),
                    customButton(
                        title: 'success',
                        onTap: () {
                          controller.addNotification(
                              "success", NotificationType.success);
                        },
                        textColor: AppColor.whiteColor),
                    const SizedBox(
                      width: 16,
                    ),
                    customButton(
                        title: 'Decline',
                        onTap: () {
                          controller.addNotification(
                              "Decline", NotificationType.warning);
                        },
                        textColor: AppColor.whiteColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    customButton(
                        color: AppColor.grey,
                        title: 'Disable',
                        onTap: () {
                          controller.disable();
                        },
                        textColor: AppColor.whiteColor),
                    const SizedBox(
                      width: 16,
                    ),
                    customButton(
                        title: 'Enable',
                        onTap: () {
                          controller.enable();
                        },
                        textColor: AppColor.whiteColor),
                  ],
                ),
              ),
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

  Widget tooltip() {
    return Tooltip(
      message: 'I am a Tooltip',
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient:
            const LinearGradient(colors: <Color>[Colors.amber, Colors.red]),
      ),
      height: 50,
      padding: const EdgeInsets.all(8.0),
      preferBelow: false,
      textStyle: const TextStyle(
        fontSize: 24,
      ),
      showDuration: const Duration(seconds: 2),
      waitDuration: const Duration(seconds: 1),
      child: const Text('Tap this text and hold down to show a tooltip.'),
    );
  }
}
