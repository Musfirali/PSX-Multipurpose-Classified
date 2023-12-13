import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/offer/offer_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/offer/component/widgets/sent/offer_sent_list_item.dart';

class OfferSentListData extends StatefulWidget {
  const OfferSentListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _OfferSentListDataView();

}

class _OfferSentListDataView extends State<OfferSentListData> {
  final ScrollController _scrollController = ScrollController();
  late OfferListProvider provider ;

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
    provider = Provider.of<OfferListProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: provider.offerList.data!.length,
      itemBuilder: (BuildContext context, int index) {
        final int count =
            provider.offerList.data!.length;
        
        return CustomOfferSentListItem(
          animationController:
              widget.animationController,
          animation: curveAnimation(widget.animationController, count: count, index: index),
          offer: provider.offerList.data![index],
        );
      },
    );
  }

}