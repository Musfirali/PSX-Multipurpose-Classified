import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/user/follow/component/following/following_user_list.dart';
import '../../../../common/ps_ui_widget.dart';

class FollowingUserListWidget extends StatefulWidget {
  const FollowingUserListWidget({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _FollowingUserListWidgetState createState() {
    return _FollowingUserListWidgetState();
  }
}

class _FollowingUserListWidgetState extends State<FollowingUserListWidget> {
  late PsValueHolder psValueHolder;
  UserRepository? userRepo;
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    final UserListProvider userListProvider =
        Provider.of<UserListProvider>(context);

    return Expanded(
      child: Stack(children: <Widget>[
        RefreshIndicator(
          child: userListProvider.hasData
              ? CustomFollowingUserList(
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
