class Membership {
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

  Membership({
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
}
