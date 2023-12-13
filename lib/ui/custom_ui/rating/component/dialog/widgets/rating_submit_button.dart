import 'package:flutter/material.dart';

import '../../../../../vendor_ui/rating/component/dialog/widgets/rating_submit_button.dart';

class CustomRatingSubmitButton extends StatelessWidget {
  const CustomRatingSubmitButton(
      {Key? key,
      required this.titleController,
      required this.descriptionController,
      required this.rating,
      required this.buyerUserId,
      required this.sellerUserId})
      : super(key: key);

  final TextEditingController titleController, descriptionController;
  final double? rating;
  final String? buyerUserId;
  final String? sellerUserId;

  @override
  Widget build(BuildContext context) {
    return RatingSubmitButton(
        titleController: titleController,
        descriptionController: descriptionController,
        rating: rating,
        buyerUserId: buyerUserId,
        sellerUserId: sellerUserId);
  }
}
