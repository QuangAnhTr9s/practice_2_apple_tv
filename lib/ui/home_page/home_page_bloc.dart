import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:practice_2_apple_tv/base/bloc.dart';

class HomePageBloc extends Bloc{
  PageController pageController = PageController();
  //trang hiện tại
  int _currentPage = 0;
  final _currentPageStreamController = StreamController<int>.broadcast();
  Stream<int> get currentPageStream => _currentPageStreamController.stream;
  StreamSink get _currentPageSink => _currentPageStreamController.sink;

  //get init currentPage : trang đầu tiên
  int get initCurrentPage => 0;

  void changePageIndex(int index){
    //on tap => set curent page = index and jump to page with index
    _currentPage = index;
    _currentPageSink.add(_currentPage);
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _currentPageStreamController.close();
    super.dispose();
  }
}