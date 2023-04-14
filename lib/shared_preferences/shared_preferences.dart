import 'dart:convert';

import 'package:practice_2_apple_tv/models/channel.dart';
import 'package:practice_2_apple_tv/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  static late SharedPreferences _sharedPreferences;

  static Future<void> initSharedPreferences() async{
    //init MySharedPreferences
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //Save and get List<Movie> to SharedPreferences
  // Serialize the list into a JSON string:
  static String movieListToJson(Set<Movie> movieList) => json.encode(List<dynamic>.from(movieList.map((x) => x.toJson())));
  // Deserialize the JSON string back into a List<User>:
  static Set<Movie> movieListFromJson(String str) => Set<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));
  // Use the SharedPreferences API to save and retrieve the serialized JSON string:
  static Future<void> saveListFavoriteMovies(Set<Movie> movieList) async {
    _sharedPreferences.setString('movieList', movieListToJson(movieList));
  }
  static Future<Set<Movie>> getListFavoriteMovies() async {
    final movieListJson = _sharedPreferences.getString('movieList');
    return movieListFromJson(movieListJson ?? '[]');
  }

  //Save and get List<Channel> to SharedPreferences
  // Serialize the list into a JSON string:
  static String channelListToJson(Set<Channel> channelList) => json.encode(List<dynamic>.from(channelList.map((x) => x.toJson())));
  // Deserialize the JSON string back into a List<User>:
  static Set<Channel> channelListFromJson(String str) => Set<Channel>.from(json.decode(str).map((x) => Channel.fromJson(x)));
  // Use the SharedPreferences API to save and retrieve the serialized JSON string:
  static Future<void> saveListFavoriteChannel(Set<Channel> channelList) async {
    _sharedPreferences.setString('channelList', channelListToJson(channelList));
  }
  static Future<Set<Channel>> getListFavoriteChannels() async {
    final channelListJson = _sharedPreferences.getString('channelList');
    return channelListFromJson(channelListJson ?? '[]');
  }

}