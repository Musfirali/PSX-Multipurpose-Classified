import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/all_search_intent_holder.dart';
import '../../../../../custom_ui/all_search/component/search_result/all_search_text_box_widget.dart';

class HomeSearchHeaderWidget extends StatefulWidget {
  const HomeSearchHeaderWidget({Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  __HomeSearchHeaderWidgetState createState() =>
      __HomeSearchHeaderWidgetState();
}

class __HomeSearchHeaderWidgetState extends State<HomeSearchHeaderWidget> {
  final TextEditingController textEditingController = TextEditingController();
  late PsValueHolder psValueHolder;
  late Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    animation = curveAnimation(widget.animationController!);
    return SliverToBoxAdapter(
        child: AnimatedBuilder(
            animation: widget.animationController!,
            child: Container(
              margin: const EdgeInsets.all(PsDimens.space16),
              child: CustomAllSearchTextBoxWidget(
                textEditingController: textEditingController,
                onClick: onClick,
                fromHomePage: true,
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: animation,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 30 * (1.0 - animation.value), 0.0),
                      child: child));
            }));
  }

  void onClick(String keyword, String dropdownKey, String dropdownValue) {
    Navigator.pushNamed(context, RoutePaths.allSearchResult,
        arguments: AllSearchIntentHolder(
            keyword: keyword,
            dropdownKey: dropdownKey,
            dropdownValue: dropdownValue));
  }
}
