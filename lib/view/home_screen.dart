import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/data/response/status.dart';
import 'package:flutter_api_boilerplate/models/movies_model.dart';
import 'package:flutter_api_boilerplate/utils/general_utils.dart';
import 'package:flutter_api_boilerplate/viewModel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMovieListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Movies"),
        ),
        body: ChangeNotifierProvider(
          create: (BuildContext context) => homeViewModel,
          builder: (context, child) {
            return Consumer<HomeViewModel>(
              builder: (context, value, _) {
                print(value.movieList.status.toString());
                switch (value.movieList.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());

                  case Status.ERROR:
                    return Center(
                        child: Text(value.movieList.message.toString()));
                  case Status.COMPLETED:
                    return ListView.builder(
                        itemCount: value.movieList.data?.movies?.length,
                        itemBuilder: (context, index) {
                          final data = value.movieList.data?.movies?[index];
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              leading: Image.network(
                                data!.posterurl.toString(),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                              title: Text(data.title.toString()),
                              subtitle: Text(data.year.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Utils.averageRating(data.ratings!)
                                      .toString()),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                            ),
                          );
                        });

                  default:
                }
                return Container();
              },
            );
          },
        ));
  }
}
