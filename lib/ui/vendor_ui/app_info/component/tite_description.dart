import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/about_us/about_us_provider.dart';

class TitleAndDescriptionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AboutUsProvider provider = Provider.of<AboutUsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          provider.aboutUs.data!.aboutTitle ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: PsDimens.space16,
        ),
        Text(
          provider.aboutUs.data!.aboutDescription!,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(height: 1.7, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: PsDimens.space16,
        ),
      ],
    );
  }
}
