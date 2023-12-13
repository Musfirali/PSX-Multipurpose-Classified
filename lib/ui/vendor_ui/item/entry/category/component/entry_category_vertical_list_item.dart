import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/intent_holder/item_entry_intent_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/product.dart';
import 'package:psxmpc/ui/vendor_ui/common/ps_ui_widget.dart';
import 'package:psxmpc/ui/vendor_ui/common/shimmer_item.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/category.dart';

class EntryCategoryVerticalListItem extends StatefulWidget {
  const EntryCategoryVerticalListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false,
      required this.currentIndex,
      this.onItemUploaded,
      this.isFromChat})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final int currentIndex;
  final Function? onItemUploaded;
  final bool? isFromChat;

  @override
  _EntryCategoryVerticalListItemState createState() =>
      _EntryCategoryVerticalListItemState();
}

class _EntryCategoryVerticalListItemState extends State<EntryCategoryVerticalListItem> {
  int? selectedIndex;
  bool bindSelectedData = true;

  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();
    return AnimatedBuilder(
        animation: widget.animationController!,
        child: Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space16, 
              left: PsDimens.space6,
              right: PsDimens.space6),
          child: widget.isLoading
              ? const ShimmerItem()
              : GestureDetector(
                  onTap: () async {
                    setState(() {
                        selectedIndex = widget.currentIndex;
                      });

                     final dynamic result = await Navigator.pushNamed(context, RoutePaths.itemEntry,
                        arguments: ItemEntryIntentHolder(
                            flag: PsConst.ADD_NEW_ITEM, 
                            item: Product(),
                            categoryId: widget.category.catId,
                            categoryName: widget.category.catName,
                            isFromChat: widget.isFromChat) 
                    );
                    if(result == true) {
                      if (widget.onItemUploaded != null) {
                        widget.onItemUploaded!();
                      } 
                    } else if (result == false) {
                      setState(() {
                        bindSelectedData = false;
                      });
                    }
                  },
                  child: Ink(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Utils.isLightMode(context) 
                            ? PsColors.text50
                            : PsColors.achromatic700,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: (selectedIndex != null && 
                              bindSelectedData && 
                              selectedIndex == widget.currentIndex)
                            ? PsColors.error500
                            : Utils.isLightMode(context) 
                                ? PsColors.text50
                                : PsColors.achromatic700),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //cat image
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(PsDimens.space24),
                            child: Container(
                              width: PsDimens.space44,
                              height: PsDimens.space44,
                              color: Utils.isLightMode(context)
                                  ? Colors.white
                                  : PsColors.achromatic200,
                              padding: const EdgeInsets.all(PsDimens.space10),
                              child: PsNetworkIcon(
                                imageAspectRation: PsConst.Aspect_Ratio_1x,
                                photoKey: '',
                                defaultIcon: widget.category.defaultIcon,
                                boxfit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: PsDimens.space8,
                          ),
                          //cat name
                          Flexible(
                            child: Text(
                              widget.category.catName!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text600
                                          : Utils.isLightMode(context) ? PsColors.text300: PsColors.text50,
                                      fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.animation!,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - widget.animation!.value), 0.0),
                child: child),
          );
        });
  }
}
