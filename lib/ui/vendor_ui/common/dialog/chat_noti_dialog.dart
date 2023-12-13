import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class ChatNotiDialog extends StatefulWidget {
  const ChatNotiDialog(
      {Key? key,
      this.description,
      this.leftButtonText,
      this.rightButtonText,
      this.onAgreeTap})
      : super(key: key);

  final String? description, leftButtonText, rightButtonText;
  final Function? onAgreeTap;

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ChatNotiDialog> {
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

  final ChatNotiDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.mail_outline,
              ),
              const SizedBox(
                width: PsDimens.space12,
              ),
              Text(
                'chat_noti__new_message'.tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic800
                          : PsColors.achromatic50,
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
                    widget.description ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      PSButtonWidgetRoundCorner(
                          colorData: PsColors.achromatic100,
                          hasShadow: false,
                          width: 80,
                          height: 40,
                          titleText: widget.leftButtonText!,
                          titleTextColor: PsColors.achromatic900,
                          hasBorder: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      const SizedBox(
                        width: 16,
                      ),
                      PSButtonWidgetRoundCorner(
                          colorData: Theme.of(context).primaryColor,
                          hasShadow: false,
                          width: 80,
                          height: 40,
                          titleText: widget.rightButtonText!,
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onAgreeTap!();
                          }),
                    ]),
              ],
            ),
          ),
        ));
  }
}
