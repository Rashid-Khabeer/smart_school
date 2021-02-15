import 'package:json_annotation/json_annotation.dart';

part 'hostels_model.g.dart';

@JsonSerializable()
class Hostels {
  String success;
  List<HostelData> data;

  Hostels({this.data, this.success});

  factory Hostels.fromJson(Map<String, dynamic> json) =>
      _$HostelsFromJson(json);

  Map<String, dynamic> toJson() => _$HostelsToJson(this);
}

@JsonSerializable()
class HostelData {
  String id;
  @JsonKey(name: 'hostel_name')
  String hostelName;
  String type;

  HostelData({
    this.type,
    this.id,
    this.hostelName,
  });

  factory HostelData.fromJson(Map<String, dynamic> json) =>
      _$HostelDataFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDataToJson(this);
}

@JsonSerializable()
class HostelDetailRequest {
  @JsonKey(name: 'student_id')
  String studentId;
  String hostelId;

  HostelDetailRequest({this.studentId, this.hostelId});

  factory HostelDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$HostelDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDetailRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HostelDetail {
  String success;
  List<HostelDetailData> data;

  HostelDetail({this.success, this.data});

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
    this.roomNo,
    this.studentId,
    this.costPerBed,
    this.roomType,
    this.noOfBed,
  });

  factory HostelDetailData.fromJson(Map<String, dynamic> json) =>
      _$HostelDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$HostelDetailDataToJson(this);
}
