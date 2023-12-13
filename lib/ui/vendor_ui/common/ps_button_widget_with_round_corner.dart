import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PSButtonWidgetRoundCorner extends StatefulWidget {
  const PSButtonWidgetRoundCorner(
      {this.onPressed,
      this.titleText = '',
      this.titleTextColor,
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.height,
      this.gradient,
      this.hasBorder = false,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? titleTextColor;
  final Color? colorData;
  final double? width;
  final double? height;
  final bool hasBorder;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;

  @override
  _PSButtonWidgetRoundCornerState createState() =>
      _PSButtonWidgetRoundCornerState();
}

class _PSButtonWidgetRoundCornerState extends State<PSButtonWidgetRoundCorner> {
  Color? _color;
  Color? _titleTextColor;
  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _titleTextColor = widget.titleTextColor;

    _titleTextColor ??= Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800;

    _color ??= PsColors.primary500;

    return Container(
      width: widget.width,
      height: widget.height ?? 46,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            side: widget.hasBorder
                ? BorderSide(color: PsColors.achromatic500)
                : BorderSide.none,
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space4))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: PsColors.primary900,
          child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: PsDimens.space8, right: PsDimens.space8),
              child: Text(
                widget.titleText,
                textAlign: widget.titleTextAlign,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: _titleTextColor),
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
      this.gradient,
      this.icon,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false,
      this.iconColor});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final MainAxisAlignment iconAlignment;
  final bool hasShadow;
  final Color? iconColor;

  @override
  _PSButtonWithIconWidgetState createState() => _PSButtonWithIconWidgetState();
}

class _PSButtonWithIconWidgetState extends State<PSButtonWithIconWidget> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    _iconColor ??= Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800;

    _color ??= PsColors.primary500;

    return Container(
      width: widget.width, //MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: _color,
      ),
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
                  width: PsDimens.space12,
                ),
              Text(
                widget.titleText,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PSButtonWidgetWithIconRoundCorner extends StatefulWidget {
  const PSButtonWidgetWithIconRoundCorner(
      {this.onPressed,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.icon,
      this.gradient,
      this.iconColor,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;
  final MainAxisAlignment iconAlignment;
  final Color? iconColor;

  @override
  _PSButtonWidgetWithIconRoundCornerState createState() =>
      _PSButtonWidgetWithIconRoundCornerState();
}

class _PSButtonWidgetWithIconRoundCornerState
    extends State<PSButtonWidgetWithIconRoundCorner> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    _iconColor ??= PsColors.achromatic50;

    _color ??= PsColors.primary500;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: PsColors.text50),
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space8))),
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
                  width: PsDimens.space4,
                ),
              Text(
                widget.titleText.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.titleText == 'edit_profile__title'.tr ||
                            widget.titleText == 'Reset'.tr ||
                            widget.titleText == 'map_filter__reset'.tr
                        ? Theme.of(context).primaryColor //PsColors.primary500
                        : Utils.isLightMode(context) ? PsColors.text800: PsColors.text500 //PsColors.achromatic50
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PSButtonWidgetWithIconRoundCorner2 extends StatefulWidget {
  const PSButtonWidgetWithIconRoundCorner2(
      {this.onPressed,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.icon,
      this.gradient,
      this.iconColor,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;
  final MainAxisAlignment iconAlignment;
  final Color? iconColor;

  @override
  _PSButtonWidgetWithIconRoundCorner2State createState() =>
      _PSButtonWidgetWithIconRoundCorner2State();
}

class _PSButtonWidgetWithIconRoundCorner2State
    extends State<PSButtonWidgetWithIconRoundCorner2> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    _iconColor ??= PsColors.achromatic50;

    _color ??= PsColors.primary500;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: PsColors.text400),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        // shape: RoundedRectangleBorder(
        //     side: BorderSide(color: PsColors.secondary50),
        //     borderRadius:
        //         const BorderRadius.all(Radius.circular(PsDimens.space6))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: PsColors.primary900,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.titleText.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Utils.isLightMode(context) ? PsColors.text300: PsColors.text50,
                      fontWeight: FontWeight.normal //PsColors.achromatic50
                      ),
                ),
              ),
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(widget.icon, color: _iconColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
