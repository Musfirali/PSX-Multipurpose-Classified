import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';

class FavoriteCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
            top: PsDimens.space10,
            left: PsDimens.space24,
            right: PsDimens.space24,
            bottom: PsDimens.space20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const Icon(
              Icons.favorite,
              size: 23,
            ),
            const SizedBox(
              width: PsDimens.space6,
            ),
            Text(
              '${itemDetailProvider.product.favouriteCount} ${'item_detail__like_count'.tr}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}
