import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../common/ps_ui_widget.dart';

class HistoryListItem extends StatefulWidget {
  const HistoryListItem({
    Key? key,
    required this.product,
    required this.animationController,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final Product product;
  final AnimationController? animationController;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  State<HistoryListItem> createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        curveAnimation(widget.animationController!);
    final Widget _dividerWidget = Divider(
      height: PsDimens.space2,
      color: PsColors.achromatic500,
    );
    widget.animationController!.forward();
    return AnimatedBuilder(
        animation: widget.animationController!,
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          onLongPress: () {
            setState(() {
              widget.onLongPress();
            });
          },
          child: Container(
            color: widget.isSelected
                ? Utils.isLightMode(context)
                    ? PsColors.primary50
                    : PsColors.text700
                : Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Ink(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: PsDimens.space80,
                        height: PsDimens.space80,
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: PsNetworkCircleImage(
                                  photoKey: '',
                                  imagePath:
                                      widget.product.defaultPhoto!.imgPath ??
                                          '',
                                  width: PsDimens.space60,
                                  height: PsDimens.space60,
                                  boxfit: BoxFit.cover,
                                  onTap: () {},
                                )),
                            if (widget.isSelected)
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.circular(PsDimens.space4)),
                                child: Icon(
                                  Icons.check,
                                  color: PsColors.achromatic50,
                                  size: PsDimens.space20,
                                ),
                              )
                            else
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10000.0),
                                  child: PsNetworkCircleImageForUser(
                                    photoKey: '',
                                    imagePath:
                                        widget.product.user!.userPhone ?? '',
                                    width: PsDimens.space20,
                                    height: PsDimens.space20,
                                    boxfit: BoxFit.cover,
                                    onTap: () {},
                                  ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: PsDimens.space8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: PsDimens.space2),
                              child: Text(
                                widget.product.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 17),
                              ),
                            ),
                            Text(
                              widget.product.category!.catName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50,
                                      fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: PsDimens.space8, right: PsDimens.space16),
                        child: Text(
                          widget.product.addedDateStr!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Utils.isLightMode(context) ? PsColors.text300: PsColors.text50),
                        ),
                      ),
                    ],
                  ),
                ),
                _dividerWidget
              ],
            ),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation.value), 0.0),
                  child: child));
        });
  }
}
