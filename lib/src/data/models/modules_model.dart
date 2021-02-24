import 'package:json_annotation/json_annotation.dart';
import 'package:smart_school/src/data/data.dart';

part 'modules_model.g.dart';

@JsonSerializable()
class ModuleRequest {
  String user;

  ModuleRequest({this.user}) {
    this.user = AppData().readLastUser().studentRecord.role;
  }

  factory ModuleRequest.fromJson(Map<String, dynamic> json) =>
      _$ModuleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Modules {
  @JsonKey(name: 'module_list')
  List<ModuleData> data;

  Modules({this.data});

  factory Modules.fromJson(Map<String, dynamic> json) =>
      _$ModulesFromJson(json);

  Map<String, dynamic> toJson() => _$ModulesToJson(this);
}

@JsonSerializable()
class ModuleData {
  @JsonKey(name: 'short_code')
  String shortCode;
  String status;

  ModuleData({this.status, this.shortCode});

  factory ModuleData.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleDataToJson(this);
}
