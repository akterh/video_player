import 'package:flutter/cupertino.dart';
import 'package:task_app/data/model/video_model.dart';
import 'package:task_app/data/repository/video_repo.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  VideoRepo videoRepo = VideoRepo();
  VideoModel _videoData = VideoModel();
  List<VideoPlayerController>? _controller;
  bool _isPlaying = false;
  int _currentIndex = -1;

  VideoModel get videoData => _videoData;

  List<VideoPlayerController>? get controller => _controller;

  bool get isPlaying => _isPlaying;

  void getVideoData() async {
    final videoData = await videoRepo.getVideoData();
    _videoData = videoData;
    getVideoController();
    notifyListeners();
  }

  void getVideoController() {
    List<VideoPlayerController> controllerList = [];
    for (int i = 0; i < videoData.data!.length; i++) {
      controllerList.add(
          VideoPlayerController.network(videoData.data![i].videoUrl!)
            ..initialize());
    }
    _controller = controllerList;
    notifyListeners();
  }

  bool isPlayingVideo(index) {
    return _currentIndex == index;
  }

  void getPlayVideo(int index) {
    if(_currentIndex!=index){
      _currentIndex = index;
    }else{
      _currentIndex=-1;
    }
    controller![index].value.isPlaying
        ? controller![index].pause()
        : controller![index].play();
    notifyListeners();
  }

}
