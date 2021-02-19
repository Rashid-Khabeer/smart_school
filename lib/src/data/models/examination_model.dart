import 'package:json_annotation/json_annotation.dart';

part 'examination_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Examination {
  @JsonKey(name: 'examSchedule')
  List<ExaminationDetail> detail;

  Examination({this.detail});

  factory Examination.fromJson(Map<String, dynamic> json) =>
      _$ExaminationFromJson(json);

  Map<String, dynamic> toJson() => _$ExaminationToJson(this);
}

@JsonSerializable()
class ExaminationDetail {
  String exam;
  @JsonKey(name: 'result_publish')
  String resultPublish;
  @JsonKey(name: 'exam_group_class_batch_exam_id')
  String examId;
  String id;

  ExaminationDetail({
    this.exam,
    this.id,
    this.examId,
    this.resultPublish,
  });

  factory ExaminationDetail.fromJson(Map<String, dynamic> json) =>
      _$ExaminationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExaminationDetailToJson(this);
}

@JsonSerializable()
class ExamResultRequest {
  @JsonKey(name: "student_id")
  String id;
  @JsonKey(name: "exam_group_class_batch_exam_id")
  String examId;

  ExamResultRequest({this.id, this.examId});

  factory ExamResultRequest.fromJson(Map<String, dynamic> json) =>
      _$ExamResultRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExamResult {
  ExamResultDetail exam;

  ExamResult({this.exam});

  factory ExamResult.fromJson(Map<String, dynamic> json) =>
      _$ExamResultFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExamResultDetail {
  String exam;
  @JsonKey(name: "exam_type")
  String examType;
  @JsonKey(name: "exam_credit_hour")
  int examCreditHour;
  @JsonKey(name: "exam_quality_points")
  int examQualityPoints;
  @JsonKey(name: "exam_grade")
  String examGrade;
  @JsonKey(name: "is_consolidate")
  int isConsolidate;
  @JsonKey(name: "percentage")
  int percentage;
  @JsonKey(name: "division")
  String division;
  @JsonKey(name: "total_get_marks")
  int getMarks;
  @JsonKey(name: "total_max_marks")
  int totalMarks;
  @JsonKey(name: "exam_result_status")
  String resultStatus;
  @JsonKey(name: "subject_result")
  List<SubjectResult> subjectResult;

  ExamResultDetail({
    this.exam,
    this.division,
    this.examCreditHour,
    this.examGrade,
    this.examQualityPoints,
    this.examType,
    this.getMarks,
    this.isConsolidate,
    this.percentage,
    this.resultStatus,
    this.subjectResult,
    this.totalMarks,
  });

  factory ExamResultDetail.fromJson(Map<String, dynamic> json) =>
      _$ExamResultDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultDetailToJson(this);
}

@JsonSerializable()
class SubjectResult {
  String name;
  @JsonKey(name: "min_marks")
  String minMarks;
  @JsonKey(name: "get_marks")
  String getMarks;
  @JsonKey(name: "max_marks")
  String maxMarks;
  @JsonKey(name: "attendence")
  String attendance;
  @JsonKey(name: "credit_hours")
  String creditHours;
  @JsonKey(name: "exam_quality_points")
  String examQualityPoints;
  @JsonKey(name: "exam_grade_point")
  String examGradePoints;
  @JsonKey(name: "exam_grade")
  String examGrade;
  String note;

  SubjectResult({
    this.getMarks,
    this.attendance,
    this.name,
    this.note,
    this.maxMarks,
    this.minMarks,
    this.examQualityPoints,
    this.examGrade,
    this.creditHours,
    this.examGradePoints,
  });

  factory SubjectResult.fromJson(Map<String, dynamic> json) =>
      _$SubjectResultFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectResultToJson(this);
}

@JsonSerializable()
class ExamScheduleRequest {
  @JsonKey(name: 'exam_group_class_batch_exam_id')
  String id;

  ExamScheduleRequest({this.id});

  factory ExamScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$ExamScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExamScheduleRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExamSchedule {
  @JsonKey(name: 'exam_subjects')
  List<ExamScheduleDetail> detail;

  ExamSchedule({this.detail});

  factory ExamSchedule.fromJson(Map<String, dynamic> json) =>
      _$ExamScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ExamScheduleToJson(this);
}

@JsonSerializable()
class ExamScheduleDetail {
  @JsonKey(name: 'subject_code')
  String subjectCode;
  @JsonKey(name: 'subject_name')
  String subjectName;
  @JsonKey(name: 'date_from')
  String dateFrom;
  @JsonKey(name: 'time_from')
  String timeFrom;
  @JsonKey(name: 'room_no')
  String roomNo;
  @JsonKey(name: 'credit_hours')
  String creditHours;
  String duration;
  @JsonKey(name: 'max_marks')
  String maxMarks;
  @JsonKey(name: 'min_marks')
  String minMarks;

  ExamScheduleDetail({
    this.subjectCode,
    this.creditHours,
    this.minMarks,
    this.maxMarks,
    this.duration,
    this.dateFrom,
    this.roomNo,
    this.timeFrom,
    this.subjectName,
  });

  factory ExamScheduleDetail.fromJson(Map<String, dynamic> json) =>
      _$ExamScheduleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExamScheduleDetailToJson(this);
}
