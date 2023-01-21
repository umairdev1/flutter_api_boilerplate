import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostWithImageApiResponse(
      String url, String imageFieldName, File image, Map data);
  Future<dynamic> getPatchApiResponse(String url, dynamic data);
  Future<dynamic> getDeleteApiResponse(String url);
}
