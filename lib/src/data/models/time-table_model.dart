import 'package:json_annotation/json_annotation.dart';

part 'time-table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeTable {
  @JsonKey(name: 'timetable')
  TimeWeek timeWeek;

  TimeTable({this.timeWeek});
  factory TimeTable.fromJson(Map<String, dynamic> json) =>
      _$TimeTableFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTableToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TimeWeek {
  @JsonKey(name: 'Sunday')
  List<Days> sunday;
  @JsonKey(name: 'Monday')
  List<Days> monday;
  @JsonKey(name: 'Tuesday')
  List<Days> tuesday;
  @JsonKey(name: 'Wednesday')
  List<Days> wednesday;
  @JsonKey(name: 'Thursday')
  List<Days> thursday;
  @JsonKey(name: 'Friday')
  List<Days> friday;
  @JsonKey(name: 'Saturday')
  List<Days> saturday;

  TimeWeek({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });
  factory TimeWeek.fromJson(Map<String, dynamic> json) =>
      _$TimeWeekFromJson(json);

  Map<String, dynamic> toJson() => _$TimeWeekToJson(this);
}

@JsonSerializable()
class Days {
  String code;
  @JsonKey(name: 'subject_name')
  String subjectName;
  @JsonKey(name: 'time_from')
  String timeFrom;
  @JsonKey(name: 'time_to')
  String timeTo;
  @JsonKey(name: 'room_no')
  String roomNo;

  Days({
    this.code,
    this.roomNo,
    this.subjectName,
    this.timeFrom,
    this.timeTo,
  });
  factory Days.fromJson(Map<String, dynamic> json) =>
      _$DaysFromJson(json);

  Map<String, dynamic> toJson() => _$DaysToJson(this);
}
