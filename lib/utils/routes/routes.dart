import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/view/product/add_product.dart';
import '../../view/auth_view/login_view.dart';
import '../../view/auth_view/sign_up_view.dart';

import '../../view/splash/splash_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const AddProduct());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpView());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashView());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}
