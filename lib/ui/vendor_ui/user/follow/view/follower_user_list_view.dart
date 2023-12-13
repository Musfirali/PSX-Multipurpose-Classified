import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/follow/component/follower/follower_user_list_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class FollowerUserListView extends StatefulWidget {
  @override
  _FollowerUserListViewState createState() {
    return _FollowerUserListViewState();
  }
}

class _FollowerUserListViewState extends State<FollowerUserListView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController);
    super.initState();
  }

  late UserListProvider userListProvider;
  late UserProvider userProvider;

  UserRepository? userRepo;
  PsValueHolder? psValueHolder;

  @override
  Widget build(BuildContext context) {
    userRepo = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider?>(
            lazy: false,
            create: (BuildContext context) {
              userProvider =
                  UserProvider(repo: userRepo, psValueHolder: psValueHolder);
              return userProvider;
            }),
        ChangeNotifierProvider<UserListProvider?>(
            lazy: false,
            create: (BuildContext context) {
              final String? loginUserId = Utils.checkUserLoginId(psValueHolder);
              userListProvider = UserListProvider(
                  repo: userRepo, psValueHolder: psValueHolder);
              userListProvider.followerUserParameterHolder.loginUserId =
                  userListProvider.followerUserParameterHolder.loginUserId =
                      loginUserId;
              userListProvider.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: loginUserId,
                    headerToken: psValueHolder!.headerToken!),
                requestBodyHolder: userListProvider.followerUserParameterHolder,
              );

              return userListProvider;
            }),
      ],
      child: Consumer2<UserProvider, UserListProvider>(builder:
          (BuildContext context, UserProvider userProvider,
              UserListProvider provider, Widget? child) {
        /**
               * UI SECTION
               */
        return Scaffold(
          body: Column(
            children: <Widget>[
              PsAppbarWidget(
                appBarTitle: 'profile__follower'.tr,
              ),
              CustomFollowerUserListWidget(
                  animationController: animationController)
            ],
          ),
        );
      }),
    );
  }
}
