import 'package:flutter/material.dart';
import 'package:practice_2_apple_tv/ui/featured_page/featured_page_bloc.dart';
import 'package:practice_2_apple_tv/ui/movie_profile_page/movie_profile_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../custom_widget/custom_image_cliprrect.dart';
import '../../models/movie.dart';

class FeaturedPage extends StatefulWidget {
  const FeaturedPage({super.key});

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  //init bloc
  final _featuredPageBloc = FeaturedPageBloc();
  late Set<Movie> listMovieWhatToWatch;
  @override
  void initState() {
    super.initState();
    // _featuredPageBloc.pageFeaturedController.addListener(() {
    //   setState(() {
    //     _featuredPageBloc.currentPage = _featuredPageBloc.pageFeaturedController.page!;
    //   });
    // });

    _featuredPageBloc.tabController = TabController(vsync: this, length: 3);
  }
  @override
  void dispose() {
    _featuredPageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //create listMovieWhatToWatch by random 5 Movie from all movie
    listMovieWhatToWatch = _featuredPageBloc.getRandomListMovieWhatToWatch();
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        // height: height - 150,
        color: Colors.grey.shade800,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //build TabBar and TabView
              SizedBox(
                height: 450,
                child: buildTabBarAndTabViewMovies(context),
              ),
              //build What to watch movies
              SizedBox(
                height: 200,
                  child: buildWhatToWatchMovies(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabBarAndTabViewMovies(BuildContext context) {
    return Column(
                children: [
                  //build TabBar
                  SizedBox(
                    height: 30,
                    // alignment: Alignment.topLeft,
                    child: TabBar(
                        controller: _featuredPageBloc.tabController,
                        // isScrollable: true,
                        //set như này thì ko thấy thanh trượt dưới nữa: indicator: const BoxDecoration(shape: BoxShape.circle)
                        indicatorColor: Colors.grey,// màu thanh trượt
                        indicatorWeight: 2,
                        labelPadding: const EdgeInsets.only(right: 18),
                        labelColor: const Color(0xffef1951),
                        //color when not selected
                        unselectedLabelColor: Colors.grey,
                        //color when selected
                        tabs: const [
                          Text("Featured", style: TextStyle(fontSize: 17),),
                          Text("New release", style: TextStyle(fontSize: 17),),
                          Text("series", style: TextStyle(fontSize: 17),),
                        ]),
                  ),
                  //build TabView
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      width: double.maxFinite,
                      // height: (2*(MediaQuery.of(context).size.height))/5,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _featuredPageBloc.tabController,
                          children: [
                            //build Featured TabBar
                            _buildListMoviesWithDotIndicator(context, _featuredPageBloc.listMovieFeatured),
                            // build NewRealese TabBar(),
                            _buildListMoviesWithDotIndicator(context, _featuredPageBloc.listMovieNewRealese),
                            // build Series TabBar(),
                            _buildMoviesListViewTabBar(context, _featuredPageBloc.listMovieSeries),
                          ]),
                    ),
                  ),
                ],
              );
  }
  Widget _buildMoviesListViewTabBar(BuildContext context, Set<Movie> listMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listMovie.length,
      itemBuilder: (context, index) {
        final movie = listMovie.elementAt(index);
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieProfilePage(movie: movie),)),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(movie.urlPhoto, fit: BoxFit.fill)),
        );
      },
    );
  }

  _buildListMoviesWithDotIndicator(BuildContext context, Set<Movie> listMovie) {
    return Stack(
      children: [
        PageView.builder(
          controller: _featuredPageBloc.pageFeaturedController,
          itemCount: listMovie.length,
          itemBuilder: (context, index) {
            final movie = listMovie.elementAt(index);
            final urlPhoto = movie.urlPhoto;
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieProfilePage(movie: movie),)),
              child: MyImageInClipRRect(urlPhoto: urlPhoto, width: MediaQuery.of(context).size.width,),
            );
          },),

        //Dot page indicator
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          child: SmoothPageIndicator(
            controller: _featuredPageBloc.pageFeaturedController,
            count: listMovie.length,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.thin,
            ),),
        )
      ],
    );
  }

  Widget buildWhatToWatchMovies(BuildContext context) {
    return Column(
      children: [
        //build Text "What to watch" on the right
        Container(
            padding: const EdgeInsets.only(top: 10,bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
             "What to watch",
             style: Theme.of(context).textTheme.titleSmall,
            )),
        //build ListView horizontal
        SizedBox(
          height: 120,
            child: _buildListViewMoviesWhatToWatch(listMovieWhatToWatch),
        ),
      ],
    );
  }
  Widget _buildListViewMoviesWhatToWatch(Set<Movie> listMovieWhatToWatch) {
    final width = MediaQuery.of(context).size.width;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: listMovieWhatToWatch.length,
      itemBuilder: (context, index) {
        final movie = listMovieWhatToWatch.elementAt(index);
        final urlPhoto = movie.urlPhoto;
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieProfilePage(movie: movie),)),
          child: MyImageInClipRRect(width: 3*(width-20)/10, urlPhoto: urlPhoto),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: ((width-20)/20),); },
    );
  }
}





