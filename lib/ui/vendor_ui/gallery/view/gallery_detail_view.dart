
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/gallery_repository.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/gallery/component/detail/close_photo_view_icon.dart';
import '../../common/base/ps_widget_with_appbar_no_app_bar_title.dart';
import '../../common/ps_ui_widget.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({
    Key? key,
    required this.selectedDefaultImage,
  }) : super(key: key);

  final DefaultPhoto selectedDefaultImage;

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    final GalleryRepository galleryRepo =
        Provider.of<GalleryRepository>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context, listen: false);      
    print(
        '............................Build UI Again ............................');
    return PsWidgetWithAppBarNoAppBarTitle<GalleryProvider>(
      initProvider: () {
        return GalleryProvider(repo: galleryRepo);
      },
      onProviderReady: (GalleryProvider provider) {
        provider.loadDataList(
            requestPathHolder: RequestPathHolder(
              languageCode: langProvider.currentLocale.languageCode,
                parentImgId: widget.selectedDefaultImage.imgParentId,
                imageType: PsConst.ITEM_IMAGE_TYPE));
      },
      builder: (BuildContext context, GalleryProvider provider, Widget? child) {
        if (provider.galleryList.data != null &&
            provider.galleryList.data!.isNotEmpty) {
          int selectedIndex = 0;
          for (int i = 0; i < provider.galleryList.data!.length; i++) {
            if (widget.selectedDefaultImage.imgId ==
                provider.galleryList.data![i].imgId) {
              selectedIndex = i;
              break;
            }
          }

          return Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                itemCount: valueHolder.maxImageCount <
                        provider.galleryList.data!.length
                    ? valueHolder.maxImageCount
                    : provider.galleryList.data!.length,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions.customChild(
                    child: PsNetworkImageWithUrl(
                      photoKey: '',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imagePath: provider.galleryList.data![index].imgPath,
                      boxfit: BoxFit.contain,
                      imageAspectRation: PsConst.Aspect_Ratio_full_image,
                    ),
                    childSize: MediaQuery.of(context).size,
                  );
                },
                pageController: PageController(initialPage: selectedIndex),
                scrollPhysics: const BouncingScrollPhysics(),
                loadingBuilder:
                    (BuildContext context, ImageChunkEvent? event) =>
                        const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              CustomClosePhotoViewIcon(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
