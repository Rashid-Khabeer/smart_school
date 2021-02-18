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
  List<TasksData> tasks;

  Tasks({this.tasks});

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

@JsonSerializable()
class AddTask {
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'event_title')
  String title;
  String date;

  AddTask({
    this.title,
    this.userId,
    this.date,
  });

  factory AddTask.fromJson(Map<String, dynamic> json) =>
      _$AddTaskFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskToJson(this);
}

@JsonSerializable()
class UpdateTask {
  @JsonKey(name: 'task_id')
  String id;
  String status;

  UpdateTask({this.status, this.id});

  factory UpdateTask.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaskFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaskToJson(this);
}

@JsonSerializable()
class DeleteTask {
  @JsonKey(name: 'task_id')
  String id;

  DeleteTask({this.id});

  factory DeleteTask.fromJson(Map<String, dynamic> json) =>
      _$DeleteTaskFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTaskToJson(this);
}
