import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/movie.dart';

class MovieApi {
  final String baseUrl = 'https://api.themoviedb.org';
  final api_key = '1b869b3ccf57d089047ded4b1de007b8';

  Future<List<MovieModel>> getList(String criteria) async {
    final _urlApi = '$baseUrl/4/list/1?page=1&api_key=${api_key}${criteria}';
//    print(_urlApi);
    final response = await http.get(_urlApi);
    final res = json.decode(response.body);
    final results = res['results'];

    List<MovieModel> result = [];
    for (int i = 0; i < results.length; i++) {
      if (results[i]['poster_path'] != '') {
        result.add(MovieModel.fromJson(results[i]));
      }
    }
    return result;
  }

  Future<MovieModel> getDetail(String id) async {
    final _urlApi = '$baseUrl/3/movie/${id}?api_key=${api_key}';
    final response = await http.get(_urlApi);
    final res = json.decode(response.body);

    return MovieModel.fromJson(res);
  }
}
