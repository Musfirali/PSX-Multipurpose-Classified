import '../common/ps_holder.dart';
import '../entry_product_relation.dart';

class ItemEntryParameterHolder extends PsHolder<ItemEntryParameterHolder> {
  ItemEntryParameterHolder(
      {this.title,
      this.description,
      this.catId,
      this.subCatId,
      this.itemLocationId,
      this.itemLocationTownshipId,
      this.percent,
      this.latitude,
      this.longitude,
      this.itemCurrencyId,
      this.originalPrice,
      this.isSoldOut,
      this.addedUserId,
      this.id,
      this.productRelation,
      this.phoneNumList,
      // this.status,
      // this.isAvailable,
      // this.isDiscount,
      });

  final String? title;
  final String? description;
  final String? catId;
  final String? subCatId;
  final String? itemLocationId;
  final String? itemLocationTownshipId;
  final String? percent;
  final String? latitude;
  final String? longitude;
  final String? itemCurrencyId;
  final String? isSoldOut;
  final String? originalPrice;
  final String? addedUserId;
  final String? id;
  final List<EntryProductRelation>? productRelation;
  final String? phoneNumList;

  // final String? status;
  // final String? isAvailable;
  // final String? isDiscount;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['title'] = title;
    map['description'] = description;
    map['category_id'] = catId;
    map['subcategory_id'] = subCatId;
    map['location_city_id'] = itemLocationId;
    map['location_township_id'] = itemLocationTownshipId;
    map['percent'] = percent;
    map['lat'] = latitude;
    map['lng'] = longitude;
    map['currency_id'] = itemCurrencyId;
    map['is_sold_out'] = isSoldOut;
    map['original_price'] = originalPrice;
    map['added_user_id'] = addedUserId;
    map['id'] = id;
    map['product_relation'] =
        EntryProductRelation().toMapList(productRelation!);
    map['phone'] = phoneNumList;    
    // map['status'] = status;
    // map['is_available'] = isAvailable;
    // map['is_discount'] = isDiscount;
    return map;
  }

  @override
  ItemEntryParameterHolder fromMap(dynamic dynamicData) {
    return ItemEntryParameterHolder(
      title: dynamicData['title'],
      description: dynamicData['description'],
      catId: dynamicData['category_id'],
      subCatId: dynamicData['subcategory_id'],
      itemLocationId: dynamicData['location_city_id'],
      itemLocationTownshipId: dynamicData['location_township_id'],
      percent: dynamicData['percent'],
      latitude: dynamicData['lat'],
      longitude: dynamicData['lng'],
      itemCurrencyId: dynamicData['currency_id'],
      isSoldOut: dynamicData['is_sold_out'],
      originalPrice: dynamicData['original_price'],
      addedUserId: dynamicData['added_user_id'],
      id: dynamicData['id'],
      productRelation:
          EntryProductRelation().fromMapList(dynamicData['product_relation']),
      phoneNumList: dynamicData['phone'],    
      // status: dynamicData['status'],
      // isAvailable: dynamicData['is_available'],
      // isDiscount: dynamicData['is_discount'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (title != '') {
      key += title!;
    }

    if (description != '') {
      key += description!;
    }

    if (catId != '') {
      key += catId!;
    }
    if (subCatId != '') {
      key += subCatId!;
    }

    if (itemLocationId != '') {
      key += itemLocationId!;
    }

    if (itemLocationTownshipId != '') {
      key += itemLocationTownshipId!;
    }

    if (percent != '') {
      key += percent!;
    }

    if (latitude != '') {
      key += latitude!;
    }
    if (longitude != '') {
      key += longitude!;
    }

    if (itemCurrencyId != '') {
      key += itemCurrencyId!;
    }

    if (originalPrice != '') {
      key += originalPrice!;
    }

    if (isSoldOut != '') {
      key += isSoldOut!;
    }

    if (addedUserId != '') {
      key += addedUserId!;
    }

    if (id != '') {
      key += id!;
    }

    if (phoneNumList != '') {
      key += phoneNumList!;
    }

    return key;
  }
}
