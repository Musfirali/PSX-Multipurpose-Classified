import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';

import '../../../vendor/api/common/ps_api_reponse.dart';
import '../../../vendor/api/common/ps_resource.dart';
import '../../../vendor/api/common/ps_status.dart';
import '../../viewobject/common/ps_object.dart';
import '/config/ps_config.dart';

abstract class PsApi {
  final Map<String, String> _headers = <String, String>{
    'content-type': 'application/json',
    'Authorization': PsConfig.ps_bearer_token,
  };

  PsResource<T> psObjectConvert<T>(dynamic dataList, T data) {
    return PsResource<T>(dataList.status, dataList.message, data);
  }

  // Future<List<dynamic>> getList(String url) async {
  //   final Client client = http.Client();
  //   try {
  //     final Response response = await client.get('${PsConfig.ps_app_url}$url');

  //     if (response.statusCode == 200 &&
  //         response.body != null &&
  //         response.body != '') {
  //       // parse into List
  //       final List<dynamic> parsed = json.decode(response.body);

  //       //posts.addAll(SubCategory().fromJsonList(parsed));

  //       return parsed;
  //     } else {
  //       throw Exception('Error in loading...');
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }

  void printGetLog(PsApiResponse psApiResponse, http.Response response) {
    const String success = '✅';
    const String failed = '❌';
    print(' ');
    print(
        '____________________________________________________________________________________________');
    print('\u001b[33m GET    --> ${response.request?.url.toString()} ');
    if (psApiResponse.isSuccessful)
      print(
          '\u001b[33m ${response.statusCode} $success <-- ${response.request?.url.toString()}\u001b[0m');
    else if (psApiResponse.totallyNoRecord)
      print(
          '\u001b[33m ${response.statusCode} $success (Totally No Record) <-- ${response.request?.url.toString()}\u001b[0m');
    else
      print(
          '\u001b[33m ${response.statusCode} $failed <-- ${response.request?.url.toString()}\u001b[0m');
    print(
        '____________________________________________________________________________________________');
    print('');
  }

  void printPostLog(PsApiResponse psApiResponse, http.Response response,
      Map<dynamic, dynamic> jsonMap) {
    const String success = '✅';
    const String failed = '❌';
    print(
        '____________________________________________________________________________________________');
    print(
        '\u001b[33m POST   --> ${response.request?.url.toString()}\u001b[0m ');
    print('\u001b[37m REQ-BODY --> ${jsonMap.toString()} \u001b[0m');
    if (psApiResponse.isSuccessful)
      print(
          '\u001b[33m ${response.statusCode} $success <-- ${response.request?.url.toString()}\u001b[0m');
    else if (psApiResponse.totallyNoRecord)
      print(
          '\u001b[33m ${response.statusCode} $success (Totally No Record) <-- ${response.request?.url.toString()}\u001b[0m');
    else
      print(
          '\u001b[33m ${response.statusCode} $failed <-- ${response.request?.url.toString()}\u001b[0m');
    print(
        '____________________________________________________________________________________________');
    print('');
  }

  Future<PsResource<R>> getServerCall<T extends PsObject<dynamic>, R /*!*/ >(
      T obj, String url,
      {bool useHeaderToken = false, String headerToken = ''}) async {
    final Client client = http.Client();
    final Response response;
    try {
      final Map<String, String>? headerTokenData = <String, String>{
        'content-type': 'application/json',
        'Authorization': PsConfig.ps_bearer_token,
        'header-token': headerToken,
      };
      response = await client.get(
        Uri.parse('${PsConfig.ps_app_url}$url'),
        headers: useHeaderToken ? headerTokenData : _headers,
      );
      print(response.body);

      final PsApiResponse psApiResponse = PsApiResponse(response);
      printGetLog(psApiResponse, response);

      if (psApiResponse.isSuccessful) {
        print('response Success');
        final dynamic hashMap = json.decode(response.body);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data as dynamic));
            print(obj.fromMap(data as dynamic));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      print(e.toString());
      return PsResource<R>(PsStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postData<T extends PsObject<dynamic>, R>(
      T obj, String url, Map<dynamic, dynamic> jsonMap,
      {bool useHeaderToken = false, String? headerToken = ''}) async {
    final Client client = http.Client();
    late Response response;
    try {
      final Map<String, String>? headerTokenData = <String, String>{
        'content-type': 'application/json',
        'Authorization': PsConfig.ps_bearer_token,
        'header-token': headerToken!,
      };

      response = await client.post(Uri.parse('${PsConfig.ps_app_url}$url'),
          headers: useHeaderToken ? headerTokenData : _headers,
          body: const JsonEncoder().convert(jsonMap));

      // response = await client
      //       .post(Uri.parse('${PsConfig.ps_app_url}$url'),
      //           headers: <String, String>{'content-type': 'application/json'},
      //           body: const JsonEncoder().convert(jsonMap))
      //       .catchError((dynamic e) {
      //     print('** Error Post Data');
      //     print(e.error);
      //   });

      final PsApiResponse psApiResponse = PsApiResponse(response);
      printPostLog(psApiResponse, response, jsonMap);
      if (psApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      print(e.toString());

      return PsResource<R>(PsStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postListData<T extends PsObject<dynamic>, R>(
      T obj, String url, List<Map<dynamic, dynamic>> jsonMap,
      {bool useHeaderToken = false, String headerToken = ''}) async {
    final Client client = http.Client();
    final Map<String, String>? headerTokenData = <String, String>{
      'content-type': 'application/json',
      'Authorization': PsConfig.ps_bearer_token,
      'header-token': headerToken,
    };

    try {
      final Response response = await client.post(
          Uri.parse('${PsConfig.ps_app_url}$url'),
          headers: useHeaderToken ? headerTokenData : _headers,
          body: const JsonEncoder().convert(jsonMap));

      final PsApiResponse psApiResponse = PsApiResponse(response);

      if (psApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      print(e.toString());

      return PsResource<R>(PsStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postUploadImage<T extends PsObject<dynamic>, R>(
      T obj,
      String url,
      String userIdText,
      String userId,
      String platformNameText,
      String platformName,
      String imageFileText,
      File imageFile,
      {bool useHeaderToken = false,
      String? headerToken = ''}) async {
    final Client client = http.Client();
    final Map<String, String> headerTokenData = <String, String>{
      'content-type': 'application/json',
      'Authorization': PsConfig.ps_bearer_token,
      'header-token': headerToken!,
    };
    try {
      final ByteStream stream =
          http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final int length = await imageFile.length();

      final Uri uri = Uri.parse('${PsConfig.ps_app_url}$url');

      final MultipartRequest request = http.MultipartRequest('POST', uri);
      final MultipartFile multipartFile = http.MultipartFile(
          imageFileText, stream, length,
          filename: basename(imageFile.path));
      request.headers.addAll(useHeaderToken ? headerTokenData : _headers);
      request.fields[userIdText] = userId;
      request.fields[platformNameText] = platformName;
      request.files.add(multipartFile);
      final StreamedResponse response = await request.send();
      // response.stream.listen((List<int> value ) {
      //   print(value);
      // });

      final PsApiResponse psApiResponse =
          PsApiResponse(await http.Response.fromStream(response));

      if (psApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(psApiResponse.body!);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postUploadItemImage<T extends PsObject<dynamic>, R>(
      T obj,
      String url,
      String itemIdText,
      String itemId,
      String imageIdText,
      String? imageId,
      String orderingText,
      String orderingDesc,
      File imageFile,
      {bool useHeaderToken = false,
      String headerToken = ''}) async {
    final Client client = http.Client();
    StreamedResponse response;
    ByteStream stream;
    final Map<String, String> headerTokenData = <String, String>{
      'content-type': 'application/json',
      'Authorization': PsConfig.ps_bearer_token,
      'header-token': headerToken,
    };
    try {
      if (imageFile.path != '') {
        stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        final int length = await imageFile.length();

        final Uri uri = Uri.parse('${PsConfig.ps_app_url}$url');

        final MultipartRequest request = http.MultipartRequest('POST', uri);
        final MultipartFile multipartFile = http.MultipartFile(
            'cover', stream, length,
            filename: basename(imageFile.path));
        request.headers.addAll(useHeaderToken ? headerTokenData : _headers);
        request.fields[itemIdText] = itemId;
        request.fields[imageIdText] = imageId!;
        request.fields[orderingText] = orderingDesc;
        request.files.add(multipartFile);
        response = await request.send();
      } else {
        stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        final Uri uri = Uri.parse('${PsConfig.ps_app_url}$url');
        final MultipartRequest request = http.MultipartRequest('POST', uri);
        request.headers.addAll(useHeaderToken ? headerTokenData : _headers);
        request.fields[itemIdText] = itemId;
        request.fields[imageIdText] = imageId!;
        request.fields[orderingText] = orderingDesc;
        response = await request.send();
      }

      final PsApiResponse psApiResponse =
          PsApiResponse(await http.Response.fromStream(response));

      if (psApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(psApiResponse.body!);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postUploadChatImage<T extends PsObject<dynamic>, R>(
      T obj,
      String url,
      String senderIdText,
      String senderId,
      String sellerUserIdText,
      String sellerUserId,
      String buyerUserIdText,
      String buyerUserId,
      String itemIdText,
      String itemId,
      String typeText,
      String type,
      String isUserOnlineText,
      String isUserOnline,
      File imageFile,
      {bool useHeaderToken = false,
      String headerToken = ''}) async {
    final Client client = http.Client();
    try {
      final Map<String, String> headerTokenData = <String, String>{
        'content-type': 'application/json',
        'Authorization': PsConfig.ps_bearer_token,
        'header-token': headerToken,
      };
      final ByteStream stream =
          http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final int length = await imageFile.length();

      final Uri uri = Uri.parse('${PsConfig.ps_app_url}$url');

      final MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers.addAll(useHeaderToken ? headerTokenData : _headers);
      final MultipartFile multipartFile = http.MultipartFile(
          'file', stream, length,
          filename: basename(imageFile.path));

      request.fields[senderIdText] = senderId;
      request.fields[sellerUserIdText] = sellerUserId;
      request.fields[buyerUserIdText] = buyerUserId;
      request.fields[itemIdText] = itemId;
      request.fields[typeText] = type;
      request.fields[isUserOnlineText] = isUserOnline;
      request.files.add(multipartFile);
      final StreamedResponse response = await request.send();

      final PsApiResponse psApiResponse =
          PsApiResponse(await http.Response.fromStream(response));

      if (psApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(psApiResponse.body!);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }
}
