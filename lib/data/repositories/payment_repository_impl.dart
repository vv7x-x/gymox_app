import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _datasource;

  PaymentRepositoryImpl(this._datasource);

  @override
  Future<List<Payment>> getPayments() async {
    final models = await _datasource.getPayments();
    return models.map((m) => m.toEntity()).toList();
  }
}
