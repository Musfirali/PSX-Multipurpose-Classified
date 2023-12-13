import 'package:flutter/material.dart';

import '../../../../vendor_ui/rating/component/list/rating_star_widget.dart';

class CustomRatingStarWidget extends StatelessWidget {
  const CustomRatingStarWidget({
    Key? key,
    required this.starCount,
    required this.value,
    required this.percentage,
  }) : super(key: key);

  final String starCount;
  final double value;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return RatingStarWidget(
        starCount: starCount, value: value, percentage: percentage);
  }
}
