import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Attendance {
  @JsonKey(name: 'attendence_type')
  String attendanceType;
  List<AttendanceDetail> data;

  Attendance({this.data, this.attendanceType});

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}

@JsonSerializable()
class AttendanceDetail {
  String type;

  AttendanceDetail({this.type});

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailToJson(this);
}
