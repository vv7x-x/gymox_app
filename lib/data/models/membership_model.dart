import '../../domain/entities/membership.dart';

class MembershipModel {
  final String id;
  final String memberId;
  final String planId;
  final String startDate;
  final String endDate;
  final int? remainingDays;
  final String status;
  final String? freezeStart;
  final String? freezeEnd;
  final double? pricePaid;
  final String? planName;

  MembershipModel({
    required this.id,
    required this.memberId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    this.remainingDays,
    required this.status,
    this.freezeStart,
    this.freezeEnd,
    this.pricePaid,
    this.planName,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      planId: json['plan_id'] as String,
      startDate: json['start_date'] as String? ?? '',
      endDate: json['end_date'] as String? ?? '',
      remainingDays: json['remaining_days'] as int?,
      status: json['status'] as String? ?? 'active',
      freezeStart: json['freeze_start'] as String?,
      freezeEnd: json['freeze_end'] as String?,
      pricePaid: (json['price_paid'] as num?)?.toDouble(),
      planName: json['plan_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': memberId,
      'plan_id': planId,
      'start_date': startDate,
      'end_date': endDate,
      if (remainingDays != null) 'remaining_days': remainingDays,
      'status': status,
      if (freezeStart != null) 'freeze_start': freezeStart,
      if (freezeEnd != null) 'freeze_end': freezeEnd,
      if (pricePaid != null) 'price_paid': pricePaid,
    };
  }

  Membership toEntity() {
    return Membership(
      id: id,
      memberId: memberId,
      planId: planId,
      startDate: startDate,
      endDate: endDate,
      remainingDays: remainingDays,
      status: status,
      freezeStart: freezeStart,
      freezeEnd: freezeEnd,
      pricePaid: pricePaid,
      planName: planName,
    );
  }
}
