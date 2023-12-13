import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';

class VersionUpdateDialog extends StatefulWidget {
  const VersionUpdateDialog(
      {Key? key,
      this.title,
      this.description,
      this.leftButtonText,
      this.rightButtonText,
      this.onCancelTap,
      this.onUpdateTap})
      : super(key: key);
  @override
  _VersionUpdateDialogState createState() => _VersionUpdateDialogState();
  final String? title, description, leftButtonText, rightButtonText;
  final Function? onCancelTap;
  final Function? onUpdateTap;
}

class _VersionUpdateDialogState extends State<VersionUpdateDialog> {
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

  final VersionUpdateDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.update,
              ),
              const SizedBox(
                width: PsDimens.space12,
              ),
              Text(
                widget.title ?? '',
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
        // InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(
        //       Icons.close,
        //       color: Utils.isLightMode(context)
        //           ? PsColors.secondary800
        //           : PsColors.primaryDarkWhite,
        //     ))
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: PsColors.achromatic100,
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                    ),
                    alignment: Alignment.center,
                    height: 40,
                    width: 80,
                    child: Text(
                      widget.leftButtonText!,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: PsColors.achromatic900, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onCancelTap!();
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                    ),
                    alignment: Alignment.center,
                    height: 40,
                    width: 80,
                    child: Text(
                      widget.rightButtonText!,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: PsColors.text50,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onUpdateTap!();
                  },
                ),
                // PSButtonWidgetRoundCorner(
                //     colorData: PsColors.buttonColor,
                //     hasShadow: false,
                //     width: 80,
                //     height: 40,
                //     titleText: widget.rightButtonText!,
                //     titleTextColor: PsColors.achromatic50,
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //       widget.onUpdateTap!();
                //     }),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
