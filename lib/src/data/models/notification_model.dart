import 'package:json_annotation/json_annotation.dart';
import 'package:smart_school/src/data/data.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationRequest {
  String type;

  NotificationRequest({this.type}) {
    this.type = AppData().readLastUser().studentRecord.role;
  }

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Notifications {
  int success;
  @JsonKey(defaultValue: [])
  List<NotificationData> data;

  Notifications({this.data, this.success});

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}

@JsonSerializable()
class NotificationData {
  String id;
  String title;
  String date;
  String message;

  NotificationData({
    this.id,
    this.title,
    this.date,
    this.message,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}
