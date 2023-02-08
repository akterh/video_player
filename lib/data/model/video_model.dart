class VideoModel {
  VideoModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.caption,
    this.videoUrl,
    this.createdAt,
  });

  int? id;
  String? caption;
  String? videoUrl;
  DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    caption: json["caption"],
    videoUrl: json["video_url"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "caption": caption,
    "video_url": videoUrl,
    "created_at": createdAt,
  };
}
