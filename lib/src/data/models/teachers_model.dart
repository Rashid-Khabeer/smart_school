import 'package:json_annotation/json_annotation.dart';

part 'teachers_model.g.dart';

@JsonSerializable()
class TeachersRequest {
  @JsonKey(name: 'class_id')
  String classId;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'section_id')
  String sectionId;

  TeachersRequest({
    this.sectionId,
    this.classId,
    this.userId,
  });

  factory TeachersRequest.fromJson(Map<String, dynamic> json) =>
      _$TeachersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TeachersRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Teachers {
  @JsonKey(name: 'result_list')
  Map<String, dynamic> resultList;

  Teachers({this.resultList});

  factory Teachers.fromJson(Map<String, dynamic> json) =>
      _$TeachersFromJson(json);

  Map<String, dynamic> toJson() => _$TeachersToJson(this);
}

_rateFromJson(val) => val.toString();

@JsonSerializable(explicitToJson: true)
class TeachersData {
  @JsonKey(name: 'staff_name')
  String staffName;
  @JsonKey(name: 'staff_surname')
  String staffSurName;
  @JsonKey(name: 'employee_id')
  String employeeId;
  @JsonKey(name: 'contact_no')
  String contactNo;
  String email;
  @JsonKey(name: 'class_teacher_id')
  String classTeacherId;
  @JsonKey(name: 'staff_id')
  String staffId;
  @JsonKey(fromJson: _rateFromJson)
  String rate;
  List<TeachersSubject> subjects;

  TeachersData({
    this.email,
    this.staffId,
    this.classTeacherId,
    this.contactNo,
    this.employeeId,
    this.rate,
    this.staffName,
    this.staffSurName,
    this.subjects,
  });

  factory TeachersData.fromJson(Map<String, dynamic> json) =>
      _$TeachersDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeachersDataToJson(this);
}

@JsonSerializable()
class TeachersSubject {
  @JsonKey(name: 'subject_id')
  String subjectId;
  @JsonKey(name: 'subject_name')
  String subjectName;
  String code;
  String type;
  String day;
  @JsonKey(name: 'time_from')
  String timeFrom;
  @JsonKey(name: 'time_to')
  String timeTo;
  @JsonKey(name: 'room_no')
  String roomNo;

  TeachersSubject({
    this.subjectName,
    this.timeFrom,
    this.roomNo,
    this.type,
    this.day,
    this.code,
    this.timeTo,
    this.subjectId,
  });

  factory TeachersSubject.fromJson(Map<String, dynamic> json) =>
      _$TeachersSubjectFromJson(json);

  Map<String, dynamic> toJson() => _$TeachersSubjectToJson(this);
}

@JsonSerializable()
class TeacherRatingRequest {
  String rate;
  String comment;
  @JsonKey(name: 'staff_id')
  String staffId;
  @JsonKey(name: 'user_id')
  String userId;
  String role;

  TeacherRatingRequest({
    this.comment,
    this.rate,
    this.staffId,
    this.role,
    this.userId,
  });

  factory TeacherRatingRequest.fromJson(Map<String, dynamic> json) =>
      _$TeacherRatingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherRatingRequestToJson(this);
}

@JsonSerializable()
class RatingResponse {
  String msg;

  RatingResponse({this.msg});

  factory RatingResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}
