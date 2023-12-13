import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({this.message});
  final String? message;
  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
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

  final InfoDialog widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.all(PsDimens.space8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  color: Theme.of(context).primaryColor),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: PsDimens.space4),
                  Icon(
                    Icons.info,
                    color: PsColors.achromatic50,
                  ),
                  const SizedBox(width: PsDimens.space4),
                  Text(
                    'info_dialog__info'.tr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: PsColors.achromatic50,
                    ),
                  ),
                ],
              )),
          const SizedBox(height: PsDimens.space20),
          Container(
            padding: const EdgeInsets.only(
                left: PsDimens.space16,
                right: PsDimens.space16,
                top: PsDimens.space8,
                bottom: PsDimens.space8),
            child: Text(
              widget.message!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: PsDimens.space20),
          Divider(
            color: PsColors.achromatic900,
            height: 1,
          ),
          MaterialButton(
            height: 50,
            minWidth: double.infinity,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'dialog__ok'.tr,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
