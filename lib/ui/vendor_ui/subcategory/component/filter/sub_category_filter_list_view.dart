import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../custom_ui/subcategory/component/filter/widgets/sub_category_filter_data.dart';
import '../../../common/ps_ui_widget.dart';

class SubCategoryFilterListView extends StatelessWidget {
  const SubCategoryFilterListView(
      {required this.animationController, required this.selectedSubCatName});
  final AnimationController animationController;
  final String selectedSubCatName;

  @override
  Widget build(BuildContext context) {
    final SubCategoryProvider provider =
        Provider.of<SubCategoryProvider>(context);
    return Stack(children: <Widget>[
      Container(
          child: RefreshIndicator(
        child:
            provider.currentStatus == PsStatus.BLOCK_LOADING || provider.hasData
                ? CustomSubCategoryFilterData(
                    animationController: animationController,
                    selectedSubCatName: selectedSubCatName,
                  )
                : const SizedBox(),
        onRefresh: () {
          return provider.loadDataList(
            reset: true,
          );
        },
      )),
      PSProgressIndicator(provider.currentStatus)
    ]);
  }
}
