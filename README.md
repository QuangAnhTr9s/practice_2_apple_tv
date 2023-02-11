# practice_2_apple_tv

HomePage => FeaturedPage <=> MovieProfilePage
         => ChannelsPage
         => FavoritePage <=> MovieProfilePage
         => PlaylistPage
* FeaturedPage:
    - Featured Tab: All movie have IMDb score >= 8.0.
    - New Release Tab: All movies with production year from 2020.
    - series Tab: Spider-Man series.
    - What to watch: List of 5 random movies in all movies (Refresh every time User open/close the app).

* ChannelPage:
    - Channel Tab: List 4 Channel (User can bookmark channels by pressing Like button).
    - Trending Tab.
    - series Tab.
  
* FavoritePage: 
    - List favorite movies is created by User (click Like Button in MovieProfilePage).

* MovieProfilePage:
    - Information of the movie (User can bookmark movies by pressing Like button).
    - More Movie: List of other movies with production year before and after 2 years the movie is showing.
* PlaylistPage.

* State Management: Bloc.

* Save Favorite Movie, Favorite Channel by Shared Preferences.

* Custom Wiget show Images with ClipRRect and SizeBox.