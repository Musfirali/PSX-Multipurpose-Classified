

import 'dart:convert';

import 'package:http/http.dart';

import '../../constant/ps_constants.dart';

class PsApiResponse {
  PsApiResponse(Response response) {
    code = response.statusCode;

    if (isSuccessful) {
      body = response.body;
      errorMessage = '';
    } else if (totallyNoRecord) { //Create Error Message(TOTALLY_NO_RECORD##totally no record)
      body = null;
      errorMessage = PsConst.TOTALLY_NO_RECORD + '##' + 'totally no record';
    } else {
      body = null;
      try {
        final dynamic hashMap = json.decode(response.body);
        print(hashMap['message']);
        errorMessage = hashMap['message'];
      } catch (error) {
        print('Timeout Error');
        errorMessage = 'Timeout Error';
      }
    }
  }
  int code = 0;
  String? body;
  String errorMessage = '';

  bool get isSuccessful {
    return code == 200 || code == 201; // between 200 and 300 (before)
  }

  bool get totallyNoRecord {
    return code == 204;
  }

  /**
   * 200, 201 --> Success
   * 200 with black array [ ] --> No data at pagination
   * 204  --> Totally No Record
   * 
   */

}
