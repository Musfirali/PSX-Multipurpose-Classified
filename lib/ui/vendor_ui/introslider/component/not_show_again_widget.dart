import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/utils/utils.dart';

class NotShowAgainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotShowAgainWidgetState();
}

class _NotShowAgainWidgetState extends State<NotShowAgainWidget> {
  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: PsDimens.space8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: provider.isCheckBoxSelect,
                onChanged: (bool? value) {
                  setState(() {
                    updateCheckBox(
                        context, provider, provider.isCheckBoxSelect);
                  });
                }),
            Text(
              'intro_slider_do_not_show_again'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic900
                        : PsColors.achromatic50,
                  ),
            ),
          ]),
    );
  }

  Future<void> updateCheckBox(BuildContext context, UserProvider provider,
      bool isCheckBoxSelect) async {
    if (isCheckBoxSelect) {
      provider.isCheckBoxSelect = false;
    } else {
      provider.isCheckBoxSelect = true;
    }
  }
}
