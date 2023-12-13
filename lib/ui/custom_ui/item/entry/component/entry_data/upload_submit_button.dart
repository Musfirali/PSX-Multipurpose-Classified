
import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/entry/component/entry_data/upload_submit_button.dart';

class CustomUploadSubmitButton extends StatefulWidget {
  const CustomUploadSubmitButton(
      {required this.onItemUploaded,
      required this.flag,
      required this.getEntryData,
      required this.categoryId,
      this.isFromChat});
      
  final Function? onItemUploaded;
  final String? flag;
  final Function getEntryData;
  final String? categoryId;
  final bool? isFromChat;

  @override
  State<StatefulWidget> createState() {
    return UploadSubmitButtonState();
  }
}
class UploadSubmitButtonState extends State<CustomUploadSubmitButton> {
  
  @override
  Widget build(BuildContext context) {
    return UploadSubmitButton(
        onItemUploaded: widget.onItemUploaded,
        flag: widget.flag,
        getEntryData: widget.getEntryData,
        categoryId: widget.categoryId,
        isFromChat: widget.isFromChat);
  }
}
