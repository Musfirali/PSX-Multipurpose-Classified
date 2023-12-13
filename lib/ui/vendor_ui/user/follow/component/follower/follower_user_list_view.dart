import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/user/follow/component/follower/follower_user_list.dart';
import '../../../../common/ps_ui_widget.dart';

class FollowerUserListWidget extends StatefulWidget {
  const FollowerUserListWidget({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _FollowerUserListWidgetState createState() {
    return _FollowerUserListWidgetState();
  }
}

class _FollowerUserListWidgetState extends State<FollowerUserListWidget> {
  late UserListProvider userListProvider;

  late PsValueHolder psValueHolder;
  late UserProvider userProvider;
  UserRepository? userRepo;
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    psValueHolder = Provider.of<PsValueHolder>(context);
    userRepo = Provider.of<UserRepository>(context);
    userProvider = Provider.of<UserProvider>(context);
    userListProvider = Provider.of<UserListProvider>(context);

    // provider = UserProvider(repo: userRepo, psValueHolder: psValueHolder);

    return Expanded(
      child: Stack(children: <Widget>[
        RefreshIndicator(
          child: userListProvider.hasData
              ? CustomFollowerUserList(
                  animationController: widget.animationController!)
              : const SizedBox(),
          onRefresh: () async {
            userListProvider.followingUserParameterHolder.loginUserId =
                userListProvider.psValueHolder!.loginUserId;
            return userListProvider.loadDataList(reset: true);
          },
        ),
        PSProgressIndicator(userListProvider.currentStatus)
      ]),
    );
  }
}
