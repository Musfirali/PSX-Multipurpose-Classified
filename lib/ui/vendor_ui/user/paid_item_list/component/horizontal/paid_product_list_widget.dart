import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/paid_id_item_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/paid_item_list/component/horizontal/widgets/paid_ad_item_horizontal_list_item.dart';
import '../../../../common/ps_list_header_widget.dart';

class PaidProductListWidget extends StatelessWidget {
  const PaidProductListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(child: Consumer<PaidAdItemProvider>(builder:
        (BuildContext context, PaidAdItemProvider productProvider,
            Widget? child) {
      return AnimatedBuilder(
          animation: animationController!,
          child: (productProvider.hasData)
              ? Column(children: <Widget>[
                  PsListHeaderWidget(
                    headerName: 'Promoted Items'.tr,
                    viewAllClicked: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.paidAdItemList,
                      );
                    },
                  ),
                  Container(
                      height: 360,
                      margin: const EdgeInsets.only(
                        left: PsDimens.space12,
                        top: PsDimens.space8
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              productProvider.paidAdItemList.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomPaidAdItemHorizontalListItem(
                              paidAdItem:
                                  productProvider.paidAdItemList.data![index],
                              tagKey: productProvider.hashCode.toString(),
                            );
                          }))
                ])
              : const SizedBox(),
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child));
          });
    }));
  }
}
