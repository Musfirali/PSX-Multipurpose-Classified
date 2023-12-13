import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/holder/user_follow_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../custom_ui/user/follow/component/user_vertical_list_item.dart';
import '../../../../common/dialog/error_dialog.dart';

class FollowerUserList extends StatefulWidget {
  const FollowerUserList({required this.animationController});
  final AnimationController animationController;

  @override
  State<FollowerUserList> createState() => _FollowerUserListState();
}

class _FollowerUserListState extends State<FollowerUserList>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late UserListProvider provider;
  Animation<double>? animation;
  late AppLocalization langProvider;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    provider = Provider.of<UserListProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : provider.userList.data!.length;

    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: PsDimens.space8),
        shrinkWrap: false,
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return CustomUserVerticalListItem(
            isLoading: isLoading,
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            user: provider.getListIndexOf(index),
          );
        });
  }

  Future<void> onClick(BuildContext context, UserProvider userProvider,
      UserListProvider provider, int index) async {
    if (await Utils.checkInternetConnectivity()) {
      Utils.navigateOnUserVerificationView(context, () async {
        if (provider.getListIndexOf(index).isFollowed == PsConst.ZERO) {
          setState(() {
            provider.getListIndexOf(index).isFollowed = PsConst.ONE;
          });
        } else {
          setState(() {
            provider.getListIndexOf(index).isFollowed = PsConst.ZERO;
          });
        }

        final UserFollowHolder userFollowHolder = UserFollowHolder(
            userId: userProvider.psValueHolder!.loginUserId,
            followedUserId: provider.getListIndexOf(index).userId);

        final PsResource<User> _user = await userProvider.postUserFollow(
            userFollowHolder.toMap(),
            userProvider.psValueHolder!.loginUserId!,
            langProvider.currentLocale.languageCode);
        if (_user.data != null) {
          if (_user.data!.isFollowed == PsConst.ONE) {
            provider.getListIndexOf(index).isFollowed = PsConst.ONE;
          } else {
            provider.getListIndexOf(index).isFollowed = PsConst.ZERO;
          }
        }
      });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }
}
