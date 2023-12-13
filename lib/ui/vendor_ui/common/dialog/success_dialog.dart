import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class SuccessDialog extends StatefulWidget {
  const SuccessDialog(
      {this.message, this.title, this.onPressed, this.btnTitle});
  final String? message, title, btnTitle;
  final Function? onPressed;

  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
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

  final SuccessDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: PsColors.success500,
              ),
              const SizedBox(
                width: PsDimens.space12,
              ),
              Text(
                widget.title ?? 'Success',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic800 : PsColors.achromatic50,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800 : PsColors.achromatic50,
            ))
      ],
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headerWidget,
              Container(
                padding: const EdgeInsets.only(
                    top: PsDimens.space16, bottom: PsDimens.space24),
                child: Text(
                  widget.message!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              PSButtonWidgetRoundCorner(
                  colorData: Theme.of(context).primaryColor,
                  hasShadow: false,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  titleText: 'dialog__ok'.tr,
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onPressed!();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
