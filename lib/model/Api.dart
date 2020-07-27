import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movedbtest/model/result.dart';
import 'package:movedbtest/model/searchResult.dart';

class URLS {
  static const String BASE_URL = 'https://api.themoviedb.org/3';
}

class Api {
  static Future<Result> getMovies() async {
    final response = await http.get('${URLS.BASE_URL}/movie/now_playing?api_key=c072f26d6acf3ad6c6ae90eaf780f778&amp;language=en-US&amp;page=1');
    if (response.statusCode == 200) {
      print("result11111"+response.body);
      return 	Result.fromJsonMap(json.decode(response.body));
    } else {
      print("error"+response.statusCode.toString());
      return null;
    }
  }

  static Future<SearchResult> getSearchMovies( String name) async {
    //https://api.themoviedb.org/3/search/movie?api_key=c072f26d6acf3ad6c6ae90eaf780f778&language=en-US&query=The%20Outpost&page=1&include_adult=false
    final response = await http.get('${URLS.BASE_URL}/search/movie?api_key=c072f26d6acf3ad6c6ae90eaf780f778&language=en-US&query='+name+'&page=1&include_adult=false');//+name+'&amp;page=1&amp;include_adult=false');
    if (response.statusCode == 200) {
      print(" Search result11111"+response.body);
      return 	SearchResult.fromJsonMap(json.decode(response.body));
    } else {
      print(" Search error" + response.body.toString());
      return null;
    }
  }

  /*static Future<bool> addEmployee(body) async {
    // BODY
    // {
    //   "name": "test",
    //   "age": "23"
    // }
    final response = await http.post('${URLS.BASE_URL}/create', body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }*/
}