import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/item_currency_provider.dart';
import '../../../../../core/vendor/repository/item_currency_repository.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/item/currency/component/item_currency_list_view_item.dart';
import '../../../common/base/ps_widget_with_appbar.dart';
import '../../../common/ps_ui_widget.dart';

class ItemCurrencyView extends StatefulWidget {
  const ItemCurrencyView({required this.selectedCurrencySymobol});
  final String selectedCurrencySymobol;
  @override
  State<StatefulWidget> createState() {
    return ItemCurrencyViewState();
  }
}

class ItemCurrencyViewState extends State<ItemCurrencyView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late ItemCurrencyProvider _temCurrencyProvider;
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _temCurrencyProvider.loadNextDataList();
      }
    });

    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);
    super.initState();
  }

  ItemCurrencyRepository? repo1;

  @override
  Widget build(BuildContext context) {
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

    repo1 = Provider.of<ItemCurrencyRepository>(context);

    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);

    print(
        '............................Build UI Again ............................');

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<ItemCurrencyProvider>(
          appBarTitle: 'item_entry__currency'.tr,
          initProvider: () {
            return ItemCurrencyProvider(
              repo: repo1,
            );
          },
          onProviderReady: (ItemCurrencyProvider provider) {
            provider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  languageCode: langProvider.currentLocale.languageCode),
            );
            _temCurrencyProvider = provider;
          },
          builder: (BuildContext context, ItemCurrencyProvider provider,
              Widget? child) {
            return Stack(children: <Widget>[
              RefreshIndicator(
                child: provider.hasData
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: provider.itemCurrencyList.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final int count =
                              provider.itemCurrencyList.data!.length;
                          animationController!.forward();
                          return FadeTransition(
                              opacity: animation!,
                              child: CustomItemCurrencyListViewItem(
                                itemCurrency:
                                    provider.itemCurrencyList.data![index],
                                onTap: () {
                                  Navigator.pop(context,
                                      provider.itemCurrencyList.data![index]);
                                  print(provider.itemCurrencyList.data![index]
                                      .currencySymbol);
                                },
                                animationController: animationController,
                                animation: curveAnimation(animationController!,
                                    count: count, index: index),
                                isSelected: provider.itemCurrencyList
                                        .data![index].currencySymbol ==
                                    widget.selectedCurrencySymobol,
                              ));
                        })
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                      ),
                onRefresh: () {
                  return provider.loadDataList(reset: true);
                },
              ),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
    );
  }
}
