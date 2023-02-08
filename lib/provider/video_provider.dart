import 'package:flutter/cupertino.dart';
import 'package:task_app/data/model/video_model.dart';
import 'package:task_app/data/repository/video_repo.dart';

class VideoProvider extends ChangeNotifier {
  VideoRepo videoRepo = VideoRepo();
  VideoModel _videoData = VideoModel();

  VideoModel get videoData => _videoData;
  String _playState = "play";

  String get playState => _playState;

  void getVideoData() async {
    final videoData = await videoRepo.getVideoData();
    _videoData = videoData;
    notifyListeners();
  }

  void getVideoPlayingState(String state) {
    _playState = state;
    notifyListeners();
  }
}
