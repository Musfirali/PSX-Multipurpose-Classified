import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/follow/component/follower/other_user_follower_list.dart';
import '../../../common/base/ps_widget_with_appbar_with_two_provider.dart';
import '../../../common/ps_ui_widget.dart';

class OtherUserFollowerListView extends StatefulWidget {
  const OtherUserFollowerListView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _DetailFollowerUserListViewState createState() {
    return _DetailFollowerUserListViewState();
  }
}

class _DetailFollowerUserListViewState extends State<OtherUserFollowerListView>
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
        _userListProvider.followerUserParameterHolder.loginUserId = loginUserId;
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
          appBarTitle: 'follower__title'.tr,
          initProvider1: () {
            _userListProvider =
                UserListProvider(repo: repo1, psValueHolder: psValueHolder);
            return _userListProvider;
          },
          onProviderReady1: (UserListProvider? provider) async {
            provider?.followerUserParameterHolder.loginUserId = widget.userId;
            await provider?.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: Utils.checkUserLoginId(psValueHolder),
                    headerToken: psValueHolder!.headerToken),
                requestBodyHolder: provider.followerUserParameterHolder);
          },
          initProvider2: () {
            return UserProvider(repo: repo1, psValueHolder: psValueHolder);
          },
          onProviderReady2: (UserProvider? userProvider) {},
          child: Consumer<UserListProvider>(builder:
              (BuildContext context, UserListProvider provider, Widget? child) {
            return Stack(children: <Widget>[
              RefreshIndicator(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      slivers: <Widget>[
                        if (provider.hasData)
                          CustomOtherUserFollowerList(
                              animationController: animationController!)
                      ]),
                ),
                onRefresh: () async {
                  provider.followerUserParameterHolder.loginUserId =
                      provider.psValueHolder!.loginUserId;
                  return _userListProvider.loadDataList(reset: true);
                },
              ),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
        ));
  }
}
