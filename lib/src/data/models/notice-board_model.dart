import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice-board_model.g.dart';

@JsonSerializable()
class NoticeBoardRequest {
  String type;

  NoticeBoardRequest({@required this.type});

  factory NoticeBoardRequest.fromJson(Map<String, dynamic> json) =>
      _$NoticeBoardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeBoardRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NoticeBoard {
  List<NoticeBoardData> data;

  NoticeBoard({this.data});

  factory NoticeBoard.fromJson(Map<String, dynamic> json) =>
      _$NoticeBoardFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeBoardToJson(this);
}

@JsonSerializable()
class NoticeBoardData {
  String id;
  String title;
  String date;
  String message;

  NoticeBoardData({
    this.date,
    this.id,
    this.title,
    this.message,
  });

  factory NoticeBoardData.fromJson(Map<String, dynamic> json) =>
      _$NoticeBoardDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeBoardDataToJson(this);
}
