import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';

class BlockUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: InkWell(
        onTap: () {
          print('App Info');
          Navigator.pushNamed(context, RoutePaths.blockUserList);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: PsDimens.space16, vertical: 12),
          child: Ink(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'more__block_user_title'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Utils.isLightMode(context)
                      ? PsColors.text800 : PsColors.text50,
                  size: PsDimens.space20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
