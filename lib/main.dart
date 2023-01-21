import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/utils/routes/routes_name.dart';
import 'package:flutter_api_boilerplate/viewModel/auth_view_model.dart';
import 'package:flutter_api_boilerplate/viewModel/local_view_model.dart';
import 'package:flutter_api_boilerplate/viewModel/product_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'utils/routes/routes.dart';

final box = GetStorage();
void main() async {
  await GetStorage.init();
  box.erase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LocalViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: EasyLoading.init(),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
