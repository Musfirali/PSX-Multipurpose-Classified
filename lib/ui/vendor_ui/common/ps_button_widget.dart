import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PSButtonWidget extends StatefulWidget {
  const PSButtonWidget(
      {this.onPressed,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.gradient,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;

  @override
  _PSButtonWidgetState createState() => _PSButtonWidgetState();
}

class _PSButtonWidgetState extends State<PSButtonWidget> {
  Color? _color;
  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _color ??= Theme.of(context).primaryColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: _color),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(PsDimens.space4))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: PsColors.primary900,
          child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: PsDimens.space8, right: PsDimens.space8),
              child: Text(widget.titleText,
                  textAlign: widget.titleTextAlign,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
                      fontSize: 14) //PsColors.achromatic50),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class PSButtonWithIconWidget extends StatefulWidget {
  const PSButtonWithIconWidget(
      {this.onPressed,
      this.titleText = '',
      this.colorData,
      this.width,
      this.height,
      this.gradient,
      this.icon,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false,
      this.iconColor,
      this.textColor});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final MainAxisAlignment iconAlignment;
  final bool hasShadow;
  final Color? iconColor;
  final Color? textColor;

  final double? height;

  @override
  _PSButtonWithIconWidgetState createState() => _PSButtonWithIconWidgetState();
}

class _PSButtonWithIconWidgetState extends State<PSButtonWithIconWidget> {
  Color? _color;
  Color? _iconColor;
  Color? _textColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;
    _textColor = widget.textColor;
    _iconColor ??= PsColors.achromatic50;
    _color ??= PsColors.primary500;
    _textColor ??= PsColors.achromatic50;

    return Container(
      width: widget.width, //MediaQuery.of(context).size.width,
      height: widget.height ?? 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: _color),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(PsDimens.space8))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: PsColors.primary900,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.iconAlignment,
            children: <Widget>[
              if (widget.icon != null) Icon(widget.icon, color: _iconColor),
              if (widget.icon != null && widget.titleText != '')
                const SizedBox(
                  width: PsDimens.space8,
                ),
              Flexible(
                child: Text(
                  widget.titleText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: _textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
