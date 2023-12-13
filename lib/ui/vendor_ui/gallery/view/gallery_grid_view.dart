import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/gallery_repository.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/product.dart';
import '../../../custom_ui/gallery/component/grid/gallery_grid_item.dart';
import '../../../custom_ui/gallery/component/grid/gallery_grid_item_for_video.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_ui_widget.dart';

class GalleryGridView extends StatefulWidget {
  const GalleryGridView({
    Key? key,
    required this.product,
    this.onImageTap,
  }) : super(key: key);

  final Product product;
  final Function? onImageTap;
  @override
  _GalleryGridViewState createState() => _GalleryGridViewState();
}

class _GalleryGridViewState extends State<GalleryGridView>
    with SingleTickerProviderStateMixin {
  bool bindDataOneTime = true;
  bool isHaveVideo = false;
  @override
  Widget build(BuildContext context) {
    final GalleryRepository productRepo =
        Provider.of<GalleryRepository>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context, listen: false);     
    print(
        '............................Build UI Again ............................');
    return PsWidgetWithAppBar<GalleryProvider>(
        appBarTitle: 'gallery__title'.tr,
        initProvider: () {
          return GalleryProvider(repo: productRepo);
        },
        onProviderReady: (GalleryProvider provider) {
          provider.loadDataList(
              requestPathHolder: RequestPathHolder(
                languageCode: langProvider.currentLocale.languageCode,
                  parentImgId: widget.product.defaultPhoto!.imgParentId,
                  imageType: PsConst.ITEM_IMAGE_TYPE,
                  loginUserId: valueHolder.loginUserId));

          // provider.loadDataList(
          //     requestPathHolder: RequestPathHolder(
          //         parentImgId: '1',
          //         imageType: PsConst.ITEM_TYPE,
          //         loginUserId: valueHolder.loginUserId));
        },
        builder:
            (BuildContext context, GalleryProvider provider, Widget? child) {
          if (provider.hasData) {
            if (bindDataOneTime) {
              if (valueHolder.showItemVideo! &&
                  widget.product.videoThumbnail!.imgPath != '') {
                provider.tempGalleryList.data!
                    .add(widget.product.videoThumbnail!);
                isHaveVideo = true;
              } else {
                isHaveVideo = false;
                Container();
              }
              for (int i = 0;
                  i < valueHolder.maxImageCount &&
                      i < provider.galleryList.data!.length;
                  i++) {
                provider.tempGalleryList.data!
                    .add(provider.galleryList.data![i]);
              }
              bindDataOneTime = false;
            }
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RefreshIndicator(
                    child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: false,
                        slivers: <Widget>[
                          SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150.0,
                                    childAspectRatio: 1.0),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                if (isHaveVideo && index == 0) {
                                  return CustomGalleryGridItemForVideo(
                                      image:
                                          provider.tempGalleryList.data![index],
                                      product: widget.product);
                                } else {
                                  return CustomGalleryGridItem(
                                    image:
                                        provider.tempGalleryList.data![index],
                                  );
                                }
                              },
                              childCount: provider.tempGalleryList.data!.length,
                            ),
                          )
                        ]),
                    onRefresh: () {
                      return provider.loadDataList(reset: true);
                    },
                  ),
                ),
                PSProgressIndicator(provider.currentStatus)
              ],
            );
          } else {
            return Stack(
              children: <Widget>[
                Container(),
                PSProgressIndicator(provider.currentStatus)
              ],
            );
          }
        });
  }
}
