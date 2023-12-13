import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/listing_title.dart';

class CustomListingTitle extends StatelessWidget {
  const CustomListingTitle(
      {required this.textEditingController, required this.isMandatory});
  final TextEditingController? textEditingController;
  final bool isMandatory;
  @override
  Widget build(BuildContext context) {
    return ListingTitle(
      isMandatory: isMandatory,
      textEditingController: textEditingController,
    );
  }
}
