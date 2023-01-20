import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      Response response = await delete(
        Uri.parse(url),
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPatchApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await patch(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestExceptions(response.body.toString());
      case 404:
        throw UnauthorizedExceptions(response.body.toString());
      default:
        throw FetchDataExceptions(
            // ignore: prefer_interpolation_to_compose_strings
            'Error Occured while communicating with server '
                    "with status code" +
                response.statusCode.toString());
    }
  }
}
