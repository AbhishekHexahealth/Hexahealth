import 'package:flutter/material.dart';

import '../data/response/ApiResponse.dart';
import '../models/MoviesMain.dart';
import '../repository/MovieRepoImp.dart';


class MoviesListVM extends ChangeNotifier {
  final _myRepo = MovieRepoImp();

  ApiResponse<MoviesMain> movieMain = ApiResponse.loading();

  void _setMovieMain(ApiResponse<MoviesMain> response) {
    print("MARAJ :: $response");
    movieMain = response;
    notifyListeners();
  }

  Future<void> fetchMovies(int cusMsg,String msg) async {
    _setMovieMain(ApiResponse.loading());
    _myRepo
        .getMoviesList(cusMsg,msg)
        .then((value) => _setMovieMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setMovieMain(ApiResponse.error(error.toString())));
  }
}