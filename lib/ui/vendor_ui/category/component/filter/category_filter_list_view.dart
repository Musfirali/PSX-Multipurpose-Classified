import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../custom_ui/category/component/filter/widgets/category_filter_list_data.dart';
import '../../../common/ps_ui_widget.dart';

class CategoryFilterListView extends StatelessWidget {
  const CategoryFilterListView(
      {required this.animationController, required this.animation, required this.selectedName});
  final AnimationController animationController;
  final Animation<double> animation;
  final String selectedName;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider provider = Provider.of<CategoryProvider>(context);
    return Stack(children: <Widget>[
      RefreshIndicator(
        child:
            provider.currentStatus == PsStatus.BLOCK_LOADING || provider.hasData
                ? CustomCategoryFilterListData(
                    animationController: animationController,
                    selectedName: selectedName,
                  )
                : const SizedBox(),
        onRefresh: () {
          return provider.loadDataList(reset: true);
        },
      ),
      PSProgressIndicator(provider.currentStatus)
    ]);
  }
}
