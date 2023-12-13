import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/rating.dart';
import '../../../../vendor_ui/rating/component/list/rating_list_item.dart';

class CustomRatingListItem extends StatelessWidget {
  const CustomRatingListItem({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return RatingListItem(rating: rating);
  }
}
