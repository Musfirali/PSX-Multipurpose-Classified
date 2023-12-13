import 'package:psxmpc/core/vendor/viewobject/selected_value.dart';
import 'package:quiver/core.dart';

import '../constant/ps_constants.dart';
import '../utils/utils.dart';
import 'category.dart';
import 'common/ps_object.dart';
import 'default_photo.dart';
import 'item_currency.dart';
import 'item_location.dart';
import 'item_location_township.dart';
import 'product_relation.dart';
import 'sub_category.dart';
import 'user.dart';

class Product extends PsObject<Product> {
  Product(
      {this.id,
      this.title,
      this.catId,
      this.subCatId,
      this.itemCurrencyId,
      this.itemLocationId,
      this.itemLocationTownshipId,
      this.shopId,
      this.originalPrice,
      this.currentPrice,
      this.description,
      this.searchTag,
      this.dynamicLink,
      this.lat,
      this.lng,
      this.status,
      this.isPaid,
      this.isSoldOut,
      this.ordering,
      this.isAvailable,
      this.isDiscount,
      this.touchCount,
      this.favouriteCount,
      this.overAllRating,
      this.photoCount,
      this.videoCount,
      this.defaultPhoto,
      this.video,
      this.videoThumbnail,
      this.category,
      this.subCategory,
      this.itemCurrency,
      this.itemLocation,
      this.itemLocationTownship,
      this.user,
      this.isFavourited,
      this.isOwner,
      this.adType,
      this.paidStatus,
      this.addedDate,
      this.addedUserId,
      this.addedDateStr,
      this.productRelation,
      this.discountRate,
      this.phoneNumList});

  String? id;
  String? title;
  String? catId;
  String? subCatId;
  String? itemCurrencyId;
  String? itemLocationId;
  String? itemLocationTownshipId;
  String? shopId;
  String? originalPrice;
  String? currentPrice;
  String? description;
  String? searchTag;
  String? dynamicLink;
  String? lat;
  String? lng;
  String? status;
  String? isPaid;
  String? isSoldOut;
  String? ordering;
  String? isAvailable;
  String? isDiscount;
  String? touchCount;
  String? favouriteCount;
  String? overAllRating;
  String? photoCount;
  String? videoCount;
  DefaultPhoto? defaultPhoto;
  DefaultPhoto? video;
  DefaultPhoto? videoThumbnail;
  Category? category;
  SubCategory? subCategory;
  ItemCurrency? itemCurrency;
  ItemLocation? itemLocation;
  ItemLocationTownship? itemLocationTownship;
  User? user;
  String? isFavourited;
  String? isOwner;
  String? adType;
  String? paidStatus;
  String? addedDate;
  String? addedUserId;
  String? addedDateStr;
  List<ProductRelation>? productRelation;
  String? discountRate;
  String? phoneNumList;

