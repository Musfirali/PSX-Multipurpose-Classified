import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../custom_ui/item/entry/component/entry_image/widgets/horizontal_entry_image_item.dart';
import '../../../../../custom_ui/item/entry/component/entry_image/widgets/video_play_button.dart';
import '../../../../common/dialog/choose_camera_type_dialog.dart';
import '../../../../common/dialog/error_dialog.dart';

class ImageUploadHorizontalList extends StatefulWidget {
  const ImageUploadHorizontalList({
    required this.addNewItem,
    required this.maxImageCount,
  });
  final String? addNewItem;
  final int maxImageCount;

  @override
  ImageUploadHorizontalListState<ImageUploadHorizontalList> createState() =>
      ImageUploadHorizontalListState<ImageUploadHorizontalList>();
}

class ImageUploadHorizontalListState<T extends ImageUploadHorizontalList>
    extends State<ImageUploadHorizontalList> {
  late ItemEntryProvider itemEntryProvider;
  late GalleryProvider? galleryProvider;
  late PsValueHolder psValueHolder;

  //images
  late List<DefaultPhoto?> _alreadyUploadedImages;
  late List<XFile?> _galleryImagePath;
  late List<String?> _cameraImagePath;
  late List<bool> _isImageSelected;

  List<Widget> _imageWidgetList = <Widget>[];
  late Widget _videoWidget;
  XFile? defaultAssetImage;
  DefaultPhoto? defaultUrlImage;

  bool bindImageFirstTime = true;

  @override
  void initState() {
    /**
     * Here, there are three types of images 
     * 1. image from gallery
     * 2. image from custom camera
     * 3. user's already uploaded image
     */
    _isImageSelected =
        List<bool>.generate(widget.maxImageCount, (int index) => false);
    _galleryImagePath =
        List<XFile?>.generate(widget.maxImageCount, (int index) => null);
    _cameraImagePath =
        List<String?>.generate(widget.maxImageCount, (int index) => null);
    _alreadyUploadedImages = List<DefaultPhoto?>.generate(widget.maxImageCount,
        (int index) => DefaultPhoto(imgId: '', imgPath: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    itemEntryProvider = Provider.of<ItemEntryProvider>(context);
    itemEntryProvider.isImageSelected = _isImageSelected;
    itemEntryProvider.galleryImagePath = _galleryImagePath;
    itemEntryProvider.cameraImagePath = _cameraImagePath;
    itemEntryProvider.alreadyUploadedImages = _alreadyUploadedImages;

    return Consumer<GalleryProvider>(builder:
        (BuildContext context, GalleryProvider provider, Widget? child) {
      galleryProvider = provider;
      if (bindImageFirstTime && provider.galleryList.data!.isNotEmpty) {
        for (int i = 0;
            i < widget.maxImageCount && i < provider.galleryList.data!.length;
            i++) {
          if (provider.galleryList.data![i].imgId != null) {
            itemEntryProvider.alreadyUploadedImages[i] =
                provider.galleryList.data![i];
            itemEntryProvider.currentIndexCount++;
          }
        }
        bindImageFirstTime = false;
      }

      _videoWidget = Visibility(
        visible: psValueHolder.showItemVideo!,
        child: CustomHorizontalEntryImageItem(
          index: -1,
          addNewItem: widget.addNewItem!,
          onTap: chooseVideo,
        ),
      );

      _imageWidgetList = List<Widget>.generate(
          psValueHolder.maxImageCount,
          (int index) => CustomHorizontalEntryImageItem(
                key: Key('$index'),
                addNewItem: widget.addNewItem!,
                index: index,
                onTap: () {
                  chooseImages(index);
                },
              ));

      /**
       * UI SECTION
       */
      return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            top: PsDimens.space16,
            bottom: PsDimens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Photo'.tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: PsDimens.space8),
              height: PsDimens.space100,
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  onReorder(oldIndex, newIndex);
                },
                // header: _videoWidget,
                children: _imageWidgetList,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'You can upload up to ${widget.maxImageCount} photos.'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50),
              ),
            ),
            if (psValueHolder.showItemVideo!)
              Container(
                margin: const EdgeInsets.only(
                    bottom: PsDimens.space8, top: PsDimens.space16, right: PsDimens.space16),
                child: Text(
                  'Video'.tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (psValueHolder.showItemVideo!)
              Row(
                children: <Widget>[
                  _videoWidget,
                  if (itemEntryProvider.hasVideo) CustomVideoPlayButton()
                ],
              ),
          ],
        ),
      );
    });
  }

  dynamic onReorder(int oldIndex, int newIndex) {
    if (itemEntryProvider.hasGalleryImageAtIndex(oldIndex)) {
      // gallery[old] <-> gallery[new]
      if (itemEntryProvider.hasGalleryImageAtIndex(newIndex)) {
        itemEntryProvider.swapGalleryImages(oldIndex, newIndex);
      }
      // gallery[old] <-> camera[new]
      else if (itemEntryProvider.hasCameraImageAtIndex(newIndex)) {
        itemEntryProvider.swapGalleryAndCameraImage(oldIndex, newIndex);
      }
      // gallery[old] <-> already_uploaded[new]
      else if (itemEntryProvider.hasAlreadyUploadedImageAtIndex(newIndex)) {
        itemEntryProvider.swapGalleryAndAlreadyUploadedImage(
            oldIndex, newIndex);
      }
      // move gallery image to new index
      // else {
      //   itemEntryProvider.moveGalleryImageToNewIndex(oldIndex, newIndex);
      // }
    } else if (itemEntryProvider.hasCameraImageAtIndex(oldIndex)) {
      // camera[old] <-> gallery[new]
      if (itemEntryProvider.hasGalleryImageAtIndex(newIndex)) {
        itemEntryProvider.swapGalleryAndCameraImage(newIndex, oldIndex);
      }
      // camera[old] <-> camera[new]
      else if (itemEntryProvider.hasCameraImageAtIndex(newIndex)) {
        itemEntryProvider.swapCameraImages(oldIndex, newIndex);
      }
      // camera[old] <-> already_uploaded[new]
      else if (itemEntryProvider.hasAlreadyUploadedImageAtIndex(newIndex)) {
        itemEntryProvider.swapCameraImageWithAlreadyUploadedImage(
            oldIndex, newIndex);
      }
      // else {
      //   itemEntryProvider.moveCameraImageToNewIndex(oldIndex, newIndex);
      // }
    } else if (itemEntryProvider.hasAlreadyUploadedImageAtIndex(oldIndex)) {
      // already_uploaded[old] <-> gallery[new]
      if (itemEntryProvider.hasGalleryImageAtIndex(newIndex)) {
        itemEntryProvider.swapGalleryAndAlreadyUploadedImage(
            newIndex, oldIndex);
      }
      // already_uploaded[old] <-> camera[new]
      else if (itemEntryProvider.hasCameraImageAtIndex(newIndex)) {
        itemEntryProvider.swapCameraImageWithAlreadyUploadedImage(
            newIndex, oldIndex);
      }
      // already_uploaded[old] <-> already_uploaded[new]
      else if (itemEntryProvider.hasAlreadyUploadedImageAtIndex(newIndex)) {
        itemEntryProvider.swapAlreadyUploadedImages(oldIndex, newIndex);
      }
      // else {
      //   itemEntryProvider.moveAlreadyUploadedImageToNewIndex(oldIndex, newIndex);
      // }
    }
  }

  Future<void> chooseImages(int index) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (psValueHolder.isCustomCamera) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ChooseCameraTypeDialog(
              //custom camera
              onCameraTap: () async {
                final dynamic returnData =
                    await Navigator.pushNamed(context, RoutePaths.cameraView);
                if (returnData is String) {
                  updateEntryImagesFromCustomCamera(returnData, index);
                }
              },
              onGalleryTap: () {
                //gallery
                if (widget.addNewItem == PsConst.ADD_NEW_ITEM) {
                  loadPickMultiImageFromGallery(index);
                } else {
                  loadSingleImageFromGallery(index);
                }
              },
            );
          });
    } else {
      //gallery
      if (widget.addNewItem == PsConst.ADD_NEW_ITEM) {
        loadPickMultiImageFromGallery(index);
      } else {
        loadSingleImageFromGallery(index);
      }
    }
  }

  Future<void> chooseVideo() async {
    List<PlatformFile>? newVideoFile = <PlatformFile>[];
    try {
      newVideoFile = (await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (newVideoFile != null) {
      final File pickedVideo = File(newVideoFile[0].path!);
      final VideoPlayerController videoPlayer =
          VideoPlayerController.file(pickedVideo);
      await videoPlayer.initialize();

      final int maximumSecond =
          int.parse(psValueHolder.videoDuration ?? '60000');
      final int videoDuration = videoPlayer.value.duration.inMilliseconds;

      if (videoDuration < maximumSecond) {
        await getThumbnailImageFromVideo(pickedVideo.path);
        updateEntryVideo(pickedVideo.path, -2);
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                  message:
                      'Sorry, the video duration must not exceed than ${maximumSecond / 1000} seconds.');
            });
      }
    }
  }

  Future<void> loadPickMultiImageFromGallery(int index) async {
    final ImagePicker _picker = ImagePicker();
    List<XFile> resultList = <XFile>[];

    try {
      resultList = await _picker.pickMultiImage();
    } on Exception catch (e) {
      e.toString();
    }
    if (!mounted) {
      return;
    }
    for (int i = 0; i < resultList.length; i++) {
      if (resultList[i].name.contains('.webp')) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__webp_image'.tr,
              );
            });
        return;
      }
    }
    updateEntryImagesFromGallery(resultList, -1, index);
  }

  Future<void> loadSingleImageFromGallery(int index) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile> resultList = <XFile>[];

    try {
      final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) 
        resultList.add(imageFile);
    } on Exception catch (e) {
      e.toString();
    }
    if (!mounted) {
      return;
    }
    for (int i = 0; i < resultList.length; i++) {
      if (resultList[i].name.contains('.webp')) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__webp_image'.tr,
              );
            });
        return;
      }
    }
    updateEntryImagesFromGallery(resultList, index, index);
  }

  dynamic updateEntryImagesFromGallery(
      List<XFile> resultList, int index, int currentIndex) {
    setState(() {
      //for single select image
      if (index != -1 && resultList.isNotEmpty) {
        itemEntryProvider.galleryImagePath[currentIndex] = resultList[0];
        itemEntryProvider.cameraImagePath[currentIndex] = null;
        itemEntryProvider.isImageSelected[currentIndex] = true;
        if (itemEntryProvider.currentIndexCount ==
            currentIndex) //ui image count control
          itemEntryProvider.currentIndexCount = currentIndex + 1;
      }
      //end single select image

      //for multi select
      if (index == -1) {
        int indexToStart = 0; //find the right starting_index for storing images
        for (indexToStart = 0; indexToStart < currentIndex; indexToStart++) {
          if (!itemEntryProvider.isImageSelected[
              indexToStart]) //start where image is unselected yet
            break;
        }
        for (int i = 0;
            i < resultList.length && indexToStart < psValueHolder.maxImageCount;
            i++, indexToStart++) {
          itemEntryProvider.galleryImagePath[indexToStart] = resultList[i];
          itemEntryProvider.cameraImagePath[indexToStart] = null;
          itemEntryProvider.isImageSelected[indexToStart] = true;
          if (itemEntryProvider.currentIndexCount ==
              indexToStart) //ui image count control
            itemEntryProvider.currentIndexCount = indexToStart + 1;
        }
      }
      //end multi select
    });
  }

  dynamic updateEntryImagesFromCustomCamera(String imagePath, int index) {
    if (mounted) {
      setState(() {
        //for single select image
        if (imagePath.isNotEmpty) {
          itemEntryProvider.galleryImagePath[index] = null;
          itemEntryProvider.cameraImagePath[index] = imagePath;
          itemEntryProvider.isImageSelected[index] = true;
          if (itemEntryProvider.currentIndexCount ==
              index) //ui image count control
            itemEntryProvider.currentIndexCount = index + 1;
        }
      });
    }
  }

  dynamic getThumbnailImageFromVideo(String videoPathUrl) async {
    itemEntryProvider.newVideoThumbnailPath =
        await VideoThumbnail.thumbnailFile(
      video: videoPathUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  }

  dynamic updateEntryVideo(String imagePath, int index) {
    if (mounted) {
      setState(() {
        if (index == -2 && imagePath.isNotEmpty) {
          itemEntryProvider.newVideoFilePath = imagePath;
          itemEntryProvider.isSelectedVideoImagePath = true;
        }
      });
    }
  }
}
