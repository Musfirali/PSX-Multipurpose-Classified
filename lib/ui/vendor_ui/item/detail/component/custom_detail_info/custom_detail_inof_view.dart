import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/product/product_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../core/vendor/viewobject/product_relation.dart';
import '../../../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../../../../../core/vendor/viewobject/selected_value.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../common/custom_ui/ps_detail_custom_widget.dart';

class CustomDetailInfoView extends StatefulWidget {
  // const CustomDetailInfoView({
  //   Key? key,
  //   this.item,
  // }) : super(key: key);

  // final Product? item;

  @override
  State<CustomDetailInfoView> createState() => _CustomDetailInfoViewState();
}

class _CustomDetailInfoViewState extends State<CustomDetailInfoView> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationTownshipController =
      TextEditingController();
  final TextEditingController currencySymbolController =
      TextEditingController();
  final TextEditingController userInputDiscount = TextEditingController();
  final TextEditingController userInputPriceController =
      TextEditingController();

  List<CustomField> customFieldList = <CustomField>[];
  late Product? itemData;
  late PsValueHolder valueHolder;
  bool bindDataFirstTime = true;
  bool bindEntryDataFirstTime = true;
    late ItemDetailProvider itemDetailProvider;



  final List<String> removeIdList = <String>[
    'ps-itm00009', // item address

  ];


  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
     itemDetailProvider = Provider.of<ItemDetailProvider>(context,);
        itemData = itemDetailProvider.product;
    return SliverToBoxAdapter(
      child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
          ItemEntryFieldProvider provider, Widget? child) {
        if (!provider.hasData) {
          return const SizedBox();
        } else {
          customFieldList =
              provider.itemEntryField.data?.customField ?? <CustomField>[];
               for (String id in removeIdList)
            customFieldList
                .removeWhere((CustomField element) => element.coreKeyId == id);
          return Container(
            margin: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: customFieldList.length,
                itemBuilder: (BuildContext context, int index) {
                  final CustomField customField = customFieldList[index];
                  final TextEditingController valueTextController =
                      TextEditingController();
                  final TextEditingController idTextController =
                      TextEditingController();

                  if (customField.coreKeyId != null) {
                    itemData?.productRelation
                        ?.forEach((ProductRelation element) {
                      if (element.coreKeyId == customField.coreKeyId &&
                          element.selectedValues!.isNotEmpty) {
                        if (customField.uiType?.coreKeyId !=
                            PsConst.MULTI_SELECTION) {
                          idTextController.text =
                              element.selectedValues?[0].id.toString() ?? '';
                          valueTextController.text =
                              element.selectedValues?[0].value! ?? '';
                        } else {
                          final List<String> idList = <String>[];
                          final List<String> values = <String>[];
                          element.selectedValues
                              ?.forEach((SelectedValue element) {
                            idList.add(element.id.toString());
                            values.add(element.value.toString());
                          });
                          idTextController.text = idList.join(',');
                          valueTextController.text = values.join(',');
                        }
                      }
                    });
                    //  }

                    if (!provider.textControllerMap.containsKey(customField)) {
                      provider.textControllerMap.putIfAbsent(
                        customField,
                        () => SelectedObject(
                          valueTextController: valueTextController,
                          idTextController: idTextController,
                        ),
                      );
                    }
                  }
                  return PsDetailCustomWidget(
                    customField: customField,
                    valueTextController: valueTextController,
                    idTextController: idTextController,
                  );
                }),

            // ),
            //    ],
          );
        }
      }),
    );
  }
}
