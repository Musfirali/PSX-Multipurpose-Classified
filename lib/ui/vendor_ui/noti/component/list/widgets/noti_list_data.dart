import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/noti/noti_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/noti/component/list/widgets/noti_list_item.dart';

class NotiListData extends StatefulWidget {
  const NotiListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _NotiListDataState();
}

class _NotiListDataState extends State<NotiListData> {
  final ScrollController _scrollController = ScrollController();
  late NotiProvider provider;

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
    provider = Provider.of<NotiProvider>(context);
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: provider.notiList.data!.length,
        itemBuilder: (BuildContext context, int index) {
          final int count = provider.notiList.data!.length;
          return CustomNotiListItem(
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            noti: provider.notiList.data![index],
          );
        });
  }
}
