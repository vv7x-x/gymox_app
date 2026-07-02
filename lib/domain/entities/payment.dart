class Payment {
  final String id;
  final String memberId;
  final String? membershipId;
  final double amount;
  final String paymentMethod;
  final String paymentDate;
  final String receiptNumber;
  final String? notes;

  Payment({
    required this.id,
    required this.memberId,
    this.membershipId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
    required this.receiptNumber,
    this.notes,
  });
}
