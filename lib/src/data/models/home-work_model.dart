
import 'package:json_annotation/json_annotation.dart';

part 'home-work_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeWork {
  @JsonKey(name: 'class_id')
  String classId;
  @JsonKey(name: 'section_id')
  String sectionId;
  @JsonKey(name: 'subject_id')
  String subjectId;
  @JsonKey(name: 'homeworklist')
  List<HomeWorkDetail> homeWorks;

  HomeWork({this.sectionId, this.classId, this.homeWorks, this.subjectId});

  factory HomeWork.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkToJson(this);
}

@JsonSerializable()
class HomeWorkDetail {
  String id;
  @JsonKey(name: 'class_id')
  String classId;
  @JsonKey(name: 'section_id')
  String sectionId;
  @JsonKey(name: 'homework_date')
  String homeWorkDate;
  @JsonKey(name: 'submit_date')
  String submitDate;
  @JsonKey(name: 'staff_id')
  String staffId;
  @JsonKey(name: 'subject_group_subject_id')
  String subjectGroupSubjectId;
  @JsonKey(name: 'subject_id')
  @JsonKey(name: 'subject_id')
  String subjectId;
  String description;
  @JsonKey(name: 'create_date')
  String createDate;
  @JsonKey(name: 'evaluation_date')
  String evaluationDate;
  String document;
  @JsonKey(name: 'created_by')
  String createdBy;
  @JsonKey(name: 'evaluated_by')
  String evaluatedBy;
  String name;
  String section;
  @JsonKey(name: 'class')
  String className;
  @JsonKey(name: 'staff_created')
  String staffCreated;
  @JsonKey(name: 'staff_evaluated')
  String staffEvaluated;
  @JsonKey(name: 'homework_evaluation_id')
  String homeWorkEvaluationId;

  HomeWorkDetail({
    this.subjectId,
    this.classId,
    this.sectionId,
    this.className,
    this.section,
    this.id,
    this.createDate,
    this.createdBy,
    this.description,
    this.document,
    this.evaluatedBy,
    this.evaluationDate,
    this.homeWorkDate,
    this.homeWorkEvaluationId,
    this.name,
    this.staffCreated,
    this.staffEvaluated,
    this.staffId,
    this.subjectGroupSubjectId,
    this.submitDate,
  });

  factory HomeWorkDetail.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkDetailFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkDetailToJson(this);
}

@JsonSerializable()
class AddHomeWork {
  @JsonKey(name: 'student_id')
  String studentId;
  @JsonKey(name: 'homework_id')
  String homeWorkId;
  String message;

  AddHomeWork({
    this.message,
    this.studentId,
    this.homeWorkId,
  });

  factory AddHomeWork.fromJson(Map<String, dynamic> json) =>
      _$AddHomeWorkFromJson(json);

  Map<String, dynamic> toJson() => _$AddHomeWorkToJson(this);
}
