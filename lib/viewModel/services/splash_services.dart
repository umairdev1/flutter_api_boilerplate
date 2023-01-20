// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_api_boilerplate/models/auth_model.dart';
import 'package:flutter_api_boilerplate/utils/routes/routes_name.dart';
import 'package:flutter_api_boilerplate/viewModel/local_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => LocalViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.token.toString());
      }

      if (value.token.toString() == 'null' || value.token.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
