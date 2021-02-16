import 'package:json_annotation/json_annotation.dart';

part 'hostel_model.g.dart';

@JsonSerializable()
class Hostel {
  List<HostelData> data;

  Hostel({this.data});

  factory Hostel.fromJson(Map<String, dynamic> json) => _$HostelFromJson(json);

  Map<String, dynamic> toJson() => _$HostelToJson(this);
}

@JsonSerializable()
class HostelData {
  String id;
  @JsonKey(name: 'hostel_name')
  String hostelName;

  HostelData({this.id, this.hostelName});

  factory HostelData.fromJson(Map<String, dynamic> json) =>
      _$HostelDataFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDataToJson(this);
}

@JsonSerializable()
class HostelDetailRequest {
  String hostelId;
  @JsonKey(name: 'student_id')
  String studentId;

  HostelDetailRequest({this.hostelId, this.studentId});

  factory HostelDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$HostelDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDetailRequestToJson(this);
}

_successFromJson(val) => val.toString();


@JsonSerializable(explicitToJson: true)
class HostelDetail {
  @JsonKey(fromJson: _successFromJson)
  String success;
  List<HostelDetailData> data;

  HostelDetail({this.data});

  factory HostelDetail.fromJson(Map<String, dynamic> json) =>
      _$HostelDetailFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDetailToJson(this);
}

@JsonSerializable()
class HostelDetailData {
  @JsonKey(name: 'room_type')
  String roomType;
  @JsonKey(name: 'room_no')
  String roomNo;
  @JsonKey(name: 'cost_per_bed')
  String costPerBed;
  @JsonKey(name: 'no_of_bed')
  String noOfBed;
  @JsonKey(name: 'student_id')
  String studentId;

  HostelDetailData({
    this.studentId,
    this.roomNo,
    this.roomType,
    this.costPerBed,
    this.noOfBed,
  });

  factory HostelDetailData.fromJson(Map<String, dynamic> json) =>
      _$HostelDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDetailDataToJson(this);
}
