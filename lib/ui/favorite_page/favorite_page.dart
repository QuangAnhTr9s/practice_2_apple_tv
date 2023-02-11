import 'package:flutter/material.dart';
import 'package:practice_2_apple_tv/custom_widget/custom_image_cliprrect.dart';
import 'package:practice_2_apple_tv/ui/favorite_page/favorite_page_bloc.dart';

import '../../models/movie.dart';
import '../movie_profile_page/movie_profile_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  //init FavoritePageBloc
  final _favoritePageBloc = FavoritePageBloc();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _favoritePageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _favoritePageBloc.getListMovieFavorite(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('An error has occurred');
                }
                Set<Movie>? listMovie = snapshot.data;
                return listMovie == null || listMovie.isEmpty ? buildTextEmptyListMovie() : buildListViewMovies(listMovie);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Center buildTextEmptyListMovie() => const Center(child: Text("Your favorites list is empty!", style: TextStyle(fontSize: 20, color: Colors.white),),);

  Widget buildListViewMovies(Set<Movie> listMovie) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: listMovie.length,
      itemBuilder: (context, index) {
        final movie = listMovie.elementAt(index);
        final urlPhoto = movie.urlPhoto;
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieProfilePage(movie: movie),)),
          child: Stack(
            children: [
              MyImageInClipRRect(width: 400, urlPhoto: urlPhoto),
              Positioned(
                left: 10,
                  bottom: 10,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      minWidth: 110,
                    ),
                    padding: const EdgeInsets.all(5),
                    width: 100,
                    decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text(movie.name, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),))))
            ],
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
    );
  }
}
