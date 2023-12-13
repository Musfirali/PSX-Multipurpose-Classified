import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../ps_button_widget.dart';

class ShareAppDialog extends StatefulWidget {
  const ShareAppDialog({this.message, this.onPressed});
  final String? message;
  final Function? onPressed;

  @override
  _ShareAppDialogState createState() => _ShareAppDialogState();
}

class _ShareAppDialogState extends State<ShareAppDialog> {
  @override
  Widget build(BuildContext context) {
    return _NewDialog(widget: widget);
  }
}

class _NewDialog extends StatelessWidget {
  const _NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ShareAppDialog widget;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'share_app'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic800 : PsColors.achromatic50,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: PsDimens.space24),
            PSButtonWidget(
              colorData: Theme.of(context).primaryColor,
              hasShadow: true,
              titleText: 'share_android_app'.tr,
              onPressed: () async {
                final Size size = MediaQuery.of(context).size;
                Share.share(
                  psValueHolder.googlePlayStoreUrl!,
                  sharePositionOrigin:
                      Rect.fromLTWH(0, 0, size.width, size.height / 2),
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: PsDimens.space18),
            PSButtonWidget(
              colorData: Theme.of(context).primaryColor,
              hasShadow: true,
              titleText: 'share_ios_app'.tr,
              onPressed: () async {
                final Size size = MediaQuery.of(context).size;
                Share.share(
                  psValueHolder.appleAppStoreUrl!,
                  sharePositionOrigin:
                      Rect.fromLTWH(0, 0, size.width, size.height / 2),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
