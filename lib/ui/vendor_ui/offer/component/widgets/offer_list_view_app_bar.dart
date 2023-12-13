import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';

class OfferListViewAppBar extends StatefulWidget {
  const OfferListViewAppBar(
      {this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      required this.items,
      required this.onItemSelected})
      : assert(items.length >= 2 && items.length <= 5);

  @override
  _OfferListViewAppBarState createState() {
    return _OfferListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<OfferListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
}

class _OfferListViewAppBarState extends State<OfferListViewAppBar> {
  _OfferListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<OfferListViewAppBarItem> items;
  int? selectedIndexNo;

  ValueChanged<int> onItemSelected;

  Widget _buildItem(OfferListViewAppBarItem item, bool isSelected) {
    return AnimatedContainer(
      // width: PsDimens.space160,
      // height: double.maxFinite,
      // duration: const Duration(milliseconds: 200),
      // margin: const EdgeInsets.only(right: PsDimens.space12),
      width: MediaQuery.of(context).size.width / 2,
      height: double.maxFinite,
      duration: const Duration(milliseconds: 200),
      // decoration: BoxDecoration(
      //   color: isSelected
      //       ? item.activeBackgroundColor
      //       : item.inactiveBackgroundColor,
      //   borderRadius: const BorderRadius.all(Radius.circular(50)),
      // ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Icon(Icons.message, //MaterialCommunityIcons.message_text_outline,
              //     color: isSelected ? item.mainColor : item.inmainColor),
              // const SizedBox(
              //   width: PsDimens.space8,
              // ),
              Text(
                item.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isSelected ? item.mainColor : item.inmainColor),
              ),
            ],
          ),
          const SizedBox(
            height: PsDimens.space16,
          ),
          if (isSelected)
            Divider(
              color: Theme.of(context).primaryColor,
              height: 1,
              thickness: 1.5,
            )
          else
            Divider(
              height: PsDimens.space1,
              color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text50,
              thickness: 0.2,
            )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedIndexNo = widget.selectedIndex;
    return Container(
        margin: const EdgeInsets.only(
          top: PsDimens.space16,
        ),
        width: double.infinity,
        height: 46,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              final OfferListViewAppBarItem item = items[index];
              return InkWell(
                onTap: () {
                  onItemSelected(index);
                  setState(() {
                    selectedIndexNo = index;
                  });
                },
                child: _buildItem(item, selectedIndexNo == index),
              );
            }));
  }
}

class OfferListViewAppBarItem {
  OfferListViewAppBarItem(
      {required this.title,
      Color? mainColor,
      Color? activeBackgroundColor,
      Color? inmainColor,
      Color? inactiveBackgroundColor})
      : mainColor = mainColor ?? PsColors.primary500,
        activeBackgroundColor = activeBackgroundColor ?? PsColors.primary50,
        inmainColor = inmainColor ?? PsColors.achromatic500,
        inactiveBackgroundColor =
            inactiveBackgroundColor ?? PsColors.achromatic500.withOpacity(0.2);

  final String title;
  final Color? mainColor;
  final Color? activeBackgroundColor;
  final Color? inmainColor;
  final Color inactiveBackgroundColor;
}
