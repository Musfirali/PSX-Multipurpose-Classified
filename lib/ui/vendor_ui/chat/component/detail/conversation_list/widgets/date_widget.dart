import 'package:flutter/material.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({required this.lastTimeStamp});
  final String lastTimeStamp;
  @override
  Widget build(BuildContext context) {
    const Widget _spacingWidget = SizedBox(
      width: PsDimens.space10,
    );
    return Container(
      margin:
          const EdgeInsets.only(top: PsDimens.space8, bottom: PsDimens.space8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _spacingWidget,
          Expanded(
            child: Divider(height: PsDimens.space1, color: PsColors.achromatic800,)
          ),
          _spacingWidget,
          Container(
            padding: const EdgeInsets.all(PsDimens.space4),
            decoration: BoxDecoration(
                color: PsColors.achromatic800,
                borderRadius: BorderRadius.circular(PsDimens.space8)),
            child: Text(
              lastTimeStamp,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: PsColors.achromatic50),
            ),
          ),
          _spacingWidget,
          Expanded(
            child: Divider(height: PsDimens.space1, color: PsColors.achromatic800),
          ),
          _spacingWidget,
        ],
      ),
    );
  }
}
