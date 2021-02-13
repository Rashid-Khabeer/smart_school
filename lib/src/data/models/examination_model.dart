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
