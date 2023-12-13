import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../vendor_ui/item/entry/component/entry_data/core_and_custom_field_entry_view.dart';

class CustomCoreAndCustomFieldEntryView extends StatefulWidget {
  const CustomCoreAndCustomFieldEntryView(
      {Key? key, 
      this.flag, 
      this.item, 
      this.onItemUploaded,
      required this.categoryId,
      this.isFromChat})
      : super(key: key);

  final String? flag;
  final Product? item;
  final Function? onItemUploaded;
  final String categoryId;
  final bool? isFromChat;

  @override
  State<CustomCoreAndCustomFieldEntryView> createState() =>
      _CustomFieldEntryContainerState();
}

class _CustomFieldEntryContainerState
    extends State<CustomCoreAndCustomFieldEntryView> {
  @override
  Widget build(BuildContext context) {
    return CoreAndCustomFieldEntryView(
      flag: widget.flag,
      item: widget.item,
      onItemUploaded: widget.onItemUploaded,
      categoryId: widget.categoryId,
      isFromChat: widget.isFromChat
    );
  }
}
