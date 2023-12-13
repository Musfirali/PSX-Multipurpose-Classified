import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/follow/component/following/other_user_following_list.dart';
import '../../../common/base/ps_widget_with_appbar_with_two_provider.dart';
import '../../../common/ps_ui_widget.dart';

class OtherUserFollowingListView extends StatefulWidget {
  const OtherUserFollowingListView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _DetailFollowingUserListViewState createState() {
    return _DetailFollowingUserListViewState();
  }
}

class _DetailFollowingUserListViewState
    extends State<OtherUserFollowingListView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late UserListProvider _userListProvider;

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
            Utils.checkUserLoginId(_userListProvider.psValueHolder!);
        _userListProvider.followingUserParameterHolder.loginUserId =
            loginUserId;
        _userListProvider.loadNextDataList();
      }
    });
  }

  UserRepository? repo1;
  PsValueHolder? psValueHolder;
  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    timeDilation = 1.0;
    repo1 = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child:
            PsWidgetWithAppBarWithTwoProvider<UserListProvider, UserProvider>(
          appBarTitle: 'following__title'.tr,
          initProvider1: () {
            _userListProvider =
                UserListProvider(repo: repo1, psValueHolder: psValueHolder);
            return _userListProvider;
          },
          onProviderReady1: (UserListProvider? provider) {
            // final String? loginUserId =
            //     Utils.checkUserLoginId(provider.psValueHolder!);
            provider?.followingUserParameterHolder.loginUserId = widget.userId;
            provider?.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: Utils.checkUserLoginId(psValueHolder),
                    headerToken: psValueHolder!.headerToken!),
                requestBodyHolder: provider.followingUserParameterHolder);
          },
          initProvider2: () {
            return UserProvider(repo: repo1, psValueHolder: psValueHolder);
          },
          onProviderReady2: (UserProvider? userProvider) {},
          child: Consumer<UserListProvider>(builder:
              (BuildContext context, UserListProvider provider, Widget? child) {
            return Stack(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(
                      top: PsDimens.space8, bottom: PsDimens.space8),
                  child: RefreshIndicator(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          slivers: <Widget>[
                            if (provider.hasData)
                              CustomOtherUserFollowingList(
                                  animationController: animationController!),
                          ]),
                    ),
                    onRefresh: () async {
                      provider.followingUserParameterHolder.loginUserId =
                          provider.psValueHolder!.loginUserId;
                      return _userListProvider.loadDataList(reset: true);
                    },
                  )),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
        ));
  }
}
