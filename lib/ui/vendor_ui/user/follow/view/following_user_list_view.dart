import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
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
import '../../../../custom_ui/user/follow/component/following/following_user_list_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class FollowingUserListView extends StatefulWidget {
  @override
  _FollowingUserListViewState createState() {
    return _FollowingUserListViewState();
  }
}

class _FollowingUserListViewState extends State<FollowingUserListView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  UserListProvider? _userListProvider;

  AnimationController? animationController;

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final String? loginUserId =
            Utils.checkUserLoginId(_userListProvider!.psValueHolder!);
        _userListProvider!.followingUserParameterHolder.loginUserId =
            loginUserId;
        _userListProvider!.loadNextDataList(
            requestBodyHolder: _userListProvider!.followingUserParameterHolder,
            requestPathHolder: RequestPathHolder(loginUserId: loginUserId));
      }
    });
  }

  UserRepository? userRepo;
  PsValueHolder? psValueHolder;

  late UserListProvider userListProvider;
  late UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
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
              userListProvider.followingUserParameterHolder.loginUserId =
                  loginUserId;
              userListProvider.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: loginUserId,
                    headerToken: psValueHolder!.headerToken!),
                requestBodyHolder:
                    userListProvider.followingUserParameterHolder,
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
                appBarTitle: 'profile__following'.tr,
              ),
              CustomFollowingUserListWidget(
                  animationController: animationController!)
            ],
          ),
        );
      }),
    );
  }
}
