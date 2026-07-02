import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/payment_remote_datasource.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/usecases/payment/get_payments_usecase.dart';
import 'auth_provider.dart';

final paymentDatasourceProvider = Provider<PaymentRemoteDatasource>((ref) {
  return PaymentRemoteDatasource(ref.watch(supabaseClientProvider));
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepositoryImpl(ref.watch(paymentDatasourceProvider));
});

final getPaymentsUsecaseProvider = Provider<GetPaymentsUsecase>((ref) {
  return GetPaymentsUsecase(ref.watch(paymentRepositoryProvider));
});

final paymentsProvider = FutureProvider<List<Payment>>((ref) {
  return ref.watch(getPaymentsUsecaseProvider).call();
});
