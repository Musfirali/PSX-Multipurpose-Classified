import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../common/smooth_star_rating_widget.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    Key? key,
    required this.user,
    this.starCount,
  }) : super(key: key);

  final User? user;
  final int? starCount;
  @override
  Widget build(BuildContext context) {
    if (user!.overallRating != '0')
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (user!.overallRating != '')
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.ratingList,
                    arguments: user!.userId);
              },
              child: SmoothStarRating(
                  key: Key(user!.overallRating!),
                  rating: double.parse(user!.overallRating!),
                  allowHalfRating: false,
                  isReadOnly: true,
                  starCount: starCount ?? 1,
                  color: PsColors.warning500,
                  borderColor: PsColors.warning500,
                  onRated: (double? v) async {},
                  spacing: 0.0),
            ),
        ],
      );
    else
      return const SizedBox();
  }
}
