import 'common/ps_object.dart';

class MobileColor extends PsObject<MobileColor> {
  MobileColor(
      {this.primary50,
      this.primary100,
      this.primary200,
      this.primary300,
      this.primary400,
      this.primary500,
      this.primary600,
      this.primary700,
      this.primary800,
      this.primary900,
      this.text50,
      this.text100,
      this.text200,
      this.text300,
      this.text400,
      this.text500,
      this.text600,
      this.text700,
      this.text800,
      this.text900,
      this.accent50,
      this.accent100,
      this.accent200,
      this.accent300,
      this.accent400,
      this.accent500,
      this.accent600,
      this.accent700,
      this.accent800,
      this.accent900,
      this.success50,
      this.success100,
      this.success200,
      this.success300,
      this.success400,
      this.success500,
      this.success600,
      this.success700,
      this.success800,
      this.success900,
      this.error50,
      this.error100,
      this.error200,
      this.error300,
      this.error400,
      this.error500,
      this.error600,
      this.error700,
      this.error800,
      this.error900,
      this.warning50,
      this.warning100,
      this.warning200,
      this.warning300,
      this.warning400,
      this.warning500,
      this.warning600,
      this.warning700,
      this.warning800,
      this.warning900,
      this.info50,
      this.info100,
      this.info200,
      this.info300,
      this.info400,
      this.info500,
      this.info600,
      this.info700,
      this.info800,
      this.info900,
      this.achromatic50,
      this.achromatic100,
      this.achromatic200,
      this.achromatic300,
      this.achromatic400,
      this.achromatic500,
      this.achromatic600,
      this.achromatic700,
      this.achromatic800,
      this.achromatic900,
      this.appleColor,
      this.facebookColor,
      this.googleColor,
      this.paypalColor,
      this.paystackColor,
      this.phoneColor,
      this.razorColor,
      this.stripeColor});

  String? primary50;
  String? primary100;
  String? primary200;
  String? primary300;
  String? primary400;
  String? primary500;
  String? primary600;
  String? primary700;
  String? primary800;
  String? primary900;

  String? text50;
  String? text100;
  String? text200;
  String? text300;
  String? text400;
  String? text500;
  String? text600;
  String? text700;
  String? text800;
  String? text900;

  String? accent50;
  String? accent100;
  String? accent200;
  String? accent300;
  String? accent400;
  String? accent500;
  String? accent600;
  String? accent700;
  String? accent800;
  String? accent900;

  String? success50;
  String? success100;
  String? success200;
  String? success300;
  String? success400;
  String? success500;
  String? success600;
  String? success700;
  String? success800;
  String? success900;

  String? error50;
  String? error100;
  String? error200;
  String? error300;
  String? error400;
  String? error500;
  String? error600;
  String? error700;
  String? error800;
  String? error900;

  String? warning50;
  String? warning100;
  String? warning200;
  String? warning300;
  String? warning400;
  String? warning500;
  String? warning600;
  String? warning700;
  String? warning800;
  String? warning900;

  String? info50;
  String? info100;
  String? info200;
  String? info300;
  String? info400;
  String? info500;
  String? info600;
  String? info700;
  String? info800;
  String? info900;

  String? achromatic50;
  String? achromatic100;
  String? achromatic200;
  String? achromatic300;
  String? achromatic400;
  String? achromatic500;
  String? achromatic600;
  String? achromatic700;
  String? achromatic800;
  String? achromatic900;

  String? facebookColor;
  String? googleColor;
  String? phoneColor;
  String? appleColor;
  String? paypalColor;
  String? stripeColor;
  String? razorColor;
  String? paystackColor;

  @override
  String? getPrimaryKey() {
    return primary50;
  }

