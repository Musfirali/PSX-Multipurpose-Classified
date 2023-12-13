import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/language/language_provider.dart';
import '../../../../core/vendor/repository/language_repository.dart';
import '../../../../core/vendor/utils/ps_animation.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/viewobject/common/language.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/language/component/choose_language/language_list_item.dart';
import '../../../custom_ui/language/component/choose_language/language_search_widget.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/dialog/confirm_dialog_view.dart';

class LanguageListView extends StatefulWidget {
  const LanguageListView({this.fromBoard = false});
  final bool fromBoard;
  @override
  _LanguageListViewState createState() => _LanguageListViewState();
}

class _LanguageListViewState extends State<LanguageListView>
    with SingleTickerProviderStateMixin {
  LanguageRepository? repo1;
  late LanguageProvider _languageProvider;
  AnimationController? animationController;
  Animation<double>? animation;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _languageProvider.loadNextDataList();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    repo1 = Provider.of<LanguageRepository>(context);
    timeDilation = 1.0;
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
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

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<LanguageProvider>(
        appBarTitle: 'language_selection__select'.tr,
        initProvider: () {
          _languageProvider = LanguageProvider(repo: repo1);
          return _languageProvider;
        },
        onProviderReady: (LanguageProvider provider) {
          provider.loadDataList(
              requestBodyHolder: provider.languageParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: psValueHolder.loginUserId,
                  languageCode: langProvider.currentLocale.languageCode));
        },
        builder:
            (BuildContext context, LanguageProvider provider, Widget? child) {
          final bool isLoading =
              provider.currentStatus == PsStatus.BLOCK_LOADING;
          final int count = isLoading
              ? psValueHolder.loadingShimmerItemCount!
              : provider.dataLength;
          return Column(
            children: <Widget>[
              const CustomLanguageSearchWidget(),
              Flexible(
                child: RefreshIndicator(
                  child: (provider.hasData ||
                          provider.currentStatus == PsStatus.BLOCK_LOADING)
                      ? ListView.builder(
                          shrinkWrap: false,
                          itemCount: provider.dataLength,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomLanguageListItem(
                              language: provider
                                  .getListIndexOf(index), //_lanuageList[index],
                              animationController: animationController,
                              animation: curveAnimation(animationController!,
                                  count: count, index: index),
                              onTap: () {
                                onTap(context, provider.getListIndexOf(index));
                              },
                              isLoading: isLoading,
                            );
                          },
                        )
                      : const SizedBox(),
                  onRefresh: () {
                    return provider.loadDataList(
                      reset: true,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> onTap(BuildContext context, Language language) async {
    final LanguageProvider provider =
        Provider.of<LanguageProvider>(context, listen: false);
    bool userChooseLanguage = false;
    await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogView(
              description: 'home__language_dialog_description'.tr,
              leftButtonText: 'dialog__cancel'.tr,
              rightButtonText: 'dialog__ok'.tr,
              onAgreeTap: () async {
                await provider.replaceUserChangesLocalLanguage(true);
                userChooseLanguage = true;
                Navigator.of(context).pop();
              });
        });
    if (userChooseLanguage) {
      await PsProgressDialog.showDialog(context);
      final AppLocalization langProvider =
          Provider.of<AppLocalization>(context, listen: false);
      await langProvider.setLocale(
          language.toLocale(), language.code!, language.id!);
      await provider.addLanguage(language);
      PsProgressDialog.dismissDialog();

      if (widget.fromBoard) {
        final PsValueHolder psValueHolder =
            Provider.of<PsValueHolder>(context, listen: false);
        if (psValueHolder.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.itemLocationList,
          );
        }
      }
    }
  }
}
