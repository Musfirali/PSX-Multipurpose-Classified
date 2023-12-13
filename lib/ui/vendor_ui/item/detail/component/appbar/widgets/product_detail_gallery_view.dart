import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/viewobject/product.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/repository/gallery_repository.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../common/base/ps_widget_with_appbar_no_app_bar_title.dart';
import '../../../../../common/ps_ui_widget.dart';

class ProductDetailGalleryView extends StatefulWidget {
  const ProductDetailGalleryView({
    Key? key,
  }) : super(key: key);

  @override
  ProductDetailGalleryViewState<ProductDetailGalleryView> createState() =>
      ProductDetailGalleryViewState<ProductDetailGalleryView>();
}

class ProductDetailGalleryViewState<T extends ProductDetailGalleryView>
    extends State<ProductDetailGalleryView> {
  bool bindDataOneTime = true;
  String? selectedId;
  int selectedIndex = 0;
  bool isHaveVideo = false;
  DefaultPhoto? selectedDefaultImage;
  late ItemDetailProvider itemDetailProvider;

  void onImageTap() {
    Navigator.pushNamed(context, RoutePaths.galleryGrid,
        arguments: itemDetailProvider.product);
  }

  @override
  Widget build(BuildContext context) {
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;
    if (product.videoThumbnail!.imgPath != '') {
      selectedDefaultImage = product.videoThumbnail;
      isHaveVideo = true;
    } else {
      selectedDefaultImage = product.defaultPhoto;
      isHaveVideo = false;
    }
    final GalleryRepository galleryRepo =
        Provider.of<GalleryRepository>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    print(
        '............................Build UI Again ............................');
    return PsWidgetWithAppBarNoAppBarTitle<GalleryProvider>(
      initProvider: () {
        return GalleryProvider(repo: galleryRepo);
      },
      onProviderReady: (GalleryProvider provider) {
        provider.loadDataList(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: langProvider.currentLocale.languageCode,
                parentImgId: selectedDefaultImage?.imgParentId,
                imageType: PsConst.ITEM_IMAGE_TYPE));
      },
      builder: (BuildContext context, GalleryProvider provider, Widget? child) {
        if (
            //provider.galleryList != null &&
            provider.galleryList.data != null &&
                provider.galleryList.data!.isNotEmpty) {
          if (bindDataOneTime) {
            if (valueHolder.showItemVideo! && isHaveVideo) {
              provider.tempGalleryList.data!.add(selectedDefaultImage!);
              for (int i = 0;
                  i < valueHolder.maxImageCount &&
                      i < provider.galleryList.data!.length;
                  i++) {
                provider.tempGalleryList.data!
                    .add(provider.galleryList.data![i]);
              }
            } else {
              for (int i = 0;
                  i < valueHolder.maxImageCount &&
                      i < provider.galleryList.data!.length;
                  i++) {
                provider.tempGalleryList.data!
                    .add(provider.galleryList.data![i]);
              }
            }

            for (int i = 0; i < provider.tempGalleryList.data!.length; i++) {
              if (selectedDefaultImage!.imgId ==
                  provider.tempGalleryList.data![i].imgId) {
                selectedIndex = i;
                selectedId = selectedDefaultImage!.imgId;
                break;
              }
            }
            bindDataOneTime = false;
          }
          /**UI Section is here */
          return Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                itemCount: provider.tempGalleryList.data!.length,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions.customChild(
                    child: Stack(
                      children: <Widget>[
                        PsNetworkImageWithUrl(
                          photoKey: '',
                          width: double.infinity,
                          height: 600,
                          imageAspectRation: PsConst.Aspect_Ratio_1x,
                          imagePath:
                              provider.tempGalleryList.data![index].imgPath,
                          onTap: onImageTap,
                          boxfit: BoxFit.cover,
                        ),
                        if (valueHolder.showItemVideo! &&
                            isHaveVideo &&
                            index == 0)
                          GestureDetector(
                            onTap: onImageTap,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: PsDimens.space16),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.play_circle,
                                  color: PsColors.achromatic800,
                                  size: 80,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                onPageChanged: (int i) {
                  if (mounted) {
                    setState(() {
                      selectedId = provider.tempGalleryList.data![i].imgId;
                    });
                  }
                },
                pageController: PageController(initialPage: selectedIndex),
                scrollPhysics: const BouncingScrollPhysics(),
                loadingBuilder:
                    (BuildContext context, ImageChunkEvent? event) =>
                        const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Positioned(
                  bottom: 5.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        //provider.tempGalleryList != null &&
                        provider.tempGalleryList.data!.isNotEmpty
                            ? provider.tempGalleryList.data!
                                .map((DefaultPhoto defaultPhoto) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              selectedId == defaultPhoto.imgId
                                                  ? PsColors.primary500
                                                  : PsColors.achromatic500));
                                });
                              }).toList()
                            : <Widget>[const SizedBox()],
                  ))
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
