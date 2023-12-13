import 'package:flutter/cupertino.dart';

import '../../../../core/vendor/viewobject/holder/intent_holder/all_search_intent_holder.dart';
import '../../../vendor_ui/all_search/view/all_search_result_view_container.dart';

class CustomAllSearchResultView extends StatefulWidget {
  const CustomAllSearchResultView({required this.allSearchIntentHolder});
  final AllSearchIntentHolder allSearchIntentHolder;
  @override
  State<StatefulWidget> createState() => _AllSearchViewState();
}

class _AllSearchViewState extends State<CustomAllSearchResultView> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.text = widget.allSearchIntentHolder.keyword;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AllSearchResultView(
        allSearchIntentHolder: widget.allSearchIntentHolder);
  }
}
