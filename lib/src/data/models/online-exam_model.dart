import 'package:json_annotation/json_annotation.dart';

part 'online-exam_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OnlineExam {
  @JsonKey(name: 'onlineexam')
  List<Exam> exams;

  OnlineExam({this.exams});

  factory OnlineExam.fromJson(Map<String, dynamic> json) =>
      _$OnlineExamFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineExamToJson(this);
}

@JsonSerializable()
class Exam {
  String exam;
  String duration;
  String attempt;
  @JsonKey(name: 'exam_from')
  String examFrom;
  @JsonKey(name: 'exam_to')
  String examTo;
  String attempts;
  String id;
  @JsonKey(name: 'onlineexam_student_id')
  String onlineExamStudentId;
  @JsonKey(name: 'publish_result')
  String publishResult;
  @JsonKey(name: 'is_submitted')
  String isSubmitted;

  Exam({
    this.id,
    this.exam,
    this.attempt,
    this.attempts,
    this.duration,
    this.examFrom,
    this.examTo,
    this.isSubmitted,
    this.onlineExamStudentId,
    this.publishResult,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
