import '../../entities/payment.dart';
import '../../repositories/payment_repository.dart';

class GetPaymentsUsecase {
  final PaymentRepository _repository;
  GetPaymentsUsecase(this._repository);
  Future<List<Payment>> call() => _repository.getPayments();
}
