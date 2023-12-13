import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class ItemListEmptyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space100),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 260,
              height: 200,
              child: SvgPicture.asset(
                'assets/images/item_list_empty.svg',
              ),
            ),
            const SizedBox(
              height: PsDimens.space32,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: PsDimens.space20, right: PsDimens.space20),
              child: Text(
                'No Results Found', //'procuct_list__no_result_data'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
            ),
            const SizedBox(
              height: PsDimens.space8,
            ),
            Text(
              'We could not find what you are looking for.'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              'Try searching again.'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: PsDimens.space20,
            ),
          ],
        ),
      ),
    );
  }
}
