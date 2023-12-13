import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({required this.resetCallBack});
  final Function resetCallBack;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: resetCallBack as Function(),
        child: Container(
          decoration: BoxDecoration(
            color: PsColors.text50,
            border: Border.all(
              color: PsColors.achromatic100,
            ),
            borderRadius: BorderRadius.circular(PsDimens.space4),
          ),
          alignment: Alignment.center,
          height: 40,
          width: double.infinity,
          child: Text(
            'Reset'.tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: PsColors.text800, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
