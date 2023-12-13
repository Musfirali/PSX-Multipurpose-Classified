import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/search_history.dart';

class SerachHistoryListItem extends StatefulWidget {
  const SerachHistoryListItem({
    Key? key,
    required this.history,
    this.animationController,
    this.animation,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final SearchHistory history;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  State<SerachHistoryListItem> createState() => _SerachHistoryListItemState();
}

class _SerachHistoryListItemState extends State<SerachHistoryListItem> {
  @override
  Widget build(BuildContext context) {
    final Widget _dividerWidget = Divider(
      height: PsDimens.space1,
      color: PsColors.achromatic500,
      //thickness: 0.2,
    );
    widget.animationController?.forward();
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
            // padding: const EdgeInsets.only(left: 8.0, right: 8),
            color: widget.isSelected
                ? Utils.isLightMode(context)
                    ? PsColors.primary50
                    : PsColors.text700
                : Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: PsDimens.space16,
                          top: PsDimens.space14,
                          bottom: PsDimens.space14,
                          right: PsDimens.space16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          if (widget.isSelected)
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(PsDimens.space4)),
                              child: Icon(
                                Icons.check,
                                color: PsColors.achromatic50,
                                size: PsDimens.space20,
                              ),
                            ),
                          Text(
                            widget.history.keyword ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text800 : PsColors.text200,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          // left: PsDimens.space14,
                          // top: PsDimens.space14,
                          // bottom: PsDimens.space14,
                          right: PsDimens.space14),
                      child: Text(
                        widget.history.addedDateStr ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: PsColors.text400,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                _dividerWidget
              ],
            ),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - widget.animation!.value), 0.0),
                  child: child));
        });
  }
}
