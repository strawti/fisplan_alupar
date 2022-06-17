import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';


class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      final _connect = GetConnect();
      _connect.timeout = const Duration(seconds: 30);
      _connect.httpClient.addRequestModifier(requestModifier);
      _connect.httpClient.addResponseModifier(responseModifier);
      return _connect;
    });
  }

  FutureOr<Request> requestModifier(Request request) async {
    String? token = '';

    request.headers.addAll({
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      'content-type': 'application/json',
    });

    return request;
  }

  FutureOr<dynamic> responseModifier(Request request, Response response) async {
    showLogs(request, response);

    if (response.unauthorized) {
    }

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
