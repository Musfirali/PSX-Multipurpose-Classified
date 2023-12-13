import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/product_parameter_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/item_entry_field_repository.dart';
import '../../viewobject/core_field.dart';
import '../../viewobject/custom_field.dart';
import '../../viewobject/product_entry_field.dart';
import '../../viewobject/selected_object.dart';
import '../common/ps_provider.dart';

class ItemEntryFieldProvider extends PsProvider<ItemEntryField> {
  ItemEntryFieldProvider(
      {required ItemEntryFieldRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<ItemEntryField> get itemEntryField => data;

  Map<CustomField, SelectedObject> textControllerMap =
      <CustomField, SelectedObject>{};

  CoreField titleCoreField = CoreField(visible: '0');
  CoreField categoryCoreField = CoreField(visible: '0');
  CoreField subCategoryCoreField = CoreField(visible: '0');
  CoreField phoneNumCoreField = CoreField(visible: '0');
  CoreField currencySymbolCoreField = CoreField(visible: '0');
  CoreField priceCoreField = CoreField(visible: '0');
  CoreField discountRateCoreField = CoreField(visible: '0');
  CoreField descriptionCoreField = CoreField(visible: '0');
  CoreField cityCoreField = CoreField(visible: '0');
  CoreField townshipCoreField = CoreField(visible: '0');

  CustomField addressTitleCoreField = CustomField(visible: '0');

  bool isPickUpOnMap = false;
final ProductParameterHolder parameterHolder=   ProductParameterHolder().getLatestParameterHolder();

  CoreField getCoreFieldByFieldName(String id) {
    final int index = itemEntryField.data?.coreField?.indexWhere((CoreField element) => element.fieldName == id) ?? -1;
    if (index >= 0) {
      return itemEntryField.data!.coreField!.elementAt(index);
    } else {
      return CoreField(visible: '0');
    }
  }

  CustomField getCustomFieldByCoreKeyId(String id) {
    final int index = itemEntryField.data?.customField?.indexWhere((CustomField element) => element.coreKeyId == id) ?? -1;
    if (index >= 0) {
      return itemEntryField.data!.customField!.elementAt(index);
    } else {
      return CustomField(visible: '0');
    }
  }
}

SingleChildWidget initItemEntryProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
  String? catId,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

  return psInitProvider<ItemEntryFieldProvider>(
      widget: widget,
      initProvider: () => ItemEntryFieldProvider(
            repo: Provider.of<ItemEntryFieldRepository>(context),
          ),
      onProviderReady: (ItemEntryFieldProvider provider) {
        provider.loadData(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: valueHolder.languageCode,
                categoryId: catId));
        function(provider);
      });
}
