import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/utils/routes/routes_name.dart';
import 'package:flutter_api_boilerplate/viewModel/auth_view_model.dart';
import 'package:flutter_api_boilerplate/viewModel/home_viewmodel.dart';
import 'package:flutter_api_boilerplate/viewModel/user_view_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'utils/routes/routes.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
