import 'package:flutter_api_boilerplate/data/network/base_api_services.dart';
import 'package:flutter_api_boilerplate/data/network/network_api_services.dart';

import '../resources/components/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registeredUrl, data);

      return response;
    } catch (e) {
      throw e;
    }
  }
}
