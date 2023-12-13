import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/offer.dart';
import '../../../../../vendor_ui/offer/component/widgets/received/offer_received_list_item.dart';

class CustomOfferReceivedListItem extends StatelessWidget {
  const CustomOfferReceivedListItem({
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
    return OfferReceivedListItem(
      offer: offer,
      animation: animation,
      animationController: animationController,
    );
  }
}
