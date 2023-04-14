import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practice_2_apple_tv/base/bloc.dart';

import '../../models/movie.dart';

class FeaturedPageBloc extends Bloc {
  //create ListMovies
  final Set<Movie> _listMovieFeatured =
      Bloc().listMovies.where((element) => element.iMDb >= 8).toSet();
  final Set<Movie> _listMovieNewRealese = Bloc()
      .listMovies
      .where((element) => element.yearOfManufacture >= 2020)
      .toSet();
  final Set<Movie> _listMovieSeries = Bloc()
      .listMovies
      .where((element) => element.name.contains('Spider-Man'))
      .toSet();

  Set<Movie> get listMovieFeatured => _listMovieFeatured;

  //create listMovieWhatToWatch with 5 random movies from all movie
  Set<Movie> getRandomListMovieWhatToWatch() {
    final random = Random();
    Set<Movie> listMovieWhatToWatch = {};
    for (int i = 0; i < 5; i++) {
      int randomIndex = random.nextInt(Bloc().listMovies.length);
      listMovieWhatToWatch.add(Bloc().listMovies.elementAt(randomIndex));
    }
    return listMovieWhatToWatch;
  }

  late TabController _tabController;

  //init Page Controller
  final _pageFeaturedController = PageController();

  // double _currentPage = 0;

  @override
  void dispose() {
    _tabController.dispose();
    _pageFeaturedController.dispose();
    super.dispose();
  }

  //getter
  Set<Movie> get listMovieNewRealese => _listMovieNewRealese;

  Set<Movie> get listMovieSeries => _listMovieSeries;

  // double get currentPage => _currentPage;
  get pageFeaturedController => _pageFeaturedController;

  TabController get tabController => _tabController;

  set tabController(TabController value) {
    _tabController = value;
  }
//setter

/*
  final _currentPageStreamController = StreamController<double>.broadcast();
  Stream<double> get currentPageStream => _currentPageStreamController.stream;
  StreamSink get _currentPageSink => _currentPageStreamController.sink;

  void pageFeaturedControllerAddListen(){
    _pageFeaturedController.addListener(() {
        _currentPage = _pageFeaturedController.page!;
        _currentPageSink.add(_currentPage);
    });
  }*/
}
