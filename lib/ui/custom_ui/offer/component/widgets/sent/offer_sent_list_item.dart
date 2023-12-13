import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/offer.dart';
import '../../../../../vendor_ui/offer/component/widgets/sent/offer_sent_list_item.dart';

class CustomOfferSentListItem extends StatelessWidget {
  const CustomOfferSentListItem({
    Key? key,
    required this.offer,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final Offer offer;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return OfferSentListItem(
      offer: offer,
      animation: animation,
      animationController: animationController,
    );
  }
}
