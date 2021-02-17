import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceRequest {
  String year;
  String month;
  @JsonKey(name: 'student_id')
  String studentId;
  String date;

  AttendanceRequest({
    this.date = '',
    this.studentId,
    this.month,
    this.year,
  });

  factory AttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceRequestToJson(this);
}

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
  String date;

  AttendanceDetail({this.type, this.date});

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailToJson(this);
}
