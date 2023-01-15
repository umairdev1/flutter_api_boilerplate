import 'package:flutter_api_boilerplate/models/movies_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/components/app_urls.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMovieList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);

      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
