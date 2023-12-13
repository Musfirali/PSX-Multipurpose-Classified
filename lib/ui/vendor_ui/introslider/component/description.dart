import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';

class Description extends StatelessWidget {
  const Description({required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final List<String> descriptionList = <String>[
      'intro_slider1_description',
      'intro_slider2_description',
      'intro_slider3_description'
    ];
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: PsDimens.space16),
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: Text(
        descriptionList[currentIndex].tr,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: PsColors.text500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
