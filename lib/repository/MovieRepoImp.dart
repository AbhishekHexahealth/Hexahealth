import 'dart:convert';

import '../data/network/ApiEndPoints.dart';
import '../data/network/BaseApiService.dart';
import '../data/network/NetworkApiService.dart';
import '../models/MoviesMain.dart';
import 'MovieRepo.dart';


class MovieRepoImp implements MovieRepo{

  BaseApiService _apiService = NetworkApiService();

  @override
  Future<MoviesMain?> getMoviesList( cusMsg, msg) async {
    try {
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().getMovies,cusMsg,msg);
      print("MARAJ $response");
      final jsonData = MoviesMain.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
  }

}