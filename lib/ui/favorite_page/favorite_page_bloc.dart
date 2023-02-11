import 'package:practice_2_apple_tv/base/bloc.dart';
import 'package:practice_2_apple_tv/models/movie.dart';

import '../../shared_preferences/shared_preferences.dart';

class FavoritePageBloc extends Bloc{
  //get ListFavorite from
  Future<Set<Movie>> getListMovieFavorite() async{
    return await MySharedPreferences.getListFavoriteMovies();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}