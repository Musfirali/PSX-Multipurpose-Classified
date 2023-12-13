import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/ps_expansion_tile.dart';

class StatisticTileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final Widget _expansionTileTitleWidget = Text('statistic_tile__title'.tr,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.text800 : PsColors.text50,
            ));

    final Widget _expansionTileLeadingIconWidget = Icon(
      Icons.trending_up, //Foundation.graph_bar,
      color: Utils.isLightMode(context)
          ? PsColors.text800 : PsColors.text50,
    );
    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space16,
    );

    final Widget _verticalLineWidget = Container(
      color: Theme.of(context).dividerColor,
      width: PsDimens.space1,
      height: PsDimens.space36,
    );

    final Widget _expanionTitleWithLeadingIconWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _expansionTileLeadingIconWidget,
        const SizedBox(
          width: PsDimens.space4,
        ),
        _expansionTileTitleWidget
      ],
    );

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            right: PsDimens.space16,
            top: PsDimens.space16),
        child: PsExpansionTile(
          initiallyExpanded: true,
          title: _expanionTitleWithLeadingIconWidget,
          decoration: BoxDecoration(
            color: Utils.isLightMode(context) ? PsColors.text50
              : PsColors.achromatic700,
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space4)),
          ),
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: PsDimens.space4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _IconAndTextWidget(
                        icon: Icons
                            .visibility_outlined, //SimpleLineIcons.eyeglass,
                        title: '${provider.product.touchCount} ',
                        title2: '${'statistic_tile__views'.tr}',
                        textType: 0),
                    _verticalLineWidget,
                    _IconAndTextWidget(
                        icon: Icons.favorite_border,
                        title: '${provider.product.favouriteCount} ',
                        title2: '${'item_detail__like_count'.tr}',
                        textType: 3),
                  ],
                ),
                _spacingWidget
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _IconAndTextWidget extends StatelessWidget {
  const _IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.title2,
    required this.textType,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String title2;
  final int textType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
          ),
        ),
        const SizedBox(
          height: PsDimens.space4,
        ),
        Row(
          children: <Widget>[
            Icon(
              icon,
              size: PsDimens.space20,
              color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
            ),
            const SizedBox(width: PsDimens.space6),
            Text(
              title2,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
