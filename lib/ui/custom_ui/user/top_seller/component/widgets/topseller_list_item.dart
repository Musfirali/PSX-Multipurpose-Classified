import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../vendor_ui/user/top_seller/component/widgets/topseller_list_item.dart';

class CustomTopSellerListItem extends StatefulWidget {
  const CustomTopSellerListItem(
      {Key? key,
      required this.user,
      this.animation,
      this.animationController,
      this.isLoading = false,
      this.width})
      : super(key: key);

  final User user;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final double? width;

  @override
  State<CustomTopSellerListItem> createState() =>
      _UserVerticalListItemState();
}

class _UserVerticalListItemState extends State<CustomTopSellerListItem> {


  @override
  Widget build(BuildContext context) {
    return TopSellerListItem(
      user: widget.user,
      animation: widget.animation,
      animationController: widget.animationController,
      isLoading: widget.isLoading,
      width: widget.width,
    );
  }
}
