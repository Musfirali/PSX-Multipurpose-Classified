import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../custom_ui/item/entry/component/item_entry_view.dart';

class ItemEntryContainerView extends StatefulWidget {
  const ItemEntryContainerView({
    required this.flag,
    required this.categoryId,
    required this.categoryName,
    required this.item,
    this.isFromChat
  });
  final String flag;
  final Product? item;
  final String categoryId;
  final String categoryName;
  final bool? isFromChat;

  @override
  ItemEntryContainerViewState<ItemEntryContainerView> createState() =>
      ItemEntryContainerViewState<ItemEntryContainerView>();
}

class ItemEntryContainerViewState<T extends ItemEntryContainerView>
    extends State<ItemEntryContainerView> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, false);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    /**
     * UI Section
     *  */
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
          backgroundColor: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
          iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.primary500
                  : PsColors.achromatic50),
          title: Text(
            'item_entry__listing_entry'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Utils.isLightMode(context)
                    ? PsColors.primary500
                    : PsColors.achromatic50),
          ),
          elevation: 0,
        ),
        body: CustomItemEntryView(
          animationController: animationController,
          flag: widget.flag,
          item: widget.item,
          categoryId: widget.categoryId,
          categoryName: widget.categoryName,
          maxImageCount: psValueHolder.maxImageCount,
          isFromChat: widget.isFromChat
        ),
      ),
    );
  }
}
