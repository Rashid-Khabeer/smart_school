import 'package:json_annotation/json_annotation.dart';

part 'tasks_model.g.dart';

@JsonSerializable()
class TasksRequest {
  @JsonKey(name: 'user_id')
  String userId;

  TasksRequest({this.userId});

  factory TasksRequest.fromJson(Map<String, dynamic> json) =>
      _$TasksRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TasksRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tasks {
  List<TasksData> data;

  Tasks({this.data});

  factory Tasks.fromJson(Map<String, dynamic> json) => _$TasksFromJson(json);

  Map<String, dynamic> toJson() => _$TasksToJson(this);
}

@JsonSerializable()
class TasksData {
  String id;
  @JsonKey(name: 'event_title')
  String title;
  @JsonKey(name: 'is_active')
  String isActive;
  @JsonKey(name: 'start_date')
  String startDate;

  TasksData({
    this.id,
    this.title,
    this.isActive,
    this.startDate,
  });

  factory TasksData.fromJson(Map<String, dynamic> json) =>
      _$TasksDataFromJson(json);

  Map<String, dynamic> toJson() => _$TasksDataToJson(this);
}
