import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/item_list_intent_holder.dart';

class OwnerItemCountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutePaths.userItemList,
              arguments: ItemListIntentHolder(
                  userId: Utils.checkUserLoginId(psValueHolder),
                  status: '1',
                  title: 'profile__listing'.tr));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Text(
                userProvider.user.data!.activeItemCount!,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
                maxLines: 1,
              ),
              Text(
                'profile__listing'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
