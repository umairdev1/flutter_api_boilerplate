import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/data/response/api_response.dart';
import 'package:flutter_api_boilerplate/repository/product_repository.dart';
import 'package:flutter_api_boilerplate/utils/general_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../utils/routes/routes_name.dart';

class ProductViewModel with ChangeNotifier {
  final _myRepo = ProductRepository();

  ApiResponse<UserListModel> userList = ApiResponse.loading();

  setUserList(ApiResponse<UserListModel> response) {
    userList = response;
    notifyListeners();
  }

  Future<void> fetchUserListApi() async {
    setUserList(ApiResponse.loading());
    _myRepo.fetchuserList().then((value) {
      setUserList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> addApi(dynamic data, BuildContext context) async {
    _myRepo.addApi(data).then((value) {
      Utils.flushBarErrorMessage("Added Successfully", context);
      EasyLoading.showSuccess("Added Successfully");

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }

      EasyLoading.showError(error.toString());
    });
  }

  Future<void> addDataWithImageApi(
      File image, Map data, BuildContext context) async {
    _myRepo.addProductWithImageApi(image, data).then((value) {
      EasyLoading.showToast("Added Successfully");

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }

      EasyLoading.showError(error.toString());
    });
  }

  Future<void> updateApi(dynamic id, data, BuildContext context) async {
    _myRepo.updateApi(id, data).then((value) {
      Utils.flushBarErrorMessage("Updated Successfully", context);

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }

      EasyLoading.showError(error.toString());
    });
  }

  Future<void> deleteApi(dynamic id, BuildContext context) async {
    _myRepo.deleteApi(id).then((value) {
      EasyLoading.showSuccess("Deleted Successfully");
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      EasyLoading.showError(error.toString());
    });
  }
}
