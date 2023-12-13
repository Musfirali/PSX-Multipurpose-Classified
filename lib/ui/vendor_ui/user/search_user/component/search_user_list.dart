import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/provider/user/search_user_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../custom_ui/user/follow/component/user_vertical_list_item.dart';

class SearchUserListData extends StatefulWidget {
  const SearchUserListData({required this.animationController});
  final AnimationController animationController;

  @override
  State<SearchUserListData> createState() => _SearchUserListDataState();
}

class _SearchUserListDataState extends State<SearchUserListData>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late SearchUserProvider provider;
  Animation<double>? animation;

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
    provider = Provider.of<SearchUserProvider>(context);

    final int count = provider.dataLength;
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: false,
        itemCount: count,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return CustomUserVerticalListItem(
              animationController: widget.animationController,
              animation: curveAnimation(widget.animationController,
                  count: count, index: index),
              user: provider.getListIndexOf(index),);
        });
  }
}
