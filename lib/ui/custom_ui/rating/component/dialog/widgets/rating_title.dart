import 'package:flutter/material.dart';

import '../../../../../vendor_ui/rating/component/dialog/widgets/rating_title.dart';

class CustomRatingTitle extends StatelessWidget {
  const CustomRatingTitle({Key? key, this.isEdit = true}) : super(key: key);
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return RatingTitle(isEdit: isEdit);
  }
}
