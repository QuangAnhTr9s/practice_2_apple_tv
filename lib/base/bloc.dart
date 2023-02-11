import 'package:practice_2_apple_tv/models/channel.dart';
import 'package:practice_2_apple_tv/models/movie.dart';
import 'package:practice_2_apple_tv/shared/fake_data/fake_data_channels.dart';

import '../shared/fake_data/fake_data_movies.dart';

class Bloc{

  //Fake data movie
  final Set<Movie> listMovies = FakeDataMovies().listMovies;
  //Fake data channel
  final Set<Channel> listChannels = FakeDataChannels().listChanels;

  void dispose() {}
}