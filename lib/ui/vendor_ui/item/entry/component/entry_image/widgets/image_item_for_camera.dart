import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/delete_image_icon.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';

class CameraImageItem extends StatelessWidget {
  const CameraImageItem(
      {required this.index, required this.onDeleteCameraImage});
  final int index;
  final Function onDeleteCameraImage;
  @override
  Widget build(BuildContext context) {
    final ItemEntryProvider itemEntryProvider =
        Provider.of<ItemEntryProvider>(context);
    return Stack(
      children: <Widget>[
        Image(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
            image: FileImage(File(itemEntryProvider.cameraImagePath[index]!))),
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
                              onDeleteCameraImage();
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
