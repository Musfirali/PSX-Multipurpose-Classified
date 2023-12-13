import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../common/ps_button_widget.dart';

class PayOfflineButton extends StatelessWidget {
  const PayOfflineButton({required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 5,
        right: 2,
        left: 2,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: PsDimens.space16,
            ),
            PSButtonWidget(
                hasShadow: false,
                width: double.infinity,
                titleText: 'item_promote__pay_offline'.tr,
                onPressed: () async {
                  await PsProgressDialog.showDialog(context);
                  onPressed();
                }),
            const SizedBox(
              height: PsDimens.space16,
            ),
          ],
        ));
  }
}
