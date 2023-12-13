import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsListHeaderWidget extends StatelessWidget {
  const PsListHeaderWidget(
      {Key? key,
      required this.headerName,
      this.headerDescription = '',
      this.viewAllClicked,
      this.showViewAll = true,
      this.useSliver = false})
      : super(key: key);

  final String headerName;
  final String? headerDescription;
  final Function? viewAllClicked;
  final bool showViewAll;
  final bool useSliver;

  @override
  Widget build(BuildContext context) {
    if (useSliver)
      return SliverToBoxAdapter(
          child: _ListHeaderWidget(
              headerName: headerName,
              headerDescription: headerDescription,
              viewAllClicked: viewAllClicked ?? () {},
              showViewAll: showViewAll));
    else
      return _ListHeaderWidget(
          headerName: headerName,
          headerDescription: headerDescription,
          viewAllClicked: viewAllClicked ?? () {},
          showViewAll: showViewAll);
  }
}

class _ListHeaderWidget extends StatelessWidget {
  const _ListHeaderWidget({
    Key? key,
    required this.headerName,
    this.headerDescription = '',
    required this.viewAllClicked,
    this.showViewAll = true,
  }) : super(key: key);

  final String headerName;
  final String? headerDescription;
  final Function viewAllClicked;
  final bool showViewAll;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewAllClicked as void Function()?,
      child: Container(
        margin: const EdgeInsets.all(PsDimens.space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(headerName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18,
                          color: Utils.isLightMode(context)
                              ? PsColors.text800 : PsColors.text50,
                          fontWeight: FontWeight.w600)),
                ),
                Visibility(
                  visible: showViewAll,
                  child: Text(
                    'dashboard__view_all'.tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            if (headerDescription != '')
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: PsDimens.space10),
                      child: Text(
                        headerDescription!,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Utils.isLightMode(context)
                                ? PsColors.text300
                                : PsColors.text900),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