  @override
  MobileColor fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return MobileColor(
      primary50: dynamicData['primary_50'],
      primary100: dynamicData['primary_100'],
      primary200: dynamicData['primary_200'],
      primary300: dynamicData['primary_300'],
      primary400: dynamicData['primary_400'],
      primary500: dynamicData['primary_500'],
      primary600: dynamicData['primary_600'],
      primary700: dynamicData['primary_700'],
      primary800: dynamicData['primary_800'],
      primary900: dynamicData['primary_900'],

      text50: dynamicData['text_50'],
      text100: dynamicData['text_100'],
      text200: dynamicData['text_200'],
      text300: dynamicData['text_300'],
      text400: dynamicData['text_400'],
      text500: dynamicData['text_500'],
      text600: dynamicData['text_600'],
      text700: dynamicData['text_700'],
      text800: dynamicData['text_800'],
      text900: dynamicData['text_900'],

      accent50: dynamicData['accent_50'],
      accent100: dynamicData['accent_100'],
      accent200: dynamicData['accent_200'],
      accent300: dynamicData['accent_300'],
      accent400: dynamicData['accent_400'],
      accent500: dynamicData['accent_500'],
      accent600: dynamicData['accent_600'],
      accent700: dynamicData['accent_700'],
      accent800: dynamicData['accent_800'],
      accent900: dynamicData['accent_900'],

      success50: dynamicData['success_50'],
      success100: dynamicData['success_100'],
      success200: dynamicData['success_200'],
      success300: dynamicData['success_300'],
      success400: dynamicData['success_400'],
      success500: dynamicData['success_500'],
      success600: dynamicData['success_600'],
      success700: dynamicData['success_700'],
      success800: dynamicData['success_800'],
      success900: dynamicData['success_900'],

      error50: dynamicData['error_50'],
      error100: dynamicData['error_100'],
      error200: dynamicData['error_200'],
      error300: dynamicData['error_300'],
      error400: dynamicData['error_400'],
      error500: dynamicData['error_500'],
      error600: dynamicData['error_600'],
      error700: dynamicData['error_700'],
      error800: dynamicData['error_800'],
      error900: dynamicData['error_900'],

      warning50: dynamicData['warning_50'],
      warning100: dynamicData['warning_100'],
      warning200: dynamicData['warning_200'],
      warning300: dynamicData['warning_300'],
      warning400: dynamicData['warning_400'],
      warning500: dynamicData['warning_500'],
      warning600: dynamicData['warning_600'],
      warning700: dynamicData['warning_700'],
      warning800: dynamicData['warning_800'],
      warning900: dynamicData['warning_900'],

      info50: dynamicData['info_50'],
      info100: dynamicData['info_100'],
      info200: dynamicData['info_200'],
      info300: dynamicData['info_300'],
      info400: dynamicData['info_400'],
      info500: dynamicData['info_500'],
      info600: dynamicData['info_600'],
      info700: dynamicData['info_700'],
      info800: dynamicData['info_800'],
      info900: dynamicData['info_900'],

      achromatic50: dynamicData['achromatic_50'],
      achromatic100: dynamicData['achromatic_100'],
      achromatic200: dynamicData['achromatic_200'],
      achromatic300: dynamicData['achromatic_300'],
      achromatic400: dynamicData['achromatic_400'],
      achromatic500: dynamicData['achromatic_500'],
      achromatic600: dynamicData['achromatic_600'],
      achromatic700: dynamicData['achromatic_700'],
      achromatic800: dynamicData['achromatic_800'],
      achromatic900: dynamicData['achromatic_900'],

      appleColor: dynamicData['brand_apple'],
      facebookColor: dynamicData['brand_facebook'],
      googleColor: dynamicData['brand_google'],
      paypalColor: dynamicData['brand_paypal'],
      paystackColor: dynamicData['brand_paystack'],
      phoneColor: dynamicData['brand_phone'],
      razorColor: dynamicData['brand_razor'],
      stripeColor: dynamicData['brand_stripe'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['primary_50'] = object.primary50;
      data['primary_100'] = object.primary100;
      data['primary_200'] = object.primary200;
      data['primary_300'] = object.primary300;
      data['primary_400'] = object.primary400;
      data['primary_500'] = object.primary500;
      data['primary_600'] = object.primary600;
      data['primary_700'] = object.primary700;
      data['primary_800'] = object.primary800;
      data['primary_900'] = object.primary900;

      data['text_50'] = object.text50;
      data['text_100'] = object.text100;
      data['text_200'] = object.text200;
      data['text_300'] = object.text300;
      data['text_400'] = object.text400;
      data['text_500'] = object.text500;
      data['text_600'] = object.text600;
      data['text_700'] = object.text700;
      data['text_800'] = object.text800;
      data['text_900'] = object.text900;

      data['accent_50'] = object.accent50;
      data['accent_100'] = object.accent100;
      data['accent_200'] = object.accent200;
      data['accent_300'] = object.accent300;
      data['accent_400'] = object.accent400;
      data['accent_500'] = object.accent500;
      data['accent_600'] = object.accent600;
      data['accent_700'] = object.accent700;
      data['accent_800'] = object.accent800;
      data['accent_900'] = object.accent900;

      data['success_50'] = object.success50;
      data['success_100'] = object.success100;
      data['success_200'] = object.success200;
      data['success_300'] = object.success300;
      data['success_400'] = object.success400;
      data['success_500'] = object.success500;
      data['success_600'] = object.success600;
      data['success_700'] = object.success700;
      data['success_800'] = object.success800;
      data['success_900'] = object.success900;

      data['error_50'] = object.error50;
      data['error_100'] = object.error100;
      data['error_200'] = object.error200;
      data['error_300'] = object.error300;
      data['error_400'] = object.error400;
      data['error_500'] = object.error500;
      data['error_600'] = object.error600;
      data['error_700'] = object.error700;
      data['error_800'] = object.error800;
      data['error_900'] = object.error900;

      data['warning_50'] = object.warning50;
      data['warning_100'] = object.warning100;
      data['warning_200'] = object.warning200;
      data['warning_300'] = object.warning300;
      data['warning_400'] = object.warning400;
      data['warning_500'] = object.warning500;
      data['warning_600'] = object.warning600;
      data['warning_700'] = object.warning700;
      data['warning_800'] = object.warning800;
      data['warning_900'] = object.warning900;

      data['info_50'] = object.info50;
      data['info_100'] = object.info100;
      data['info_200'] = object.info200;
      data['info_300'] = object.info300;
      data['info_400'] = object.info400;
      data['info_500'] = object.info500;
      data['info_600'] = object.info600;
      data['info_700'] = object.info700;
      data['info_800'] = object.info800;
      data['info_900'] = object.info900;

      data['achromatic_50'] = object.achromatic50;
      data['achromatic_100'] = object.achromatic100;
      data['achromatic_200'] = object.achromatic200;
      data['achromatic_300'] = object.achromatic300;
      data['achromatic_400'] = object.achromatic400;
      data['achromatic_500'] = object.achromatic500;
      data['achromatic_600'] = object.achromatic600;
      data['achromatic_700'] = object.achromatic700;
      data['achromatic_800'] = object.achromatic800;
      data['achromatic_900'] = object.achromatic900;

      data['brand_apple'] = object.appleColor;
      data['brand_facebook'] = object.facebookColor;
      data['brand_google'] = object.googleColor;
      data['brand_paypal'] = object.paypalColor;
      data['brand_phone'] = object.phoneColor;
      data['brand_razor'] = object.razorColor;
      data['brand_stripe'] = object.stripeColor;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<MobileColor> fromMapList(List<dynamic> dynamicDataList) {
    final List<MobileColor> userLoginList = <MobileColor>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        userLoginList.add(fromMap(dynamicData));
      }
    }
    // }
    return userLoginList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }
}
