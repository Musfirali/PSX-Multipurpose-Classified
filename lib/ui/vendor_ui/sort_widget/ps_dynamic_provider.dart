import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/constant/ps_provider_const.dart';
import 'package:psxmpc/core/vendor/provider/about_us/about_us_provider.dart';
import 'package:psxmpc/core/vendor/provider/app_info/app_info_provider.dart';
import 'package:psxmpc/core/vendor/provider/blog/blog_provider.dart';
import 'package:psxmpc/core/vendor/provider/category/category_provider.dart';
import 'package:psxmpc/core/vendor/provider/chat/user_unread_message_provider.dart';
import 'package:psxmpc/core/vendor/provider/gallery/gallery_provider.dart';
import 'package:psxmpc/core/vendor/provider/history/history_provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/package_bought/package_bought_transaction_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/added_item_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/disabled_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/discount_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/favourite_item_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/item_entry_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/item_list_from_followers_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/mark_sold_out_item_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/nearest_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/paid_ad_product_provider%20copy.dart';
import 'package:psxmpc/core/vendor/provider/product/paid_id_item_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/pending_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/popular_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/recent_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/rejected_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/related_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/search_product_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/sold_out_item_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/touch_count_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/top_seller_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/user_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/product_parameter_holder.dart';

CategoryProvider? _categoryProvider;
RecentProductProvider? _recentProductProvider;
NearestProductProvider? _nearestProductProvider;
BlogProvider? _blogProvider;
PaidAdProductProvider? _paidAdProductProvider;
DiscountProductProvider? _discountProductProvider;
PopularProductProvider? _popularProductProvider;
ItemListFromFollowersProvider? _itemListFromFollowersProvider;
UserUnreadMessageProvider? _userUnreadMessageProvider;
// HistoryProvider? _historyProvider;
// late List<String> providerList;

