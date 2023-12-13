import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/delete_uploaded_image_icon.dart';
import '../../../../../common/ps_ui_widget.dart';

class AlreadyUploadedImageItem extends StatelessWidget {
  const AlreadyUploadedImageItem({required this.index, required this.onDeleteItemImage});
  final int index;
  final Function onDeleteItemImage;
  @override
  Widget build(BuildContext context) {
    final ItemEntryProvider itemEntryProvider =
        Provider.of<ItemEntryProvider>(context);
    return Stack(
      children: <Widget>[
        PsNetworkImageWithUrl(
          photoKey: '',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          imageAspectRation: PsConst.Aspect_Ratio_1x,
          imagePath: itemEntryProvider.alreadyUploadedImages[index]!.imgPath,
        ),
        Positioned(
          child: index == 0
              ? const SizedBox()
              : CustomDeleteUploaedImageIcon(
                  alreadyUploadedImage: itemEntryProvider.alreadyUploadedImages[index]!,
                  onDeleteItemImage: (){
                    onDeleteItemImage();
                  }),
          right: 1,
          top: 1,
        ), 
      ],
    );
  }
}
