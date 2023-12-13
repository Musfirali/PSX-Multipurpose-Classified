import 'package:flutter/material.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';

class SettingTitleWidget extends StatelessWidget {
  const SettingTitleWidget({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16, 
          right: PsDimens.space16, 
          top: PsDimens.space18, 
          bottom: PsDimens.space8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
