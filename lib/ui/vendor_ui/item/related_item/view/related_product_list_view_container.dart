import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../custom_ui/item/related_item/component/vertical/related_product_list_view.dart';
import '../../../common/base/ps_widget_with_appbar.dart';
import '../../../common/ps_ui_widget.dart';

class RelatedProductListViewContainer extends StatefulWidget {
  const RelatedProductListViewContainer({
    required this.productId,
    required this.categoryId,
  });
  final String? productId;
  final String categoryId;

  @override
  _RelatedProductListViewState createState() {
    return _RelatedProductListViewState();
  }
}

class _RelatedProductListViewState
    extends State<RelatedProductListViewContainer>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late RelatedProductProvider relatedProductProvider;

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
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     relatedProductProvider.loadNextRelatedProductList(
    //         categoryId: widget.categoryId,
    //         loginUserId: Utils.checkUserLoginId(psValueHolder),
    //         productId: widget.productId);
    //   }
    // });
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
      child: PsWidgetWithAppBar<RelatedProductProvider>(
          appBarTitle: 'related_product_tile__related_product'.tr,
          initProvider: () {
            return RelatedProductProvider(
                repo: repo1!, psValueHolder: psValueHolder!);
          },
          onProviderReady: (RelatedProductProvider provider) {
            relatedProductProvider = provider;
            relatedProductProvider.loadRelatedProductList(
              dataConfiguration: DataConfiguration(
                  dataSourceType: DataSourceType.SERVER_DIRECT),
              productId: widget.productId,
              categoryId: widget.categoryId,
              languageCode: langProvider.currentLocale.languageCode,
              loginUserId: Utils.checkUserLoginId(psValueHolder),
            );
          },
          builder: (BuildContext context, RelatedProductProvider provider,
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
                          if (provider.hasData)
                            CustomRelatedProductList(
                              animationController: animationController,
                            ),
                        ]),
                    onRefresh: () async {
                      //     provider.resetRelatedItemList(
                      //         dataConfig: DataConfiguration(
                      // dataSourceType: DataSourceType.SERVER_DIRECT),
                      //         categoryId: widget.categoryId,
                      //         productId: widget.productId,
                      //         loginUserId: Utils.checkUserLoginId(psValueHolder));
                    },
                  )),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
    );
  }
}
