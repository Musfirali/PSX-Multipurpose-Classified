import 'package:flutter/material.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';

class RatingStarWidget extends StatelessWidget {
  const RatingStarWidget({
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
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space4),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            starCount,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            width: PsDimens.space12,
          ),
          Expanded(
            flex: 5,
            child: LinearProgressIndicator(
              value: value,
            ),
          ),
          const SizedBox(
            width: PsDimens.space12,
          ),
          Container(
            width: PsDimens.space68,
            child: Text(
              percentage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}