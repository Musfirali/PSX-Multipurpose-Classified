import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/added_item_provider.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/item_list/component/user_item_list.dart';
import '../../../common/base/ps_widget_with_appbar.dart';
import '../../../common/ps_ui_widget.dart';

class UserItemListView extends StatefulWidget {
  const UserItemListView(
      {required this.addedUserId,
      required this.status,
      required this.title,
      this.isSoldOutList = false});
  final String? addedUserId;
  final String status;
  final String title;
  final bool isSoldOutList;

  @override
  _UserItemListViewState createState() {
    return _UserItemListViewState();
  }
}

class _UserItemListViewState extends State<UserItemListView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AddedItemProvider _userAddedItemProvider;

  late AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _userAddedItemProvider.loadNextDataList();
      }
    });
  }

  ProductRepository? repo1;
  PsValueHolder? psValueHolder;
  @override
  Widget build(BuildContext context) {
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

    timeDilation = 1.0;
    repo1 = Provider.of<ProductRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<AddedItemProvider>(
          appBarTitle: widget.title,
          initProvider: () {
            return AddedItemProvider(repo: repo1, psValueHolder: psValueHolder);
          },
          onProviderReady: (AddedItemProvider provider) {
            final String? loginUserId = Utils.checkUserLoginId(psValueHolder!);
            provider.addedUserParameterHolder.mile = psValueHolder!.mile;
            provider.addedUserParameterHolder.addedUserId = widget.addedUserId;
            if (!widget.isSoldOutList)
              provider.addedUserParameterHolder.status = widget.status;
            else {
              provider.addedUserParameterHolder.status = '1';
              provider.addedUserParameterHolder.isSoldOut = '1';
            }

            provider.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: loginUserId,
                    languageCode: langProvider.currentLocale.languageCode),
                requestBodyHolder: provider.addedUserParameterHolder);

            _userAddedItemProvider = provider;

            _userAddedItemProvider = provider;
          },
          builder: (BuildContext context, AddedItemProvider provider,
              Widget? child) {
            return Stack(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(
                      left: PsDimens.space8,
                      right: PsDimens.space8,
                      top: PsDimens.space8,
                      bottom: PsDimens.space8),
                  child: RefreshIndicator(
                    child: CustomScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        slivers: <Widget>[
                          if (provider.hasData ||
                              provider.currentStatus == PsStatus.BLOCK_LOADING)
                            CustomUserItemList(
                              animationController: animationController,
                            ),
                        ]),
                    onRefresh: () async {
                      _userAddedItemProvider.addedUserParameterHolder
                          .addedUserId = widget.addedUserId;

                      return _userAddedItemProvider.loadDataList(reset: true);
                    },
                  )),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
    );
  }
}
