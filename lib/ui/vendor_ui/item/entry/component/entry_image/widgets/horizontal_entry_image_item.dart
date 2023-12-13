import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/default_image_text_widget.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/empty_image_item.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/empty_video_Item.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/image_item_for_already_uploaded.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/image_item_for_camera.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/image_item_for_gallery.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/video_Item_for_already_uploaded.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/video_item_for_offline_video.dart';

class HorizontalEntryImageItem extends StatefulWidget {
  const HorizontalEntryImageItem(
      {Key? key,
      required this.index,
      required this.addNewItem,
      required this.onTap})
      : super(key: key);

  final int index;
  final String addNewItem;
  final Function onTap;
  @override
  State<StatefulWidget> createState() {
    return HorizontalEntryImageItemState();
  }
}

class HorizontalEntryImageItemState extends State<HorizontalEntryImageItem> {
  late ItemEntryProvider itemEntryProvider;
  late PsValueHolder valueHolder;

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    Widget imageItem = const SizedBox();
    try {
      itemEntryProvider = Provider.of<ItemEntryProvider>(context);
    } on ProviderNotFoundException catch (_) {
      return imageItem;
    }

    if (itemEntryProvider.hasGalleryImageAtIndex(widget.index))
      imageItem = CustomGalleryImageItem(
          index: widget.index, onDeleteGalleryImage: onDeleteGalleryImage);
    else if (itemEntryProvider.hasCameraImageAtIndex(widget.index))
      imageItem = CustomCameraImageItem(
          index: widget.index, onDeleteCameraImage: onDeleteCameraImage);
    else if (itemEntryProvider.hasAlreadyUploadedImageAtIndex(widget.index))
      imageItem = CustomAlreadyUploadedImageItem(
        index: widget.index,
        onDeleteItemImage: onDeleteItemImage,
      );
    else if (itemEntryProvider.hasOfflineVideoToUpload(widget.index))
      imageItem = CustomOfflineVideoItem();
    else if (itemEntryProvider.hasAlreadyUploadedVideo(widget.index))
      imageItem = CustomAlreadyUploadedVideo(
        onVideoDelete: onDeleteItemVideo,
      );
    else if (widget.index >= 0) //for images
      imageItem = CustomEmptyImageItem();
    else //for video
      imageItem = CustomEmptyVideoItem();

    /**
     * UI SECTION
     */
    return Visibility(
      visible: widget.index <= itemEntryProvider.currentIndexCount,
      child: Container(
        margin: const EdgeInsets.only(right: PsDimens.space16),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: <Widget>[
              InkWell(
                onTap: widget.onTap as void Function(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(PsDimens.space4),
                  child: imageItem,
                ),
              ),
              if (widget.index == 0)
                Positioned(
                    child: CustomDefaultImageTextWidget(), top: 1, right: 1),
            ],
          ),
        ),
      ),
    );
  }

  void onDeleteItemImage() {
    //already uploaded image delete
    setState(() {
      itemEntryProvider.alreadyUploadedImages[widget.index]!.imgId = '';
      itemEntryProvider.alreadyUploadedImages[widget.index] =
          DefaultPhoto(imgId: '', imgPath: '');
    });
  }

  void onDeleteGalleryImage() {
    setState(() {
      itemEntryProvider.galleryImagePath[widget.index] = null;
      itemEntryProvider.isImageSelected[widget.index] = false;
    });
  }

  void onDeleteCameraImage() {
    setState(() {
      itemEntryProvider.cameraImagePath[widget.index] = null;
      itemEntryProvider.isImageSelected[widget.index] = false;
    });
  }

  void onDeleteItemVideo() {
    setState(() {
      final ItemEntryProvider itemEntryProvider =
          Provider.of<ItemEntryProvider>(context, listen: false);
      itemEntryProvider.item!.video!.imgId = '';
      itemEntryProvider.item!.videoThumbnail!.imgId = '';
      itemEntryProvider.item!.video = null;
      itemEntryProvider.item!.videoThumbnail = null;
    });
  }
}
