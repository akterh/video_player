import '../model/video_model.dart';
import '../../utils/api_client.dart';
import '../../utils/app_constants.dart';
class VideoRepo{
  Future<VideoModel> getVideoData()async{
   try{
     var response = await ApiClient.get(AppConstants.apiUrl);
     return VideoModel.fromJson(response);
   }catch(e){
     rethrow;
   }
  }
}