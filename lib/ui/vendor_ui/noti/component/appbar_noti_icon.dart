import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/user_unread_message_parameter_holder.dart';

class AppbarNotiIcon extends StatefulWidget {
  @override
  State<AppbarNotiIcon> createState() =>
      _DashboardAppBarNotiListIconButtomState();
}

class _DashboardAppBarNotiListIconButtomState extends State<AppbarNotiIcon> {
  int notiCount = 0;
  late UserUnreadMessageParameterHolder userUnreadMessageHolder;

  @override
  Widget build(BuildContext context) {
    final UserUnreadMessageProvider userUnreadMessageProvider = 
        Provider.of(context, listen: false);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);

    return InkWell(
      onTap: () async {
        final dynamic result = await Navigator.pushNamed(
          context, RoutePaths.notiList);
        
        if (result != null) {
          userUnreadMessageHolder = UserUnreadMessageParameterHolder(
            userId: psValueHolder.loginUserId,
            deviceToken: psValueHolder.deviceToken);
          userUnreadMessageProvider.loadData(
            requestBodyHolder: userUnreadMessageHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: psValueHolder.loginUserId,
                headerToken: psValueHolder.headerToken,
                languageCode:
                    langProvider.currentLocale.languageCode));
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: PsDimens.space44,
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.notifications_none,
              ),
            ),
          ),
          Positioned(
              top: 10,
              right: 8,
              child: Consumer<UserUnreadMessageProvider>(builder:
                  (BuildContext context,
                      UserUnreadMessageProvider userUnreadMessageProvider,
                      Widget? child) {
                if (userUnreadMessageProvider.userUnreadMessage.data != null) {
                  notiCount = int.parse(userUnreadMessageProvider
                      .userUnreadMessage.data!.notiUnreadCount!);

                  if (Utils.isLoginUserEmpty(psValueHolder) || notiCount == 0) {
                    return const SizedBox();
                  } else {
                    return Container(
                      width: PsDimens.space18,
                      height: PsDimens.space18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor, //PsColors.primary500,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          notiCount > 9 ? '9+' : notiCount.toString(),
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
                          maxLines: 1,
                        ),
                      ),
                    );
                  }
                } else {
                  return const SizedBox();
                }
              })),
        ],
      ),
    );
  }
}
