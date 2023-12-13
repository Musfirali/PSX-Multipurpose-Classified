import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class ChooseCameraTypeDialog extends StatefulWidget {
  const ChooseCameraTypeDialog({Key? key, this.onCameraTap, this.onGalleryTap})
      : super(key: key);

  final Function? onCameraTap;
  final Function? onGalleryTap;

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ChooseCameraTypeDialog> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ChooseCameraTypeDialog widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: 400.0,
        // height: 300.0,
        padding: const EdgeInsets.all(PsDimens.space16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('camera_dialog__title'.tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic800
                          : PsColors.achromatic50,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: PsDimens.space16),
            PSButtonWidgetRoundCorner(
              height: 40,
              colorData: Theme.of(context).primaryColor,
              hasShadow: false,
              width: double.infinity,
              titleText: 'camera_dialog__gallery_and_camera'.tr,
              onPressed: () {
                Navigator.pop(context);
                widget.onGalleryTap!();
              },
            ),
            const SizedBox(height: PsDimens.space16),
            Divider(
              color: Theme.of(context).iconTheme.color,
              height: 0.5,
            ),
            const SizedBox(height: PsDimens.space16),
            Text('camera_dialog__text'.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 12)),
            const SizedBox(height: PsDimens.space16),
            PSButtonWidgetRoundCorner(
              height: 40,
              colorData: Theme.of(context).primaryColor,
              hasShadow: false,
              width: double.infinity,
              titleText: 'camera_dialog__custom_camera'.tr,
              onPressed: () {
                Navigator.pop(context);
                widget.onCameraTap!();
              },
            ),
          ],
        ),
      ),
    );
  }
}
