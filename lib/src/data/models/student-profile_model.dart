import 'package:json_annotation/json_annotation.dart';

part 'student-profile_model.g.dart';

@JsonSerializable()
class StudentRequest {
  @JsonKey(name: "student_id")
  String id;

  StudentRequest({this.id});

  factory StudentRequest.fromJson(Map<String, dynamic> json) =>
      _$StudentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StudentRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StudentProfile {
  @JsonKey(name: 'student_result')
  StudentResult studentResult;

  @JsonKey(name: 'student_fields')
  StudentFields studentFields;

  StudentProfile({
    this.studentResult,
    this.studentFields,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileToJson(this);
}

@JsonSerializable()
class StudentResult {
  @JsonKey(name: 'transport_fees')
  String transportFees;
  @JsonKey(name: 'vehroute_id')
  String vehicleRouteId;
  @JsonKey(name: 'route_id')
  String routeId;
  @JsonKey(name: 'vehicle_id')
  String vehicleId;
  @JsonKey(name: 'route_title')
  String routeTitle;
  @JsonKey(name: 'vehicle_no')
  String vehicleNo;
  @JsonKey(name: 'room_no')
  String roomNo;
  @JsonKey(name: 'driver_name')
  String driverName;
  @JsonKey(name: 'driver_contact')
  String driverContact;
  @JsonKey(name: 'hostel_id')
  String hostelId;
  @JsonKey(name: 'hostel_name')
  String hostelName;
  @JsonKey(name: 'room_type_id')
  String roomTypeId;
  @JsonKey(name: 'room_type')
  String roomType;
  @JsonKey(name: 'hostel_room_id')
  String hostelRoomId;
  @JsonKey(name: 'student_session_id')
  String studentSessionId;
  @JsonKey(name: 'fees_discount')
  String feesDiscount;
  @JsonKey(name: 'class_id')
  String classId;
  @JsonKey(name: 'class')
  String className;
  @JsonKey(name: 'section_id')
  String sectionId;
  @JsonKey(name: 'section')
  String section;
  String id;
  @JsonKey(name: 'admission_no')
  String admissionNo;
  @JsonKey(name: 'roll_no', nullable: true, defaultValue: '')
  String rollNo;
  @JsonKey(name: 'admission_date')
  String admissionDate;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastname', nullable: true, defaultValue: '')
  String lastName;
  String image;
  @JsonKey(name: 'mobile_no')
  String mobileNo;
  String email;
  String state;
  String city;
  String pinCode;
  String religion;
  @JsonKey(nullable: true, defaultValue: '')
  String cast;
  @JsonKey(name: 'house_name')
  String houseName;
  String dob;
  @JsonKey(name: 'current_address')
  String currentAddress;
  @JsonKey(name: 'permanent_address')
  String permanentAddress;
  @JsonKey(name: 'previous_school')
  String previousSchool;
  @JsonKey(name: 'guardian_is')
  String guardianIs;
  @JsonKey(name: 'parent_id')
  String parentId;
  @JsonKey(name: 'category_id')
  String categoryId;
  @JsonKey(name: 'adhar_no')
  String adharNo;
  @JsonKey(name: 'samagra_no')
  String samagraId;
  @JsonKey(name: 'bank_account_no', nullable: true, defaultValue: '')
  String bankAccountNo;
  @JsonKey(name: 'bank_name', nullable: true, defaultValue: '')
  String bankName;
  @JsonKey(name: 'ifsc_code', nullable: true, defaultValue: '')
  String ifscCode;
  @JsonKey(name: 'guardian_name')
  String guardianName;
  @JsonKey(name: 'father_pic')
  String fatherPic;
  String height;
  String weight;
  @JsonKey(name: 'measurement_date')
  String measurementDate;
  @JsonKey(name: 'mother_pic')
  String motherPic;
  @JsonKey(name: 'guardian_pic')
  String guardianPic;
  @JsonKey(name: 'guardian_relation')
  String guardianRelation;
  @JsonKey(name: 'guardian_phone')
  String guardianPhone;
  @JsonKey(name: 'guardian_address')
  String guardianAddress;
  @JsonKey(name: 'is_active')
  String isActive;
  @JsonKey(name: 'father_name')
  String fatherName;
  @JsonKey(name: 'father_phone')
  String fatherPhone;
  @JsonKey(name: 'blood_group')
  String bloodGroup;
  @JsonKey(name: 'school_house_id')
  String schoolHouseId;
  @JsonKey(name: 'father_occupation')
  String fatherOccupation;
  @JsonKey(name: 'mother_name')
  String motherName;
  @JsonKey(name: 'mother_phone')
  String motherPhone;
  @JsonKey(name: 'mother_occupation')
  String motherOccupation;
  @JsonKey(name: 'guardian_occupation')
  String guardianOccupation;
  String gender;
  @JsonKey(nullable: true, defaultValue: '')
  String rte;
  @JsonKey(name: 'guardian_email')
  String guardianEmail;
  String category;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at', nullable: true, defaultValue: '')
  String updatedAt;

  StudentResult({
    this.id,
    this.className,
    this.adharNo,
    this.admissionDate,
    this.admissionNo,
    this.bankAccountNo,
    this.bankName,
    this.bloodGroup,
    this.cast,
    this.category,
    this.categoryId,
    this.city,
    this.driverName,
    this.classId,
    this.createdAt,
    this.currentAddress,
    this.dob,
    this.driverContact,
    this.email,
    this.fatherName,
    this.fatherOccupation,
    this.fatherPhone,
    this.fatherPic,
    this.feesDiscount,
    this.firstName,
    this.gender,
    this.guardianAddress,
    this.guardianEmail,
    this.guardianIs,
    this.guardianName,
    this.motherPhone,
    this.guardianPhone,
    this.guardianPic,
    this.guardianRelation,
    this.height,
    this.hostelId,
    this.hostelName,
    this.hostelRoomId,
    this.houseName,
    this.ifscCode,
    this.image,
    this.isActive,
    this.lastName,
    this.measurementDate,
    this.mobileNo,
    this.motherName,
    this.parentId,
    this.motherOccupation,
    this.motherPic,
    this.permanentAddress,
    this.pinCode,
    this.previousSchool,
    this.religion,
    this.rollNo,
    this.roomNo,
    this.roomType,
    this.roomTypeId,
    this.routeId,
    this.routeTitle,
    this.rte,
    this.schoolHouseId,
    this.section,
    this.sectionId,
    this.samagraId,
    this.state,
    this.studentSessionId,
    this.transportFees,
    this.updatedAt,
    this.vehicleId,
    this.vehicleNo,
    this.vehicleRouteId,
    this.weight,
    this.guardianOccupation,
  });

  factory StudentResult.fromJson(Map<String, dynamic> json) =>
      _$StudentResultFromJson(json);

  Map<String, dynamic> toJson() => _$StudentResultToJson(this);
}

@JsonSerializable()
class StudentFields {
  @JsonKey(name: 'blood_group')
  int bloodGroup;
  int category;
  int religion;
  @JsonKey(name: 'mobile_no')
  int mobileNo;
  @JsonKey(name: 'student_email')
  int studentEmail;
  @JsonKey(name: 'admission_date')
  int admissionDate;
  @JsonKey(name: 'student_photo')
  int studentPhoto;
  @JsonKey(name: 'measurement_date')
  int measurementDate;
  @JsonKey(name: 'father_name')
  int fatherName;
  @JsonKey(name: 'father_phone')
  int fatherPhone;
  @JsonKey(name: 'father_occupation')
  int fatherOccupation;
  @JsonKey(name: 'mother_name')
  int motherName;
  @JsonKey(name: 'mother_phone')
  int motherPhone;
  @JsonKey(name: 'mother_occupation')
  int motherOccupation;
  @JsonKey(name: 'guardian_relation')
  int guardianRelation;
  @JsonKey(name: 'guardian_address')
  int guardianAddress;
  @JsonKey(name: 'current_address')
  int currentAddress;

  StudentFields({
    this.religion,
    this.motherOccupation,
    this.motherName,
    this.mobileNo,
    this.measurementDate,
    this.guardianRelation,
    this.guardianAddress,
    this.fatherPhone,
    this.fatherOccupation,
    this.fatherName,
    this.currentAddress,
    this.category,
    this.admissionDate,
    this.bloodGroup,
    this.motherPhone,
    this.studentEmail,
    this.studentPhoto,
  });

  factory StudentFields.fromJson(Map<String, dynamic> json) =>
      _$StudentFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$StudentFieldsToJson(this);
}
