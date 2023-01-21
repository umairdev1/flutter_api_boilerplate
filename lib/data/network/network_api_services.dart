import 'dart:convert';
import 'dart:io';

import 'package:flutter_api_boilerplate/main.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${box.read('token')}',
      }).timeout(const Duration(seconds: 10));
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
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostWithImageApiResponse(
      String url, String imageFieldName, File image, Map data) async {
    dynamic responseJson;
    try {
      var request = MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer ${box.read('token')}',
      });
      request.files.add(http.MultipartFile(
          imageFieldName, image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));

      request.fields.addAll(Map<String, String>.from(data));

      var response = await request.send();
      print(response);
      responseJson = returnResponse(
          Response(await response.stream.bytesToString(), response.statusCode));
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      Response response = await delete(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${box.read('token')}',
      }).timeout(const Duration(seconds: 10));
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
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
        },
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
        dynamic responseJson = jsonDecode(response.body);
        throw responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        throw responseJson;
      case 409:
        dynamic responseJson = jsonDecode(response.body);
        throw responseJson['data'];
      default:
        dynamic responseJson = jsonDecode(response.body);
        throw responseJson;
    }
  }
}