List<SingleChildWidget> psDynamicProvider(
  BuildContext context,
  Function onRefresh, {
  bool? mounted,
  String keyword = '',
  String? userId,
  String? productId,
  String? catID,
  required List<String> providerList,
  Function? searchProductProvider,
  Function? categoryProvider,
  ProductParameterHolder? productParameterHolder,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final AppLocalization langProvider = Provider.of<AppLocalization>(context);

  final List<SingleChildWidget> _providers = <SingleChildWidget>[];

  final Map<String, Map<String, SingleChildWidget>> providerMap =
      <String, Map<String, SingleChildWidget>>{
    'category': <String, SingleChildWidget>{
      PsProviderConst.init_category_provider:
          initCategoryProvider(context, (CategoryProvider pro) {
        _categoryProvider = pro;
        categoryProvider!(pro);
      }, keyword: keyword),
    },
    'product': <String, SingleChildWidget>{
      PsProviderConst.init_nearest_product_provider: initNearestProductProvider(
          context,
          mounted ?? true,
          (NearestProductProvider pro) => _nearestProductProvider = pro),
      PsProviderConst.init_paid_ad_product_provider: initPaidAdProductProvider(
          context, (PaidAdProductProvider pro) => _paidAdProductProvider = pro),
      PsProviderConst.init_discount_product_provider:
          initDiscountProductProvider(context,
              (DiscountProductProvider pro) => _discountProductProvider = pro),
      PsProviderConst.init_popular_product_provider: initPopularProductProvider(
          context,
          (PopularProductProvider pro) => _popularProductProvider = pro),
      PsProviderConst.init_item_list_from_followers_provider:
          initItemListFromFollowersProvider(
              context,
              (ItemListFromFollowersProvider pro) =>
                  _itemListFromFollowersProvider = pro),
      PsProviderConst.init_recent_product_provider: initRecentProductProvider(
        context,
        (RecentProductProvider pro) => _recentProductProvider = pro,
      ),
      PsProviderConst.init_item_detail_provider: initItemDetailProvider(
          context, (ItemDetailProvider pro) {},
          productID: productId ?? ''),
      PsProviderConst.init_item_entry_provider: initItemEntryProvider(
        context,
        (ItemEntryFieldProvider pro) {},
        catId: catID ?? ''
      ),
      PsProviderConst.init_mark_soldout_item_provider:
          initMarkSoldOutItemProvider(context),
      PsProviderConst.init_related_product_provider: initRelatedProductProvider(
        context,
        (RelatedProductProvider pro) {},
        productID: productId ?? '',
      ),
      PsProviderConst.init_touch_count_provider: initTouchCountProvider(
          context, (TouchCountProvider pro) {},
          productId: productId ?? ''),
      PsProviderConst.init_favourite_item_provider:
          initFavouriteItemProvider(context, (FavouriteItemProvider pro) {}),
      PsProviderConst.init_package_transcation_history_provider:
          initPackageTranscationHistoryProvider(
        context,
        userId: userId,
      ),
      PsProviderConst.init_added_item_provider: initAddedItemProvider(
        context,
        userId: userId,
      ),
      PsProviderConst.init_soldout_item_provider: initSoldOutItemProvider(
        context,
        userId: userId,
      ),
      PsProviderConst.init_pending_product_provider: initPendingProductProvider(
        context,
        userId: userId,
      ),
      PsProviderConst.init_disabled_product_provider:
          initDisabledProductProvider(
        context,
        userId: userId,
      ),
      PsProviderConst.init_rejected_product_provider:
          initRejectedProductProvider(
        context,
        userId: userId,
      ),
      PsProviderConst.init_search_product_provider:
          initSearchProductProvider(context, (SearchProductProvider provider) {
        // searchProductProvider = provider;
        searchProductProvider!(provider);
      }, productParameterHolder: productParameterHolder),
    },
    'history': <String, SingleChildWidget>{
      PsProviderConst.init_history_provider:
          initHistoryProvider(context, (HistoryProvider provider) {}),
    },
    'ad': <String, SingleChildWidget>{
      PsProviderConst.init_paid_ad_item_provider: initPaidAdItemProvider(
        context,
        userId: userId,
      ),
    },
    'blog': <String, SingleChildWidget>{
      PsProviderConst.init_blog_provider:
          initBlogProvider(context, (BlogProvider pro) => _blogProvider = pro),
    },
    'about_us': <String, SingleChildWidget>{
      PsProviderConst.init_about_us_provider:
          initAboutUsProvider(context, (AboutUsProvider pro) {}),
    },
    'user': <String, SingleChildWidget>{
      PsProviderConst.init_user_provider:
          initUserProvider(context, userId: userId),
      PsProviderConst.init_top_seller_provider: 
          initTopSellerProvider(context, (TopSellerProvider pro) {})
    },
    'app_info': <String, SingleChildWidget>{
      PsProviderConst.init_appinfo_provider:
          initAppInfoProvider(context, (AppInfoProvider pro) {}),
    },
    'gallery': <String, SingleChildWidget>{
      PsProviderConst.init_appinfo_provider:
          initGalleryProvider(context, (GalleryProvider pro) {}),
    },
  };

  for (String i in providerList) {
    // if (providerMap[i] != null) {
    //   _providers.add(providerMap[i]!);
    // }
    for (String outerKey in providerMap.keys) {
      if (providerMap[outerKey]?[i] != null)
        _providers.add(providerMap[outerKey]![i]!);
    }
  }

  Future<void> refresh() async {
    await _recentProductProvider?.loadDataList(reset: true);
    await _nearestProductProvider?.loadDataList(reset: true);
    await _blogProvider?.loadDataList(reset: true);
    await _paidAdProductProvider?.loadDataList(reset: true);
    await _popularProductProvider?.loadDataList(reset: true);
    await _discountProductProvider?.loadDataList(reset: true);
    if (valueHolder.loginUserId != null && valueHolder.loginUserId != '') {
      await _userUnreadMessageProvider?.loadData(
          requestBodyHolder:
              _userUnreadMessageProvider?.userUnreadMessageHolder);
    }
    await _itemListFromFollowersProvider?.resetItemListFromFollowersList(
        jsonMap: _itemListFromFollowersProvider!.followUserItemParameterHolder
            .toMap(),
        loginUserId: Utils.checkUserLoginId(
            _itemListFromFollowersProvider?.psValueHolder!),
        languageCode: langProvider.currentLocale.languageCode);
    await _categoryProvider?.loadDataList(reset: true);
  }

  onRefresh(() {
    return refresh();
  });

  if (_providers.isEmpty) {
    // ignore: always_specify_types
    _providers.add(ChangeNotifierProvider(
      create: (BuildContext context) {},
    ));
  }
  return _providers;
}
