import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/category/component/menu_vertical/widgets/vertical_list/category_sorting_empty_data_box.dart';
import '../../../../../custom_ui/category/component/menu_vertical/widgets/vertical_list/category_vertical_list_data.dart';
import '../../../../common/ps_ui_widget.dart';


class CategoryVerticalListView extends StatefulWidget {
  const CategoryVerticalListView({required this.animationController});

  final AnimationController animationController;

  @override
  _CategoryVerticalListViewState createState() =>
      _CategoryVerticalListViewState();
}

class _CategoryVerticalListViewState extends State<CategoryVerticalListView> {
  final ScrollController _scrollController = ScrollController();
  late CategoryProvider provider;
  late PsValueHolder valueHolder;
  late AppLocalization langProvider;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.loadNextDataList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final CategoryProvider provider = Provider.of<CategoryProvider>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return Expanded(
      child: Stack(children: <Widget>[
        Container(
            margin: const EdgeInsets.all(PsDimens.space8),
            child: RefreshIndicator(
              child: CustomScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: false,
                  slivers: <Widget>[
                    if (provider.hasData ||
                        provider.currentStatus == PsStatus.BLOCK_LOADING)
                      CustomCategoryVerticalListData(
                          animationController: widget.animationController)
                    else
                      CustomCategorySortingEmptyBox()
                  ]),
              onRefresh: () {
                provider.categoryParameterHolder.keyword = '';
                return provider.loadDataList(
                  reset: true,
                  requestBodyHolder: provider.categoryParameterHolder);
              },
            )),
        PSProgressIndicator(provider.currentStatus)
      ]),
    );
  }
}
