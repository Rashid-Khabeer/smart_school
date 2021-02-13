import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign-in_model.g.dart';

@JsonSerializable()
class SignInRequest {
  @JsonKey(name: "username")
  String userName;
  String password;
  String deviceToken;

  SignInRequest({
    this.password,
    this.userName,
    this.deviceToken,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class SignInResponse extends HiveObject {
  @JsonKey(name: "id")
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String token;
  @JsonKey(name: "record")
  @HiveField(2)
  final StudentRecord studentRecord;

  SignInResponse({
    this.studentRecord,
    this.userId,
    this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class StudentRecord extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "student_id")
  final String studentId;
  @HiveField(1)
  final String role;
  @JsonKey(name: "username")
  @HiveField(2)
  final String userName;
  @JsonKey(name: "class")
  @HiveField(3)
  final String className;
  @HiveField(4)
  final String section;
  @JsonKey(name: "date_format")
  @HiveField(5)
  final String dateFormat;
  @JsonKey(name: "currency_symbol")
  @HiveField(6)
  final String currencySymbol;
  @JsonKey(name: "timezone")
  @HiveField(7)
  final String timeZone;
  @JsonKey(name: "is_rt1")
  @HiveField(8)
  final String isRt1;
  @HiveField(9)
  final String theme;
  @HiveField(10)
  final String image;
  @JsonKey(name: "sch_name")
  @HiveField(11)
  final String schoolName;
  @HiveField(12)
  final Language language;

  StudentRecord({
    this.userName,
    this.image,
    this.theme,
    this.className,
    this.currencySymbol,
    this.dateFormat,
    this.isRt1,
    this.role,
    this.section,
    this.studentId,
    this.timeZone,
    this.schoolName,
    this.language,
  });

  factory StudentRecord.fromJson(Map<String, dynamic> json) =>
      _$StudentRecordFromJson(json);

  Map<String, dynamic> toJson() => _$StudentRecordToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 2)
class Language extends HiveObject {
  @JsonKey(name: "lang_id")
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String language;

  Language({this.id, this.language});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class SignOutRequest {
  @JsonKey(name: 'deviceToken')
  String deviceToken;

  SignOutRequest({this.deviceToken});

  factory SignOutRequest.fromJson(Map<String, dynamic> json) =>
      _$SignOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutRequestToJson(this);
}

@JsonSerializable()
class SignOutResponse {
  @JsonKey(name: 'status')
  String status;

  SignOutResponse({this.status});

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      _$SignOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutResponseToJson(this);
}
