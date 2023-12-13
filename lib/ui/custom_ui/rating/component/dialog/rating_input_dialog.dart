import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/rating.dart';
import '../../../../vendor_ui/rating/component/dialog/rating_input_dialog.dart';

class CustomRatingInputDialog extends StatefulWidget {
  const CustomRatingInputDialog(
      {Key? key,
      required this.buyerUserId,
      required this.sellerUserId,
      this.rating,
      this.isEdit = true})
      : super(key: key);

  final String? buyerUserId;
  final String? sellerUserId;
  final Rating? rating;
  final bool isEdit;

  @override
  _RatingInputDialogState createState() => _RatingInputDialogState();
}

class _RatingInputDialogState extends State<CustomRatingInputDialog> {
  @override
  Widget build(BuildContext context) {
    return RatingInputDialog(
        buyerUserId: widget.buyerUserId,
        sellerUserId: widget.sellerUserId,
        rating: widget.rating,
        isEdit: widget.isEdit);
  }
}
