import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/user_model.dart';
import '../resources/components/app_urls.dart';

class ProductRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<UserListModel> fetchuserList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.userList);

      return response = UserListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> addApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.productAddUrl, data);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> addProductWithImageApi(File image, Map data) async {
    try {
      dynamic response = await _apiServices.getPostWithImageApiResponse(
          AppUrl.productAddUrl, "image", image, data);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> updateApi(dynamic id, data) async {
    try {
      dynamic response = await _apiServices.getPatchApiResponse(
          "${AppUrl.loginUrl}/$id", data);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteApi(dynamic id) async {
    try {
      dynamic response = await _apiServices
          .getDeleteApiResponse("${AppUrl.userDeleteUrl}/$id");
      return response;
    } catch (e) {
      throw e;
    }
  }
}
