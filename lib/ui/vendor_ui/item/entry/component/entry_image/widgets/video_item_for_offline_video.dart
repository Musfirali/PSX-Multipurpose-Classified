import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';

class OfflineVideoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemEntryProvider itemEntryProvider =
        Provider.of<ItemEntryProvider>(context);
    return Image(
        alignment: Alignment.center,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        image: FileImage(File(itemEntryProvider.getNewVideoThumbnail!)));
  }
}
