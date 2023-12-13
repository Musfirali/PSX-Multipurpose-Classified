import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../../vendor_ui/user/profile/component/detail_info/widgets/rating_widget.dart';

class CustomRatingWidget extends StatelessWidget {
    const CustomRatingWidget({
    Key? key,
    required this.user,
    this.starCount,
  }) : super(key: key);

  final User? user;
  final int? starCount;
  
  @override
  Widget build(BuildContext context) {
    return RatingWidget(user: user,starCount: starCount,);
  }
}
