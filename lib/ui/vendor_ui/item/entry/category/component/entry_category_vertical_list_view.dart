import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/repository/category_repository.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';
import 'package:psxmpc/ui/custom_ui/category/component/menu_vertical/widgets/vertical_list/category_sorting_empty_data_box.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/item/entry/category/component/entry_category_info_widget.dart';
import '../../../../../custom_ui/item/entry/category/component/entry_category_vertical_list_data.dart';
import '../../../../common/ps_ui_widget.dart';

class EntryCategoryVerticalListView extends StatefulWidget {
  const EntryCategoryVerticalListView({
    required this.animationController,
    this.onItemUploaded,
    this.isFromChat});

  final AnimationController animationController;
  final Function? onItemUploaded;
  final bool? isFromChat;

  @override
  _EntryCategoryVerticalListViewState createState() =>
      _EntryCategoryVerticalListViewState();
}

class _EntryCategoryVerticalListViewState extends State<EntryCategoryVerticalListView> {
  final ScrollController _scrollController = ScrollController();
  late CategoryProvider provider;
  CategoryRepository? repo1;
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
    repo1 = Provider.of<CategoryRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return ChangeNotifierProvider<CategoryProvider?>(
          lazy: false,
          create: (BuildContext context) {
            provider = CategoryProvider(repo: repo1);

            provider.loadDataList(
                requestBodyHolder:
                    provider.categoryParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: Utils.checkUserLoginId(valueHolder),
                    languageCode: langProvider.currentLocale.languageCode));
            
            return provider;
        },
        child: Consumer<CategoryProvider>(builder:
            (BuildContext context, CategoryProvider provider,
                Widget? child) {
            return Stack(children: <Widget>[
                CustomEntryCategoryInfoWidget(),
                Container(
                    margin: const EdgeInsets.only(
                      top: PsDimens.space76,
                      left: PsDimens.space8,
                      right: PsDimens.space8,
                      ),
                    child: RefreshIndicator(
                      child: CustomScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          slivers: <Widget>[
                            if (provider.hasData ||
                                provider.currentStatus == PsStatus.BLOCK_LOADING) 
                              CustomEntryCategoryVerticalListData(
                                  animationController: widget.animationController,
                                  onItemUploaded: widget.onItemUploaded,
                                  isFromChat: widget.isFromChat)
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
              ],
            );
        }));
  }
}
