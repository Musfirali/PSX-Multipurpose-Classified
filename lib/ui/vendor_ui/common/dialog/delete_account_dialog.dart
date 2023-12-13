import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({
    this.onPressed,
  });

  final Function? onPressed;

  @override
  _DeleteAccountDialogState createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  TextEditingController deleteTextController = TextEditingController();
  bool wrongTyping = false;
  @override
  Widget build(BuildContext context) {
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.error_outline_outlined,
                color: PsColors.error500,
              ),
              const SizedBox(
                width: PsDimens.space12,
              ),
              Text(
                'delete_account_title'.tr,
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
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800
                  : PsColors.achromatic50,
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
                    margin: const EdgeInsets.only(top: PsDimens.space16),
                    child: Text(
                      'profile__deactivate_confirm_text'.tr,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Utils.isLightMode(context)
                              ? PsColors.text700 : PsColors.text50),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: PsDimens.space16),
                    child: Text(
                      'profile__deactivate_type_delete_msg'.tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Utils.isLightMode(context)
                              ? PsColors.text800 : PsColors.text50),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: PsDimens.space8),
                    decoration: BoxDecoration(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic50
                          : PsColors.achromatic900,
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                      border: Border.all(
                          color: wrongTyping
                              ? PsColors.error500
                              : PsColors.text400),
                    ),
                    height: PsDimens.space40,
                    child: TextField(
                        maxLines: 1,
                        controller: deleteTextController,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Input here',
                          hintStyle: TextStyle(
                              color: Utils.isLightMode(context)
                                  ? PsColors.text400
                                  : PsColors.achromatic500),
                          contentPadding: const EdgeInsets.only(
                              left: PsDimens.space12,
                              top: PsDimens.space4,
                              bottom: PsDimens.space4),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () {
                              deleteTextController.clear();
                              setState(() {
                                wrongTyping = false;
                              });
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Utils.isLightMode(context)
                                  ? PsColors.achromatic200
                                  : PsColors.achromatic500,
                            ),
                          ),
                        )),
                  ),
                  if (wrongTyping)
                    Container(
                      margin: const EdgeInsets.only(top: PsDimens.space8),
                      child: Text(
                        'profile__deactivate_try_again'.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: PsColors.error500),
                      ),
                    ),
                  const SizedBox(
                    height: PsDimens.space24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      PSButtonWidgetRoundCorner(
                          colorData: PsColors.achromatic100,
                          hasShadow: false,
                          width: 80,
                          height: 40,
                          titleText: 'dialog__cancel'.tr,
                          titleTextColor: PsColors.achromatic900,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(
                        width: 16,
                      ),
                      PSButtonWidgetRoundCorner(
                          colorData: Utils.isLightMode(context)
                              ? PsColors.primary500
                              : PsColors.primary300,
                          hasShadow: false,
                          width: 80,
                          height: 40,
                          titleText: 'message_delete'.tr,
                          onPressed: () {
                            if (deleteTextController.text.trim() == 'Delete') {
                              widget.onPressed!();
                            } else {
                              setState(() {
                                wrongTyping = true;
                              });
                            }
                          }),
                    ],
                  ),
                ]))));
  }
}
