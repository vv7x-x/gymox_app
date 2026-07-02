import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<List<Payment>> getPayments();
}
