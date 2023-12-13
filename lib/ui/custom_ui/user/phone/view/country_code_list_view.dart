import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/phone/view/country_code_list_view.dart';

class CustomPhoneCountryCodeListView extends StatefulWidget {
  @override
  _CityPhoneSignInContainerViewState createState() =>
      _CityPhoneSignInContainerViewState();
}

class _CityPhoneSignInContainerViewState
    extends State<CustomPhoneCountryCodeListView> {
  @override
  Widget build(BuildContext context) {
    return PhoneCountryCodeListView();
  }
}
