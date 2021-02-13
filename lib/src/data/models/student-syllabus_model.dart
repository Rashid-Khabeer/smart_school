import 'package:json_annotation/json_annotation.dart';

part 'student-syllabus_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Syllabus {
  @JsonKey(name: 'subjects')
  List<SyllabusStatus> syllabusStatus;

  Syllabus({this.syllabusStatus});

  factory Syllabus.fromJson(Map<String, dynamic> json) =>
      _$SyllabusFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusToJson(this);
}

@JsonSerializable()
class SyllabusStatus {
  @JsonKey(name: 'subject_code')
  String subjectCode;
  @JsonKey(name: 'subject_name')
  String subjectName;
  @JsonKey(name: 'total_complete')
  String totalComplete;
  String total;
  String id;
  @JsonKey(name: 'subject_group_subject_id')
  String subjectGroupSubjectId;

  SyllabusStatus({
    this.id,
    this.subjectName,
    this.subjectGroupSubjectId,
    this.subjectCode,
    this.total,
    this.totalComplete,
  });

  factory SyllabusStatus.fromJson(Map<String, dynamic> json) =>
      _$SyllabusStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusStatusToJson(this);
}

@JsonSerializable()
class SyllabusDetailRequest {
  @JsonKey(name: 'subject_group_subject_id')
  String subjectGroupSubjectId;
  @JsonKey(name: 'subject_group_class_sections_id')
  String subjectGroupClassSectionId;

  SyllabusDetailRequest({
    this.subjectGroupSubjectId,
    this.subjectGroupClassSectionId,
  });

  factory SyllabusDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$SyllabusDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusDetailRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SyllabusDetail {
  String id;
  @JsonKey(name: 'session_id')
  String sessionId;
  String name;
  @JsonKey(name: 'created_at')
  String createdAt;
  String total;
  @JsonKey(name: 'total_complete')
  String totalComplete;
  List<Topics> topics;

  SyllabusDetail({
    this.name,
    this.id,
    this.total,
    this.totalComplete,
    this.createdAt,
    this.sessionId,
    this.topics,
  });

  factory SyllabusDetail.fromJson(Map<String, dynamic> json) =>
      _$SyllabusDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusDetailToJson(this);
}

@JsonSerializable()
class Topics {
  String id;
  String name;
  String status;
  @JsonKey(name: 'complete_date')
  String completeDate;
  @JsonKey(name: 'created_at')
  String createdAt;

  Topics({
    this.createdAt,
    this.id,
    this.name,
    this.status,
    this.completeDate,
  });

  factory Topics.fromJson(Map<String, dynamic> json) => _$TopicsFromJson(json);

  Map<String, dynamic> toJson() => _$TopicsToJson(this);
}
