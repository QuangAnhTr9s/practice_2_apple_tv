import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_2_apple_tv/ui/home_page/home_page_bloc.dart';
import 'package:practice_2_apple_tv/ui/playlist_page/play_list_page.dart';
import '../channels_page/channels_page.dart';
import '../favorite_page/favorite_page.dart';
import '../featured_page/featured_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //init HomePageBloc
  final _homePageBloc = HomePageBloc();
  @override
  void dispose() {
    _homePageBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(child: Center(child: Text("It's My Drawer"),)),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "AppleTV",
            style: Theme.of(context).textTheme.titleLarge,
            // style: TextStyle(color: Color(0xffef1951)),
          ),
          backgroundColor: Colors.grey.shade800,
          actions: [
            //search icon is on the right side of the appbar
            IconButton(onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.grey,)),
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                color: Colors.grey,
                onPressed: () {
                  //press to open Drawer
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu,),
              );
            }
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 3),
          color: Colors.grey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _homePageBloc.pageController,
            children: const [
              FeaturedPage(),
              ChannelsPage(),
              FavoritePage(),
              PlayListPage(),
          ],
          ),
        ),
        bottomNavigationBar: StreamBuilder<int>(
          initialData: _homePageBloc.initCurrentPage,
          stream: _homePageBloc.currentPageStream,
          builder: (context, snapshot) {
            final currentPage = snapshot.data ?? _homePageBloc.initCurrentPage;
            return BottomNavigationBar(
              backgroundColor: Colors.grey.shade800,
              type: BottomNavigationBarType.fixed,
              onTap: (value) => _homePageBloc.changePageIndex(value),
              currentIndex: currentPage,
              // hide label of BottomNavigationBarItem
              showSelectedLabels: false,
              showUnselectedLabels: false,
              //BottomNavigationBarItem will change color to red when cliked (on Tap)
              selectedItemColor: IconTheme.of(context).color,
              unselectedItemColor: Colors.grey.shade400,
              items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.dashboard,), label: ''),
                  BottomNavigationBarItem(icon: Icon(CupertinoIcons.tv_fill,), label: ''),
                  // BottomNavigationBarItem(icon: Container(height: 32, width: 32,child: Image.asset(Images.thumb_up_filled, fit: BoxFit.fill,)), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.playlist_add_rounded, size: 32,), label: ''),
              ],
            );
          }
        ),
      ),
    );
  }
}

