import 'package:json_annotation/json_annotation.dart';

part 'fee_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Fee {
  @JsonKey(name: 'pay_method')
  int payMethod;
  @JsonKey(name: 'grand_fee')
  GrandFee grandFee;
  @JsonKey(name: 'student_due_fee')
  List<StudentDueFee> studentDueFee;
  @JsonKey(name: 'student_discount_fee')
  List<DiscountFee> discountFee;

  Fee({
    this.payMethod,
    this.grandFee,
    this.studentDueFee,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);
}

@JsonSerializable()
class DiscountFee {
  String id;
  String code;
  String amount;
  String status;
  @JsonKey(name: 'payment_id')
  String paymentId;

  DiscountFee({
    this.status,
    this.code,
    this.id,
    this.amount,
    this.paymentId,
  });

  factory DiscountFee.fromJson(Map<String, dynamic> json) =>
      _$DiscountFeeFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountFeeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StudentDueFee {
  String id;
  @JsonKey(name: 'is_system')
  String isSystem;
  @JsonKey(name: 'student_session_id')
  String studentSessionId;
  @JsonKey(name: 'fee_session_group_id')
  String feeSessionGroupId;
  String amount;
  @JsonKey(name: 'is_active')
  String isActive;
  @JsonKey(name: 'created_at')
  String createdAt;
  String name;
  @JsonKey(name: 'fees')
  List<FeeDetail> feeDetails;

  StudentDueFee({
    this.name,
    this.id,
    this.studentSessionId,
    this.isActive,
    this.createdAt,
    this.amount,
    this.feeDetails,
    this.feeSessionGroupId,
    this.isSystem,
  });

  factory StudentDueFee.fromJson(Map<String, dynamic> json) =>
      _$StudentDueFeeFromJson(json);

  Map<String, dynamic> toJson() => _$StudentDueFeeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FeeDetail {
  String id;
  @JsonKey(name: 'is_system')
  String isSystem;
  @JsonKey(name: 'student_session_id')
  String studentSessionId;
  @JsonKey(name: 'fee_session_group_id')
  String feeSessionGroupId;
  String amount;
  @JsonKey(name: 'is_active')
  String isActive;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'fee_groups_feetype_id')
  String feeGroupsFeeTypeId;
  @JsonKey(name: 'due_date')
  String dueDate;
  @JsonKey(name: 'fee_groups_id')
  String feeGroupsId;
  String name;
  @JsonKey(name: 'feetype_id')
  String feeTypeId;
  String code;
  String type;
  @JsonKey(name: 'student_fees_deposite_id')
  String studentFeesDepositId;
  @JsonKey(name: 'amount_detail')
  String amountDetail;
  @JsonKey(name: 'total_amount_paid')
  String totalAmountPaid;
  @JsonKey(name: 'total_amount_discount')
  String totalAmountDiscount;
  @JsonKey(name: 'total_amount_fine')
  String totalAmountFine;
  @JsonKey(name: 'total_amount_display')
  String totalAmountDisplay;
  @JsonKey(name: 'total_amount_remaining')
  String totalAmountRemaining;
  String status;

  FeeDetail({
    this.amount,
    this.feeSessionGroupId,
    this.createdAt,
    this.isActive,
    this.studentSessionId,
    this.id,
    this.name,
    this.amountDetail,
    this.code,
    this.dueDate,
    this.feeGroupsFeeTypeId,
    this.feeGroupsId,
    this.feeTypeId,
    this.isSystem,
    this.status,
    this.studentFeesDepositId,
    this.totalAmountDiscount,
    this.totalAmountDisplay,
    this.totalAmountFine,
    this.totalAmountPaid,
    this.totalAmountRemaining,
    this.type,
  });

  factory FeeDetail.fromJson(Map<String, dynamic> json) =>
      _$FeeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FeeDetailToJson(this);
}

@JsonSerializable()
class AmountDetail {
  @JsonKey(name: 'inv_no')
  int id;
  String date;
  @JsonKey(name: 'amount_discount')
  String discount;
  @JsonKey(name: 'amount_fine')
  String fine;
  @JsonKey(name: 'description')
  String collectedBy;
  @JsonKey(name: 'payment_mode')
  String mode;
  String amount;

  AmountDetail({
    this.id,
    this.date,
    this.collectedBy,
    this.discount,
    this.fine,
    this.mode,
    this.amount,
  });

  factory AmountDetail.fromJson(Map<String, dynamic> json) =>
      _$AmountDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AmountDetailToJson(this);
}

@JsonSerializable()
class GrandFee {
  String amount;
  @JsonKey(name: 'amount_discount')
  String amountDiscount;
  @JsonKey(name: 'amount_fine')
  String amountFine;
  @JsonKey(name: 'amount_paid')
  String amountPaid;
  @JsonKey(name: 'amount_remaining')
  String amountRemaining;

  GrandFee({
    this.amount,
    this.amountDiscount,
    this.amountFine,
    this.amountPaid,
    this.amountRemaining,
  });

  factory GrandFee.fromJson(Map<String, dynamic> json) =>
      _$GrandFeeFromJson(json);

  Map<String, dynamic> toJson() => _$GrandFeeToJson(this);
}
