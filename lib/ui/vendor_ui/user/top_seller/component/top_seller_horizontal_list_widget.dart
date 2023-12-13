import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/top_seller_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/user.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/user/top_seller/component/widgets/topseller_list_item.dart';
import '../../../common/ps_list_header_widget.dart';

class TopSellerHorizontalListWidget extends StatelessWidget {
  const TopSellerHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return SliverToBoxAdapter(child: Consumer<TopSellerProvider>(
      builder: (BuildContext context, TopSellerProvider provider,
          Widget? child) {
            final bool isLoading =
        provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : provider.topSellerList.data!.length;
        return (provider.hasData ||
                provider.currentStatus == PsStatus.BLOCK_LOADING)
            ? Column(children: <Widget>[
                PsListHeaderWidget(
                  headerName: 'top_rated_sellers_title'.tr,
                  headerDescription: '',
                  viewAllClicked: () {
                    Navigator.pushNamed(context, RoutePaths.topSellerList,);
                  },
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                      shrinkWrap: false,
                      padding: const EdgeInsets.only(right: PsDimens.space8, left: PsDimens.space8),
                      scrollDirection: Axis.horizontal,
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomTopSellerListItem(
                          animation: curveAnimation(animationController!),
                          animationController: animationController,
                          user: isLoading
                              ? User()
                              : provider.topSellerList.data![index],
                          isLoading: isLoading,
                          width: MediaQuery.of(context).size.width / 4 * 2,
                        );
                      }),
                ),
              ])
            : const SizedBox();
      },
    ));
  }
}
