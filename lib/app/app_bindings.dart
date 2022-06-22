import 'dart:async';

import 'core/app_token.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      final connect = GetConnect();
      connect.timeout = const Duration(seconds: 30);
      connect.httpClient.addRequestModifier(requestModifier);
      connect.httpClient.addResponseModifier(responseModifier);
      return connect;
    });

    Get.lazyPut(() => GetStorage());
  }

  FutureOr<Request> requestModifier(Request request) async {
    String? token = AppToken.instance.token;

    request.headers.addAll({
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      'content-type': 'application/json',
    });

    return request;
  }

  FutureOr<dynamic> responseModifier(Request request, Response response) async {
    showLogs(request, response);

    if (response.unauthorized) {}

    return response;
  }

  void showLogs(Request request, Response response) {
    if (kDebugMode) {
      print('\n\n');
      print('========================== REQUEST ==========================');
      print('(${request.method}) => ${request.url}');
      print('HEADERS: ${request.headers}');
      print('');
      print('========================== RESPONSE ==========================');
      print('STATUS CODE: ${response.statusCode}');
      print('STATUS TEXT: ${response.statusText}');
      print('BODY: ${response.body}');
      print('\n\n');
    }
  }
}
