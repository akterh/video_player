import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/video_provider.dart';
import 'package:task_app/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _clickedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    Provider.of<VideoProvider>(context, listen: false).getVideoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Explore",
          style: TextStyle(color: ColorResource.blackColor),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const CircleAvatar(
            backgroundColor: ColorResource.primaryColor,
            child: Icon(
              Icons.camera_alt_outlined,
              color: ColorResource.blackColor,
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: ColorResource.primaryColor,
              child: Icon(Icons.notifications_active,
                  color: ColorResource.blackColor),
            ),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<VideoProvider>(
            builder: (_, videoDataProviderSnapshot, child) {
              return videoDataProviderSnapshot.controller == null
                  ? const Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:
                          videoDataProviderSnapshot.videoData.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .33,
                            decoration: BoxDecoration(
                              color: ColorResource.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    videoDataProviderSnapshot
                                        .videoData.data![index].caption
                                        .toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                      DateFormat('hh:mm a').format(
                                          videoDataProviderSnapshot.videoData
                                              .data![index].createdAt!),
                                      style: TextStyle(fontSize: 18)),
                                  const Spacer(),
                                  Stack(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 10 / 6,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child:
                                                  // Provider.of<VideoProvider>(
                                                  //             context,
                                                  //             listen: false)
                                                  //         .isPlayingVideo(index)
                                                  //     ?
                                                  VideoPlayer(
                                                      videoDataProviderSnapshot
                                                          .controller![index])
                                              // : Container(
                                              //     decoration: BoxDecoration(
                                              //       image: DecorationImage(image:NetworkImage("https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),fit: BoxFit.cover),
                                              //         borderRadius:
                                              //             BorderRadius
                                              //                 .circular(15)),
                                              //   ),
                                              )),
                                      Positioned(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        top:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            icon: Provider.of<VideoProvider>(
                                                        context,
                                                        listen: false)
                                                    .isPlayingVideo(index)
                                                ? const Icon(Icons.pause)
                                                : const Icon(Icons.play_arrow),
                                            onPressed: () {
                                              Provider.of<VideoProvider>(
                                                      context,
                                                      listen: false)
                                                  .getPlayVideo(index);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            },
          )),
    );
  }
}
