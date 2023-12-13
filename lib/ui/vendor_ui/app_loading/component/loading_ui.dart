import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../common/ps_square_progress_widget.dart';

class LoadingUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget _imageWidget = Container(
      width: 90,
      height: 90,
      child: Image.asset(
        'assets/images/flutter_buy_and_sell_logo.png',
      ),
    );
    return Container(
        height: 400,
        color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _imageWidget,
                const SizedBox(
                  height: PsDimens.space16,
                ),
                Text(
                  'app_name'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Utils.isLightMode(context)
                        ? PsColors.achromatic700
                        : PsColors.achromatic50,
                  )
                ),
                const SizedBox(
                  height: PsDimens.space8,
                ),
                Container(
                    padding: const EdgeInsets.all(PsDimens.space16),
                    child: PsSquareProgressWidget()),
              ],
            )
          ],
        ));
  }
}
