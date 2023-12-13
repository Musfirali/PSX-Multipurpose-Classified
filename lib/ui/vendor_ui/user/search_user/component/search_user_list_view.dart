import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/user/search_user_provider.dart';
import '../../../../custom_ui/user/search_user/component/search_user_list.dart';
import '../../../common/ps_ui_widget.dart';

class UserSearchListView extends StatelessWidget {
  const UserSearchListView(
      {required this.animationController, required this.animation});
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final SearchUserProvider provider =
        Provider.of<SearchUserProvider>(context);
    return Expanded(
      child: Stack(children: <Widget>[
        RefreshIndicator(
          child: provider.currentStatus == PsStatus.BLOCK_LOADING ||
                  provider.hasData
              ? CustomSearchUserListData(
                  animationController: animationController,
                )
              : const SizedBox(),
          onRefresh: () {
            return provider.loadDataList(reset: true);
          },
        ),
        PSProgressIndicator(provider.currentStatus)
      ]),
    );
  }
}
