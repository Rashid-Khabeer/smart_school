import 'package:json_annotation/json_annotation.dart';

part 'lesson-plan_model.g.dart';

@JsonSerializable()
class LessonPlanRequest {
  @JsonKey(name: 'student_id')
  String studentId;
  @JsonKey(name: 'date_from')
  String dateFrom;
  @JsonKey(name: 'date_to')
  String datTo;

  LessonPlanRequest({
    this.studentId,
    this.dateFrom,
    this.datTo,
  });

  factory LessonPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPlanRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LessonPlan {
  @JsonKey(name: 'timetable')
  LessonWeeks lessonWeeks;

  LessonPlan({this.lessonWeeks});

  factory LessonPlan.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPlanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LessonWeeks {
  @JsonKey(name: 'Monday')
  List<LessonDays> mondayList;
  @JsonKey(name: 'Tuesday')
  List<LessonDays> tuesdayList;
  @JsonKey(name: 'Wednesday')
  List<LessonDays> wednesdayList;
  @JsonKey(name: 'Thursday')
  List<LessonDays> thursdayList;
  @JsonKey(name: 'Friday')
  List<LessonDays> fridayList;
  @JsonKey(name: 'Saturday')
  List<LessonDays> saturdayList;
  @JsonKey(name: 'Sunday')
  List<LessonDays> sundayList;

  LessonWeeks({
    this.mondayList,
    this.fridayList,
    this.saturdayList,
    this.sundayList,
    this.thursdayList,
    this.tuesdayList,
    this.wednesdayList,
  });

  factory LessonWeeks.fromJson(Map<String, dynamic> json) =>
      _$LessonWeeksFromJson(json);

  Map<String, dynamic> toJson() => _$LessonWeeksToJson(this);
}

@JsonSerializable()
class LessonDays {
  String code;
  String name;
  @JsonKey(name: 'time_from')
  String timeFrom;
  @JsonKey(name: 'time_to')
  String timeTo;
  @JsonKey(name: 'subject_syllabus_id')
  String subjectSyllabusId;
  @JsonKey(name: 'class')
  String className;
  String section;
  String date;

  LessonDays({
    this.timeTo,
    this.timeFrom,
    this.code,
    this.name,
    this.subjectSyllabusId,
    this.section,
    this.className,
    this.date,
  });

  factory LessonDays.fromJson(Map<String, dynamic> json) =>
      _$LessonDaysFromJson(json);

  Map<String, dynamic> toJson() => _$LessonDaysToJson(this);
}

@JsonSerializable()
class LessonPlanDetailsRequest {
  @JsonKey(name: 'subject_syllabus_id')
  String subjectSyllabusId;

  LessonPlanDetailsRequest({this.subjectSyllabusId});

  factory LessonPlanDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPlanDetailsRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LessonPlanDetails {
  @JsonKey(nullable: true)
  LessonPlanDetailsData data;

  LessonPlanDetails({this.data});

  factory LessonPlanDetails.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPlanDetailsToJson(this);
}

@JsonSerializable()
class LessonPlanDetailsData {
  String date;
  String presentation;
  String attachment;
  @JsonKey(name: 'lacture_youtube_url')
  String youtube;
  @JsonKey(name: 'lacture_video')
  String lectureVideo;
  @JsonKey(name: 'sub_topic')
  String subTopic;
  @JsonKey(name: 'teaching_method')
  String teachingMethod;
  @JsonKey(name: 'general_objectives')
  String generalObjectives;
  @JsonKey(name: 'previous_knowledge')
  String previousKnowledge;
  @JsonKey(name: 'comprehensive_questions')
  String comprehensiveQuestions;
  String status;
  @JsonKey(name: 'topic_name')
  String topicName;
  @JsonKey(name: 'lesson_name')
  String lessonName;

  LessonPlanDetailsData({
    this.date,
    this.status,
    this.attachment,
    this.comprehensiveQuestions,
    this.generalObjectives,
    this.lectureVideo,
    this.lessonName,
    this.presentation,
    this.previousKnowledge,
    this.subTopic,
    this.teachingMethod,
    this.topicName,
    this.youtube,
  });

  factory LessonPlanDetailsData.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPlanDetailsDataToJson(this);
}
