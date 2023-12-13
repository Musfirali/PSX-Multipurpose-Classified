import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/customize_ui_detail.dart';
import '../../../../../config/ps_config.dart';
import '../../../../../core/vendor/provider/product/customize_ui_detail_provider.dart';
import '../../../../../core/vendor/repository/customize_ui_detail_repository.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../common/base/ps_widget_with_appbar.dart';
import '../components/single_selection_list_item.dart';

class SingleDataSelectionContainer extends StatefulWidget {
  const SingleDataSelectionContainer({
    Key? key,
    required this.appBartitle,
    required this.textEditingController,
    required this.coreKeyId,
    required this.selectedId,
    this.allNeeded = false,
  }) : super(key: key);
  final String appBartitle;
  final TextEditingController textEditingController;
  final String coreKeyId;
  final String? selectedId;
  final bool allNeeded;
  @override
  State<SingleDataSelectionContainer> createState() =>
      _SingleDataSelectionContainerState();
}

class _SingleDataSelectionContainerState
    extends State<SingleDataSelectionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Future<bool> _requestPop() {
    animationController.reverse().then<dynamic>(
      (void data) {
        if (!mounted) {
          return Future<bool>.value(false);
        }
        Navigator.pop(context, true);
        return Future<bool>.value(true);
      },
    );
    return Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    /// allNeeded is True when filter includes all too
    final CustomizeUiDetailRepository repo =
        Provider.of<CustomizeUiDetailRepository>(context);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<CustomizeUiDetailProvider>(
        builder: (BuildContext context, CustomizeUiDetailProvider provider,
            Widget? child) {
          int count = provider.customizeUiDetails.data?.length ?? 0;
          if (widget.allNeeded) {
            count++;
          }
          if (provider.customizeUiDetails.data != null) {
            return ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0 && widget.allNeeded) {
                    return SingleSelectionListItem(
                      animation: curveAnimation(animationController,
                          index: index, count: count),
                      controller: animationController,
                      customizeUiDetail: CustomizeUiDetail(
                          name: 'product_list__category_all'.tr),
                      isSelected:
                          widget.selectedId == 'product_list__category_all'.tr,
                      onTap: () {
                        Navigator.pop(context, 'product_list__category_all'.tr);
                      },
                    );
                  }

                  final int currentIndex = widget.allNeeded ? index - 1 : index;
                  return SingleSelectionListItem(
                    animation: curveAnimation(animationController,
                        index: index, count: count),
                    controller: animationController,
                    customizeUiDetail: provider.getListIndexOf(currentIndex),
                    isSelected: widget.selectedId ==
                        provider.getListIndexOf(currentIndex).id.toString(),
                    onTap: () {
                      Navigator.pop(
                          context, provider.getListIndexOf(currentIndex));
                    },
                  );
                });
          } else {
            return const SizedBox();
          }
        },
        initProvider: () => CustomizeUiDetailProvider(repo: repo),
        onProviderReady: (CustomizeUiDetailProvider provider) {
          provider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  languageCode: langProvider.currentLocale.languageCode,
                  coreKeyId: widget.coreKeyId));
        },
        appBarTitle: widget.appBartitle,
      ),
    );
  }
}
