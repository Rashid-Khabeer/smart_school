import 'package:json_annotation/json_annotation.dart';
import 'package:smart_school/src/utility/constants.dart';

part 'forgot-password_model.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  String email;
  @JsonKey(name: 'usertype')
  String userType;
  @JsonKey(name: 'site_url')
  String siteUrl;

  ForgotPasswordRequest({
    this.email,
    this.siteUrl,
    this.userType,
  }) {
    this.siteUrl = kDomainUrl;
  }

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse {
  String message;

  ForgotPasswordResponse({this.message});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
