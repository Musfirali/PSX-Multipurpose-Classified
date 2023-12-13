import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/utils/utils.dart';

class EmptyPromotionTransactionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            'You have no active Promotion. \n Buy and create post'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Utils.isLightMode(context) ? PsColors.text400 : PsColors.text300),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
