import '../../domain/entities/payment.dart';

class PaymentModel {
  final String id;
  final String memberId;
  final String? membershipId;
  final double amount;
  final String paymentMethod;
  final String paymentDate;
  final String receiptNumber;
  final String? notes;

  PaymentModel({
    required this.id,
    required this.memberId,
    this.membershipId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
    required this.receiptNumber,
    this.notes,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      membershipId: json['membership_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['payment_method'] as String? ?? '',
      paymentDate: json['payment_date'] as String? ?? '',
      receiptNumber: json['receipt_number'] as String? ?? '',
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': memberId,
      if (membershipId != null) 'membership_id': membershipId,
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_date': paymentDate,
      'receipt_number': receiptNumber,
      if (notes != null) 'notes': notes,
    };
  }

  Payment toEntity() {
    return Payment(
      id: id,
      memberId: memberId,
      membershipId: membershipId,
      amount: amount,
      paymentMethod: paymentMethod,
      paymentDate: paymentDate,
      receiptNumber: receiptNumber,
      notes: notes,
    );
  }
}
