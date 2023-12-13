import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';

class OtherUserFollowerCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutePaths.detailfollowerUserList,
            arguments: userProvider.user.data!.userId,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Text(
                userProvider.user.data!.followerCount ?? '',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                    ),
                maxLines: 1,
              ),
              Text(
                'profile__follower'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                    ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
