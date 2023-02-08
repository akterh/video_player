import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/video_provider.dart';
import 'package:task_app/utils/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        leading: const CircleAvatar(
          backgroundColor: ColorResource.primaryColor,
          child: Icon(
            Icons.camera_alt_outlined,
            color: ColorResource.blackColor,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: ColorResource.primaryColor,
            child: Icon(Icons.notifications_active,
                color: ColorResource.blackColor),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<VideoProvider>(
            builder: (_, providerSnapshot, child) {
              return providerSnapshot.videoData.data == null
                  ? const Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
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
                                  Text(providerSnapshot
                                      .videoData.data![index].caption
                                      .toString()),
                                  Text(DateFormat('yyyy-MM-dd – kk:mm').format(providerSnapshot.videoData.data![index].createdAt!)),
                                  const Spacer(),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundColor:
                                            ColorResource.whiteColor,
                                        child: IconButton(
                                          icon: const Icon(Icons.play_arrow),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
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
