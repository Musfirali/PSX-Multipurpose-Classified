import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/ui/vendor_ui/common/smooth_star_rating_widget.dart';

import '../../../config/route/route_paths.dart';
import '../../../core/vendor/utils/utils.dart';
import '../../../core/vendor/viewobject/user.dart';

class UserRatingWidget extends StatelessWidget {
  const UserRatingWidget({
    Key? key,
    required this.user,
    this.starCount,
    this.size,
    this.showRatingCount,
  }) : super(key: key);

  final User? user;
  final int? starCount;
  final double? size;
  final bool? showRatingCount;
  @override
  Widget build(BuildContext context) {
    final String? rating =
        user!.overallRating != '' ? user!.overallRating : '0';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (showRatingCount != false)
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Text(
            rating ?? '0',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic600 : PsColors.text50,
                fontSize: 14),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.ratingList,
                arguments: user!.userId);
          },
          child: SmoothStarRating(
              key: Key(rating ?? '0'),
              rating: double.parse(rating ?? '0'),
              allowHalfRating: false,
              isReadOnly: true,
              size: size ?? 25,
              starCount: starCount ?? 1,
              color: PsColors.warning500,
              borderColor: PsColors.warning500,
              onRated: (double? v) async {},
              spacing: 0.0),
        ),
      ],
    );
  }
}
