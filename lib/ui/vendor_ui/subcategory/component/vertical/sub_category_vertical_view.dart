import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/category.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../custom_ui/subcategory/component/vertical/widgets/sub_category_empty_box.dart';
import '../../../../custom_ui/subcategory/component/vertical/widgets/sub_category_vertical_data.dart';
import '../../../common/ps_ui_widget.dart';

class SubCategoryVerticalView extends StatefulWidget {
  const SubCategoryVerticalView({required this.category});
  final Category category;
  @override
  _SubCategoryVerticalViewState createState() =>
      _SubCategoryVerticalViewState();
}

class _SubCategoryVerticalViewState extends State<SubCategoryVerticalView>
    with SingleTickerProviderStateMixin {
  late SubCategoryProvider provider;
  late PsValueHolder valueHolder;
  final ScrollController _scrollController = ScrollController();
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final String? categId = widget.category.catId;
        Utils.psPrint('CategoryId number is $categId');

        provider.loadNextDataList();
      }
    });
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  void addAlreadySubscribedDataToTemp(SubCategory subCategory) {
    if (subCategory.isSubscribe != null &&
        subCategory.isSubscribe == PsConst.ONE &&
        !provider.tempList.contains(subCategory.id) &&
        provider.needToAddToTempList) {
      provider.tempList.add(subCategory.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SubCategoryProvider>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    return Expanded(
      child: Stack(children: <Widget>[
        Container(
            margin: const EdgeInsets.all(PsDimens.space8),
            child: RefreshIndicator(
              onRefresh: () {
                provider.subCategoryParameterHolder.keyword = '';
                return provider.loadDataList(
                  reset: true,
                  requestBodyHolder: provider.subCategoryParameterHolder,
                );
              },
              child: CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    if (provider.hasData ||
                        provider.currentStatus == PsStatus.BLOCK_LOADING)
                      CustomSubCategoryVerticalData(
                        animationController: animationController!,
                      )
                    else
                      CustomSubCategoryDataEmptyBox()
                  ]),
            )),
        PSProgressIndicator(
          provider.currentStatus,
          message: provider.subCategoryList.message,
        )
      ]),
    );
  }
}
