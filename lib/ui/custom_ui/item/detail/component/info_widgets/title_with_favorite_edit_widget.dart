import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/detail/component/info_widgets/title_with_favorite_edit_widget.dart';

class CustomTitleWithEditAndFavoriteWidget extends StatefulWidget {
  const CustomTitleWithEditAndFavoriteWidget(
      {Key? key, required this.heroTagTitle})
      : super(key: key);

  final String? heroTagTitle;

  @override
  TitleWithEditAndFavoriteWidgetState createState() =>
      TitleWithEditAndFavoriteWidgetState();
}

class TitleWithEditAndFavoriteWidgetState
    extends State<CustomTitleWithEditAndFavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return TitleWithEditAndFavoriteWidget(heroTagTitle: widget.heroTagTitle);
  }
}
