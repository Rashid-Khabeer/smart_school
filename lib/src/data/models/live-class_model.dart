import 'package:json_annotation/json_annotation.dart';

part 'live-class_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LiveClass {
  @JsonKey(name: 'live_classes')
  List<LiveClassData> liveClassData;

  LiveClass({this.liveClassData});

  factory LiveClass.fromJson(Map<String, dynamic> json) =>
      _$LiveClassFromJson(json);

  Map<String, dynamic> toJson() => _$LiveClassToJson(this);
}

@JsonSerializable()
class LiveClassData {
  String title;
  String id;
  String date;
  @JsonKey(name: 'join_url')
  String joinUrl;
  String status;
  @JsonKey(name: 'class')
  String className;
  String section;

  LiveClassData({
    this.date,
    this.status,
    this.id,
    this.section,
    this.className,
    this.joinUrl,
    this.title,
  });

  factory LiveClassData.fromJson(Map<String, dynamic> json) =>
      _$LiveClassDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveClassDataToJson(this);
}

@JsonSerializable()
class LiveClassHistory {
  @JsonKey(name: 'msg')
  String message;

  LiveClassHistory({this.message});

  factory LiveClassHistory.fromJson(Map<String, dynamic> json) =>
      _$LiveClassHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$LiveClassHistoryToJson(this);
}

@JsonSerializable()
class LiveClassRequest {
  @JsonKey(name: "student_id")
  String id;
  @JsonKey(name: 'conference_id')
  String conferenceId;

  LiveClassRequest({this.id, this.conferenceId});

  factory LiveClassRequest.fromJson(Map<String, dynamic> json) =>
      _$LiveClassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LiveClassRequestToJson(this);
}
