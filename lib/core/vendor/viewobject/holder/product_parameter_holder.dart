import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';
import '../entry_product_relation.dart';

class ProductParameterHolder extends PsHolder<dynamic> {
  ProductParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    addedUserId = '';
    isPaid = '';
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];
    customzeUiDetailId = '';
  }

  String? searchTerm;
  String? catId;
  String? subCatId;
  String? itemCurrencyId;
  String? itemLocationId;
  String? itemLocationTownshipId;
  String? itemLocationName;
  String? itemLocationTownshipName;
  String? maxPrice;
  String? minPrice;
  String? status;
  String? lat;
  String? lng;
  String? mile;
  String? orderBy;
  String? orderType;
  String? addedUserId;
  String? adType;
  String? isPaid;
  String? isSoldOut;
  String? isDiscount;
  List<EntryProductRelation>? productRelation;
  String? customzeUiDetailId;

  // String? itemTypeId;
  // String? itemPriceTypeId;
  // String? itemLocationName;
  // String? itemLocationTownshipName;
  // String? dealOptionId;
  // String? conditionOfItemId;
  // String? conditionOfItemName;
  // String? brand;

  bool isFiltered() {
    return !(
        // isAvailable == '' &&
        //   (isDiscount == '0' || isDiscount == '') &&
        //   (isFeatured == '0' || isFeatured == '') &&
        orderBy == '' &&
            orderType == '' &&
            minPrice == '' &&
            maxPrice == '' &&
            isSoldOut == '' &&
            searchTerm == '' &&
            itemLocationId == '' &&
            itemLocationTownshipId == '' &&
            productRelation!.isEmpty);
  }

  bool get isCatAndSubCatFiltered {
    return !(catId == '' && subCatId == '');
  }

  bool get isMapFiltered {
    return lat != null &&
        lat != '' &&
        double.tryParse(lat!) != null &&
        double.parse(lat!) > 0;
  }

  bool get isFilterLatest {
    return orderBy == PsConst.FILTERING__ADDED_DATE;
  }

  bool get isFilterPopular {
    return orderBy == PsConst.FILTERING_TRENDING;
  }

  bool get isFilterByNameAscending {
    return orderBy == PsConst.FILTERING_NAME &&
        orderType == PsConst.FILTERING__ASC;
  }

  bool get isFilterByNameDescending {
    return orderBy == PsConst.FILTERING_NAME &&
        orderType == PsConst.FILTERING__DESC;
  }

  ProductParameterHolder getRecentParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];
    customzeUiDetailId= '';

    return this;
  }

  ProductParameterHolder getNearestParameterHolder() {
    searchTerm = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getPaidItemParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = PsConst.ONLY_PAID_ITEM;
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getPendingItemParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '0';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getRejectedItemParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '3';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getDisabledProductParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '2';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getFeaturedParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING_FEATURE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getPopularParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING_TRENDING;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getLatestParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];
    customzeUiDetailId= '';

    return this;
  }

  ProductParameterHolder getDiscountParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '1';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder getSoldOutParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '1';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  ProductParameterHolder resetParameterHolder() {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    itemLocationName = '';
    itemLocationTownshipName = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '1';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['searchterm'] = searchTerm;
    map['cat_id'] = catId;
    map['sub_cat_id'] = subCatId;
    map['item_currency_id'] = itemCurrencyId;
    map['item_location_id'] = itemLocationId;
    map['item_location_township_id'] = itemLocationTownshipId;
    map['is_sold_out'] = isSoldOut;
    map['max_price'] = maxPrice;
    map['min_price'] = minPrice;
    map['lat'] = lat;
    map['lng'] = lng;
    map['miles'] = mile;
    map['added_user_id'] = addedUserId;
    map['ad_post_type'] = isPaid;
    map['order_by'] = orderBy;
    map['order_type'] = orderType;
    map['status'] = status;
    map['is_discount'] = isDiscount;
    map['ad_type'] = adType;
    map['product_relation'] = EntryProductRelation().toMapList(productRelation!);
    map['id']=customzeUiDetailId;
    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    searchTerm = '';
    catId = '';
    subCatId = '';
    itemCurrencyId = '';
    itemLocationId = '';
    itemLocationTownshipId = '';
    isSoldOut = '';
    maxPrice = '';
    minPrice = '';
    lat = '';
    lng = '';
    mile = '';
    addedUserId = '';
    isPaid = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    status = '';
    isDiscount = '';
    adType = '';
    productRelation = <EntryProductRelation>[];

    return this;
  }

  @override
  String getParamKey() {
    String result = '';

    if (searchTerm != '') {
      result += searchTerm! + ':';
    }
    if (catId != '') {
      result += catId! + ':';
    }
    if(customzeUiDetailId != ''){
      result += customzeUiDetailId! +':';
    }

    if (subCatId != '') {
      result += subCatId! + ':';
    }
    if (itemCurrencyId != '') {
      result += itemCurrencyId! + ':';
    }
    if (itemLocationId != '') {
      result += itemLocationId! + ':';
    }
    if (itemLocationTownshipId != '') {
      result += itemLocationTownshipId! + ':';
    }
    if (isSoldOut != '') {
      result += isSoldOut! + ':';
    }
    if (maxPrice != '') {
      result += maxPrice! + ':';
    }
    if (minPrice != '') {
      result += minPrice! + ':';
    }
    if (lat != '') {
      result += lat! + ':';
    }
    if (lng != '') {
      result += lng! + ':';
    }
    if (mile != '') {
      result += mile! + ':';
    }
    if (addedUserId != '') {
      result += addedUserId! + ':';
    }
    if (status != '') {
      result += status! + ':';
    }
    if (isPaid != '') {
      result += isPaid! + ':';
    }
    if (orderBy != '') {
      result += orderBy! + ':';
    }
    if (orderType != '') {
      result += orderType!;
    }
    if (isDiscount != '') {
      result += isDiscount!;
    }
    if (adType != '') {
      result += adType!;
    }
    for (int i = 0;
        productRelation != null && i < productRelation!.length;
        i++) {
      result +=
          productRelation![i].coreKeyId! + ',' + productRelation![i].value!;
    }

    return result;
  }
}
