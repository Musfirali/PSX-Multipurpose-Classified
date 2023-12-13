import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/favourite_item_provider.dart';
import '../../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../custom_ui/item/favourite/component/widgets/favorite_product_list.dart';
import '../../../common/ps_admob_banner_widget.dart';
import '../../../common/ps_app_bar_widget.dart';
import '../../../common/ps_ui_widget.dart';

class FavouriteProductListView extends StatefulWidget {
  const FavouriteProductListView(
      {Key? key,
      required this.animationController,
      required this.scaffoldKey,
      required this.fromActivityLog})
      : super(key: key);

  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool fromActivityLog;

  @override
  _FavouriteProductListView createState() => _FavouriteProductListView();
}

class _FavouriteProductListView extends State<FavouriteProductListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  FavouriteItemProvider? _favouriteItemProvider;
  bool isGrid = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _favouriteItemProvider!
            .nextFavouriteItemList(langProvider.currentLocale.languageCode);
      }
    });

    super.initState();
  }

  ProductRepository? repo1;
  PsValueHolder? psValueHolder;
  dynamic data;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && psValueHolder!.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<ProductRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context, listen: false);
    if (!isConnectedToInternet && psValueHolder!.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
    // data = EasyLocalizationProvider.of(context).data;

    print(
        '............................Build UI Again ............................');

    return Container(
        margin: !widget.fromActivityLog
            ? EdgeInsets.only(
                top: MediaQuery.of(widget.scaffoldKey.currentContext ?? context)
                    .viewPadding
                    .top)
            : const EdgeInsets.only(top: 0),
        child: WillPopScope(
          onWillPop: () async {
            return Future<bool>.value(false);
          },
          child: Scaffold(
            appBar: PsAppbarWidget(
                appBarTitle: 'home__menu_drawer_favourite'.tr,
                leading: !widget.fromActivityLog
                    ? Center(
                        child: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () =>
                            widget.scaffoldKey.currentState?.openDrawer(),
                      ))
                    : null,
                actionWidgets: <Widget>[
                  if (isGrid)
                    IconButton(
                      padding: const EdgeInsets.only(right: PsDimens.space16),
                      icon: const Icon(Icons.grid_view, size: 20),
                      onPressed: () async {
                        setState(() {
                          isGrid = false;
                        });
                      },
                    )
                  else
                    IconButton(
                      padding: const EdgeInsets.only(right: PsDimens.space16),
                      icon:
                          const Icon(Icons.list, size: 28),
                      onPressed: () async {
                        setState(() {
                          isGrid = true;
                        });
                      },
                    ),
                ]),
            body: ChangeNotifierProvider<FavouriteItemProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  final FavouriteItemProvider provider = FavouriteItemProvider(
                      repo: repo1, psValueHolder: psValueHolder);
                  provider.loadFavouriteItemList(
                      langProvider.currentLocale.languageCode);
                  _favouriteItemProvider = provider;
                  return _favouriteItemProvider;
                },
                child: Consumer<FavouriteItemProvider>(
                  builder: (BuildContext context,
                      FavouriteItemProvider provider, Widget? child) {
                    return Column(
                      children: <Widget>[
                        const PsAdMobBannerWidget(),
                        Expanded(
                          child: Stack(children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(
                                    left: PsDimens.space4,
                                    right: PsDimens.space4,
                                    top: PsDimens.space4,
                                    bottom: PsDimens.space4),
                                child: RefreshIndicator(
                                  child: CustomScrollView(
                                      controller: _scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      slivers: <Widget>[
                                        if (provider.hasData ||
                                            provider.currentStatus ==
                                                PsStatus.BLOCK_LOADING)
                                          CustomFavoriteProductList(
                                              animationController:
                                                  widget.animationController,
                                              isGrid: isGrid)
                                      ]),
                                  onRefresh: () {
                                    return provider.resetFavouriteItemList(
                                        langProvider
                                            .currentLocale.languageCode);
                                  },
                                )),
                            PSProgressIndicator(provider.currentStatus)
                          ]),
                        ),
                        if (!widget.fromActivityLog)
                          const SizedBox(height: PsDimens.space80)
                      ],
                    );
                  },
                )),
          ),
        ));
  }
}
