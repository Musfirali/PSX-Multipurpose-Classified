import 'package:flutter/material.dart';

class PhoneNoController {
  PhoneNoController(
      {required this.countryCodeController, required this.phoneNumController});

  TextEditingController countryCodeController;
  TextEditingController phoneNumController;

  static String getPhoneNumList(List<PhoneNoController> phoneList) {
    String result = '';
    for (PhoneNoController obj in phoneList) {
      if (obj.countryCodeController.text.isNotEmpty &&
          obj.phoneNumController.text.isNotEmpty)
        result += obj.countryCodeController.text +
            '-' +
            obj.phoneNumController.text +
            '#';
    }
    return result;
  }
}
