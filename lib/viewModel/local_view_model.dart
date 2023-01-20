import 'package:flutter/cupertino.dart';
import 'package:flutter_api_boilerplate/models/auth_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel userModel) async {
    final box = GetStorage();

    box.write('token', userModel.token);

    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final box = GetStorage();
    final String? token = box.read('token');
    return UserModel(token: token.toString());
  }

  Future<void> remove() async {
    final box = GetStorage();

    return box.erase();
  }
}
