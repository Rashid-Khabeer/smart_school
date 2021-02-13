import 'package:json_annotation/json_annotation.dart';
import 'package:smart_school/src/data/data.dart';

part 'download_model.g.dart';

@JsonSerializable()
class DownloadRequest {
  String tag;
  String classId;
  String sectionId;

  DownloadRequest(
    this.tag, [
    this.sectionId,
    this.classId,
  ]) {
    this.sectionId = AppData().getSectionId();
    this.classId = AppData().getClassId();
  }

  factory DownloadRequest.fromJson(Map<String, dynamic> json) =>
      _$DownloadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Downloads {
  @JsonKey(name: 'data')
  List<DownloadData> downloads;

  Downloads({this.downloads});

  factory Downloads.fromJson(Map<String, dynamic> json) =>
      _$DownloadsFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadsToJson(this);
}

@JsonSerializable()
class DownloadData {
  String id;
  String title;
  String date;
  String note;
  String file;

  DownloadData({
    this.id,
    this.date,
    this.title,
    this.file,
    this.note,
  });

  factory DownloadData.fromJson(Map<String, dynamic> json) =>
      _$DownloadDataFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadDataToJson(this);
}
