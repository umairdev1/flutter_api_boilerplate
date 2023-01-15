import 'package:flutter/foundation.dart';
import 'package:flutter_api_boilerplate/data/response/api_response.dart';
import 'package:flutter_api_boilerplate/models/movies_model.dart';
import 'package:flutter_api_boilerplate/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> movieList = ApiResponse.loading();

  setMovieList(ApiResponse<MovieListModel> response) {
    movieList = response;
    notifyListeners();
  }

  Future<void> fetchMovieListApi() async {
    setMovieList(ApiResponse.loading());
    _myRepo.fetchMovieList().then((value) {
      setMovieList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMovieList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
