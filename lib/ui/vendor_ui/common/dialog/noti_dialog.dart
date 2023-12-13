import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class NotiDialog extends StatefulWidget {
  const NotiDialog({this.message});
  final String? message;
  @override
  _NotiDialogState createState() => _NotiDialogState();
}

class _NotiDialogState extends State<NotiDialog> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final NotiDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.mail,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: PsDimens.space12,
              ),
              Text(
                'noti_dialog__notification'.tr,
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
      ],
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PsDimens.space16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headerWidget,
              Container(
                padding: const EdgeInsets.only(
                    top: PsDimens.space8, bottom: PsDimens.space24),
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
