import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/delete_image_icon.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';

class GalleryImageItem extends StatelessWidget {
  const GalleryImageItem({required this.index, required this.onDeleteGalleryImage});
  final int index;
  final Function onDeleteGalleryImage;
  @override
  Widget build(BuildContext context) {
    final ItemEntryProvider itemEntryProvider =
        Provider.of<ItemEntryProvider>(context);
    return Stack(
      children: <Widget>[
        Image.file(
          File(itemEntryProvider.galleryImagePath[index]!.path),
          width: MediaQuery.of(context).size.width.toDouble(),
          height: MediaQuery.of(context).size.height.toDouble(),
          fit: BoxFit.cover,
        ),
        Positioned(
          child: index == 0
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmDialogView(
                            description:
                                'item_entry__confirm_delete_item_image'.tr,
                            leftButtonText: 'dialog__cancel'.tr,
                            rightButtonText: 'dialog__ok'.tr,
                            onAgreeTap: () async {
                              Navigator.pop(context);
                              onDeleteGalleryImage();
                            },
                          );
                        });
                  },
                  child: CustomDeleteImageIcon()),
          right: 1,
          top: 1,
        ),
      ],
    );
  }
}