  @override
  bool operator ==(dynamic other) => other is Product && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  Product fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return Product(
      id: dynamicData['id'],
      title: dynamicData['title'],
      catId: dynamicData['category_id'],
      subCatId: dynamicData['subcategory_id'],
      itemCurrencyId: dynamicData['currency_id'],
      itemLocationId: dynamicData['location_city_id'],
      itemLocationTownshipId: dynamicData['location_township_id'],
      shopId: dynamicData['shop_id'],
      currentPrice: dynamicData['price'],
      originalPrice: dynamicData['original_price'],
      description: dynamicData['description'],
      searchTag: dynamicData['search_tag'],
      dynamicLink: dynamicData['dynamic_link'],
      lat: dynamicData['lat'],
      lng: dynamicData['lng'],
      status: dynamicData['status'],
      isPaid: dynamicData['is_paid'],
      isSoldOut: dynamicData['is_sold_out'],
      ordering: dynamicData['ordering'],
      isAvailable: dynamicData['is_available'],
      isDiscount: dynamicData['is_discount'],
      touchCount: dynamicData['item_touch_count'],
      favouriteCount: dynamicData['favourite_count'],
      overAllRating: dynamicData['overall_rating'],
      photoCount: dynamicData['photo_count'],
      videoCount: dynamicData['video_count'],
      defaultPhoto: DefaultPhoto().fromMap(dynamicData['default_photo']),
      video: DefaultPhoto().fromMap(dynamicData['default_video']),
      videoThumbnail: DefaultPhoto().fromMap(dynamicData['default_video_icon']),
      category: Category().fromMap(dynamicData['category']),
      subCategory: SubCategory().fromMap(dynamicData['sub_category']),
      itemCurrency: ItemCurrency().fromMap(dynamicData['item_currency']),
      itemLocation: ItemLocation().fromMap(dynamicData['item_location']),
      itemLocationTownship:
          ItemLocationTownship().fromMap(dynamicData['item_location_township']),
      user: User().fromMap(dynamicData['user']),
      isFavourited: dynamicData['is_favourited'],
      isOwner: dynamicData['is_owner'],
      adType: dynamicData['ad_type'],
      paidStatus: dynamicData['paid_status'],
      addedDate: dynamicData['added_date'],
      addedUserId: dynamicData['added_user_id'],
      addedDateStr: dynamicData['added_date_str'],
      productRelation:
          ProductRelation().fromMapList(dynamicData['productRelation']),
      discountRate: dynamicData['percent'],
      phoneNumList: dynamicData['phone'],

      // itemTypeId: dynamicData['item_type_id'],
      // itemPriceTypeId: dynamicData['item_price_type_id'],
      // conditionOfItemId: dynamicData['condition_of_item_id'],
      // dealOptionRemark: dynamicData['deal_option_remark'],
      // highlightInformation: dynamicData['highlight_info'],
      // dealOptionId: dynamicData['deal_option_id'],
      // brand: dynamicData['brand'],
      // itemType: ItemType().fromMap(dynamicData['item_type']),
      // itemPriceType: ItemPriceType().fromMap(dynamicData['item_price_type']),
      // conditionOfItem:
      //     ConditionOfItem().fromMap(dynamicData['condition_of_item']),
      // dealOption: DealOption().fromMap(dynamicData['deal_option']),
      // businessMode: dynamicData['business_mode'],
      // address: dynamicData['address'],
    );
    // }
    // else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['title'] = object.title;
      data['category_id'] = object.catId;
      data['subcategory_id'] = object.subCatId;
      data['currency_id'] = object.itemCurrencyId;
      data['location_city_id'] = object.itemLocationId;
      data['location_township_id'] = object.itemLocationTownshipId;
      data['shop_id'] = object.shopId;
      data['description'] = object.description;
      data['original_price'] = object.originalPrice;
      data['price'] = object.currentPrice;
      data['search_tag'] = object.searchTag;
      data['dynamic_link'] = object.dynamicLink;
      data['lat'] = object.lat;
      data['lng'] = object.lng;
      data['status'] = object.status;
      data['is_paid'] = object.isPaid;
      data['is_sold_out'] = object.isSoldOut;
      data['ordering'] = object.ordering;
      data['is_available'] = object.isAvailable;
      data['is_discount'] = object.isDiscount;
      data['item_touch_count'] = object.touchCount;
      data['favourite_count'] = object.favouriteCount;
      data['overall_rating'] = object.overAllRating;
      data['photo_count'] = object.photoCount;
      data['video_count'] = object.videoCount;
      data['default_photo'] = DefaultPhoto().toMap(object.defaultPhoto);
      data['default_video'] = DefaultPhoto().toMap(object.video);
      data['default_video_icon'] = DefaultPhoto().toMap(object.videoThumbnail);
      data['category'] = Category().toMap(object.category);
      data['sub_category'] = SubCategory().toMap(object.subCategory);
      data['item_currency'] = ItemCurrency().toMap(object.itemCurrency);
      data['item_location'] = ItemLocation().toMap(object.itemLocation);
      data['item_location_township'] =
          ItemLocationTownship().toMap(object.itemLocationTownship);
      data['user'] = User().toMap(object.user);
      data['is_favourited'] = object.isFavourited;
      data['is_owner'] = object.isOwner;
      data['ad_type'] = object.adType;
      data['paid_status'] = object.paidStatus;
      data['added_date'] = object.addedDate;
      data['added_user_id'] = object.addedUserId;
      data['added_date_str'] = object.addedDateStr;
      data['productRelation'] =
          ProductRelation().toMapList(object.productRelation!);
      data['percent'] = object.discountRate;
      data['phone'] = object.phoneNumList;

