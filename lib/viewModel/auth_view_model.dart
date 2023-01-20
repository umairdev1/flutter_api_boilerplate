import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_api_boilerplate/models/auth_model.dart';
import 'package:flutter_api_boilerplate/viewModel/local_view_model.dart';
import 'package:provider/provider.dart';

import '../repository/auth_repository.dart';
import '../utils/general_utils.dart';
import '../utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  bool _signuploading = false;
  bool get signuploading => _signuploading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setsignupLoading(bool value) {
    _signuploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference =
          Provider.of<LocalViewModel>(context, listen: false);

      userPreference.saveUser(UserModel(token: value['token'].toString()));

      Utils.flushBarErrorMessage("Login Successfully", context);

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }

      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setsignupLoading(true);
    _myRepo.registerApi(data).then((value) {
      setsignupLoading(false);
      Utils.flushBarErrorMessage("Sign Up Successfully", context);

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setsignupLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }

      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
