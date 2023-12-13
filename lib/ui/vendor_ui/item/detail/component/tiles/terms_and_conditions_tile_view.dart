import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../common/ps_expansion_tile.dart';
import '../../../../common/ps_html_text_widget.dart';

class TermsAndConditionTileView extends StatelessWidget {
  const TermsAndConditionTileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget _expansionTileTitleWidget =
        Text('setting__terms_and_condition'.tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.text800
                      : PsColors.text50,
                ));

    final Widget _expansionTileLeadingIconWidget = Icon(
      Icons.assignment_outlined, //FontAwesome.shield,
      color: Utils.isLightMode(context) ? PsColors.text800 : PsColors.text50,
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

    return Consumer<AboutUsProvider>(builder: (BuildContext context,
        AboutUsProvider aboutUsProvider, Widget? gchild) {
      return SliverToBoxAdapter(
          child: !aboutUsProvider.hasData
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(
                      left: PsDimens.space16,
                      right: PsDimens.space16,
                      top: PsDimens.space16),
                  child: PsExpansionTile(
                    initiallyExpanded: true,
                    decoration: BoxDecoration(
                      color: Utils.isLightMode(context)
                          ? PsColors.text50
                          : PsColors.achromatic700,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(PsDimens.space4)),
                    ),
                    title: _expanionTitleWithLeadingIconWidget,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: PsDimens.space18),
                            child: PsHTMLTextWidget(
                                htmlData: aboutUsProvider
                                        .aboutUs.data!.termsAndConditions ??
                                    '',
                                style: Style(
                                  margin: Margins.only(top: -7.0),
                                  maxLines: 2,
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(PsDimens.space12),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutePaths.termsAndCondition);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'safety_tips_tile__read_more_button'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 12, color: Utils.isLightMode(context)? PsColors.primary500 : PsColors.primary300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
    });
  }
}
