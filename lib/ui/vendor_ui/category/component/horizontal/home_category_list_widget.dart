import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../custom_ui/category/component/horizontal/widgets/category_horizontal_list.dart';
import '../../../common/ps_list_header_widget.dart';

class HomeCategoryHorizontalListWidget extends StatelessWidget {
  const HomeCategoryHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(child: Consumer<CategoryProvider>(
      builder: (BuildContext context, CategoryProvider categoryProvider,
          Widget? child) {
        return AnimatedBuilder(
            animation: animationController!,
            child: (categoryProvider.hasData ||
                    categoryProvider.currentStatus == PsStatus.BLOCK_LOADING)
                ? Column(children: <Widget>[
                    PsListHeaderWidget(
                      headerName: 'dashboard__category_looking_for'.tr,
                      headerDescription: '',
                      viewAllClicked: () {
                        Navigator.pushNamed(context, RoutePaths.categoryList,
                            arguments: '');
                      },
                    ),
                    CustomCategoryHorizontalList(),
                  ])
                : const SizedBox(),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: animation,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 30 * (1.0 - animation.value), 0.0),
                      child: child));
            });
      },
    ));
  }
}
