import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/dialog/filter_dialog.dart';

class CategorySortWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryProvider _categoryProvider =
        Provider.of<CategoryProvider>(context);
    //final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(
          width: PsDimens.space1,
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: PsDimens.space20, left: PsDimens.space20, top: PsDimens.space16),
          child: InkWell(
            onTap: () {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterDialog(
                      onAscendingTap: () async {
                        _categoryProvider.categoryParameterHolder.orderBy =
                            PsConst.FILTERING_SUBCAT_NAME;
                        _categoryProvider.categoryParameterHolder.orderType =
                            PsConst.FILTERING__ASC;
                        _categoryProvider.loadDataList(reset: true);
                      },
                      onDescendingTap: () {
                        _categoryProvider.categoryParameterHolder.orderBy =
                            PsConst.FILTERING_SUBCAT_NAME;
                        _categoryProvider.categoryParameterHolder.orderType =
                            PsConst.FILTERING__DESC;
                        _categoryProvider.loadDataList(reset: true);
                      },
                    );
                  });
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.sort_by_alpha_outlined,
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50,
                  size: 24,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text('Sort'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 16,
                          )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
