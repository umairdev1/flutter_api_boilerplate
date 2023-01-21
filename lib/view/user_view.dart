import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/data/response/status.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../viewModel/product_view_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ProductViewModel userViewModel = ProductViewModel();

  @override
  void initState() {
    userViewModel.fetchUserListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Users"),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => userViewModel,
        builder: (context, child) {
          return Consumer<ProductViewModel>(
            builder: (context, value, _) {
              switch (value.userList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());

                case Status.ERROR:
                  return Center(child: Text(value.userList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.userList.data!.data!.length,
                      itemBuilder: (context, index) {
                        final data = value.userList.data?.data?[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              data!.avatar.toString(),
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                            title: Text(data.firstName.toString()),
                            subtitle: Text(data.email.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  EasyLoading.show();
                                  userViewModel.deleteApi(data.id, context);
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                        );
                      });

                default:
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
