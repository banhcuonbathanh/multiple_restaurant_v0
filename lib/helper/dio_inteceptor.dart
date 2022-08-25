import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/snackbarcontent.dart';

class DioInterceptor extends Interceptor {
  final Reader read;

  DioInterceptor(this.read);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    read(Utility.isLoading.notifier).isLoading(isLoading: true);
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    // print('RequestOptionsRequestOptionsRequestOptionsRequestOptions');
    super.onRequest(options, handler);
  }

  // ref
  //           .read(Utility.error.notifier)
  //           .addError(error: 'Mật Khẩu Dài Hơn 6 Kí Tự');
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('responseresponseresponse');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    read(Utility.isLoading.notifier).isLoading(isLoading: false);

    print('errerrerrerrerrerrerr');
    print(err.response.toString());
    print(err.response.toString() == 'Incorrect username');
    print(err.error);
    // print(err.type);
    // print(err.message.substring(0, 15) == 'SocketException');
    if (err.message.substring(0, 15) == 'SocketException') {
      // print('SocketExceptionSocketExceptionSocketExceptionSocketException');
      read(Utility.error.notifier).addError(error: 'server down');
      // throw Exception(' SocketException');
    }

    if (err.response.toString() == 'Incorrect username') {
      read(Utility.error.notifier).addError(error: 'sai dia chi email');
    }
    if (err.response.toString() == 'Incorrect password') {
      read(Utility.error.notifier).addError(error: 'sai mat ma');
    }

    super.onError(err, handler);
  }
}
