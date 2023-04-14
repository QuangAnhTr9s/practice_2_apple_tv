import 'package:flutter/material.dart';
import 'package:practice_2_apple_tv/custom_widget/custom_image_cliprrect.dart';
import 'package:practice_2_apple_tv/ui/channels_page/channels_page_bloc.dart';

import '../../models/channel.dart';


class ChannelsPage extends StatefulWidget{
  const ChannelsPage({super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> with TickerProviderStateMixin{
  
  late final ChannelsPageBloc _channelsPageBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _channelsPageBloc = ChannelsPageBloc();
    _channelsPageBloc.tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    _channelsPageBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey.shade800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //build TabBar
              SizedBox(
                height: 30,
                // alignment: Alignment.topLeft,
                child: TabBar(
                    controller: _channelsPageBloc.tabController,
                    indicator: const BoxDecoration(), //=> not show indicator
                    // isScrollable: true,
                    indicatorColor: Colors.grey,// màu thanh trượt
                    indicatorWeight: 2,
                    labelPadding: const EdgeInsets.only(right: 18),
                    labelColor: const Color(0xffef1951),
                    //color when not selected
                    unselectedLabelColor: Colors.grey,
                    //color when selected
                    tabs: const [
                      Text("Channels", style: TextStyle(fontSize: 17),),
                      Text("Trending", style: TextStyle(fontSize: 17),),
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
                      controller: _channelsPageBloc.tabController,
                      children: [
                        //build Featured TabBar
                        _buildFeaturedTabView(context),
                        // build NewRealese TabBar(),
                        const Center(child: Text("Trending Tab View")),
                        // build Series TabBar(),
                        const Center(child: Text("series Tab View")),
                      ]),
                ),
              ),
            ],
          ),
      ),
    );
  }
  Widget _buildFeaturedTabView(BuildContext context){
    //load data list favorite channel from MySharedPreferences and update for channel in Fake Data
    return FutureBuilder(
      future: _channelsPageBloc.compareAndUpdateListChannel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('An error has occurred');
          }
          final listChannels = snapshot.data!;
          return _buildGridViewChannel(listChannels);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  GridView _buildGridViewChannel(Set<Channel> listChannels) {
    return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1/2,
                mainAxisExtent: 350,
              ),
              itemCount: listChannels.length,
              itemBuilder: (context, index) {
                final channel = listChannels.elementAt(index);
                final imageUrl = channel.imageUrl;
                return SizedBox(
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyImageInClipRRect(width: 200, height: 250 ,urlPhoto: imageUrl),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 34,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(channel.name,
                                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.white),)),
                                StreamBuilder<bool>(
                                    stream: _channelsPageBloc.isLikedStream,
                                    builder: (context, snapshot) {
                                      final isLiked = channel.isLiked;
                                      return IconButton(
                                          onPressed: () async {
                                        await _channelsPageBloc.setIsLiked(channel);
                                        await _channelsPageBloc.handleChannels(channel);
                                        },
                                          icon: Icon(
                                        Icons.thumb_up,
                                        color: isLiked == false ? Colors.grey : IconTheme.of(context).color,));
                                    }
                                )
                              ],
                            ),
                          ),
                          Text(channel.describe, style: const TextStyle(fontSize: 14, color: Colors.grey),),
                          Text('${channel.numberOfChannels} channels', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                        ],
                      ),
                    ],
                  ),
                );
              },
    );
  }
}