      // data['item_type_id'] = object.itemTypeId;
      // data['item_price_type_id'] = object.itemPriceTypeId;
      // data['condition_of_item_id'] = object.conditionOfItemId;
      // data['deal_option_remark'] = object.dealOptionRemark;
      // data['highlight_info'] = object.highlightInformation;
      // data['deal_option_id'] = object.dealOptionId;
      // data['brand'] = object.brand;
      // data['item_type'] = ItemType().toMap(object.itemType);
      // data['item_price_type'] = ItemPriceType().toMap(object.itemPriceType);
      // data['condition_of_item'] =
      //     ConditionOfItem().toMap(object.conditionOfItem);
      // data['deal_option'] = DealOption().toMap(object.dealOption);
      // data['business_mode'] = object.businessMode;
      // data['address'] = object.address;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Product> fromMapList(List<dynamic> dynamicDataList) {
    final List<Product> newFeedList = <Product>[];
    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        newFeedList.add(fromMap(json));
      }
    }
    // }
    return newFeedList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];

    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }

  List<Product> checkDuplicate(List<Product> dataList) {
    final Map<String?, String?> idCache = <String?, String?>{};
    final List<Product> _tmpList = <Product>[];
    for (int i = 0; i < dataList.length; i++) {
      if (idCache[dataList[i].id] == null) {
        _tmpList.add(dataList[i]);
        idCache[dataList[i].id] = dataList[i].id;
      } else {
        Utils.psPrint('Duplicate');
      }
    }

    return _tmpList;
  }

  bool isSame(List<Product> cache, List<Product> newList) {
    if (cache.length == newList.length) {
      bool status = true;
      for (int i = 0; i < cache.length; i++) {
        if (cache[i].id != newList[i].id) {
          status = false;
          break;
        }
      }

      return status;
    } else {
      return false;
    }
  }

  bool get isPaidAdInProgress {
    return paidStatus == PsConst.ADSPROGRESS;
  }

  bool get isPaidAdInReject {
    return paidStatus == PsConst.ADS_REJECT;
  }

  bool get isAdWaitingForApproval {
    return paidStatus == PsConst.ADS_WAITING_FOR_APPROVAL;
  }

  bool get isPaidAdInFinish {
    return paidStatus == PsConst.ADSFINISHED;
  }

  bool get isPaidAdNotYetStart {
    return paidStatus == PsConst.ADSNOTYETSTART;
  }

  bool get isPaidAdNotAvailable {
    return paidStatus == PsConst.ADSNOTAVAILABLE;
  }

  bool get isSoldOutItem {
    return isSoldOut == PsConst.ONE;
  }

  bool get isFavorite {
    return isFavourited == PsConst.ONE;
  }

  // bool get isOwnerItem {
  //   return isOwner == PsConst.ONE;
  // }

  bool get isPublished {
    return status == PsConst.ONE;
  }

  bool get isItemPromotable {
    return isOwner == PsConst.ONE &&
        isPublished &&
        (isPaidAdNotAvailable || isPaidAdInFinish);
  }

  bool get isDiscountedItem {
    return isDiscount == PsConst.ONE;
    // return discountRate != null &&
    //     discountRate != '' &&
    //     double.tryParse(discountRate!) != null &&
    //     double.parse(discountRate!) > 0;
  }

  // bool get isBusinessMode {
  //   return businessMode == PsConst.ONE;
  // }

  bool get isPriceGreaterThanZero {
    return originalPrice != null &&
        // price != '' &&
        double.tryParse(originalPrice!) != null &&
        double.parse(originalPrice!) > 0;
  }

  String selectedValuesOfProductRelation(String id) {
    if (productRelation != null) {
      final int index = productRelation!
          .indexWhere((ProductRelation element) => element.coreKeyId == id);
      if (index > -1 && productRelation![index].selectedValues != null) {
        String result = '';
        final bool isMultiValue =
            productRelation![index].selectedValues!.length > 1;
        if (isMultiValue) { //for multi dropdown
          for (SelectedValue selectedValue
              in productRelation![index].selectedValues!) {
            result += selectedValue.value! + ',';
          }
          return result;
        } else {
          return productRelation![index].selectedValues![0].value ?? '';
        }
      } else {
        return '';
      }
    } else {
      return '';
    }
  }
}
