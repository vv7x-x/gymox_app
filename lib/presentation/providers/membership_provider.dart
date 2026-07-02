import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/membership_remote_datasource.dart';
import '../../data/repositories/membership_repository_impl.dart';
import '../../domain/entities/membership.dart';
import '../../domain/entities/membership_plan.dart';
import '../../domain/repositories/membership_repository.dart';
import '../../domain/usecases/membership/get_membership_usecase.dart';
import 'auth_provider.dart';

final membershipDatasourceProvider = Provider<MembershipRemoteDatasource>((ref) {
  return MembershipRemoteDatasource(ref.watch(supabaseClientProvider));
});

final membershipRepositoryProvider = Provider<MembershipRepository>((ref) {
  return MembershipRepositoryImpl(ref.watch(membershipDatasourceProvider));
});

final getMembershipUsecaseProvider = Provider<GetMembershipUsecase>((ref) {
  return GetMembershipUsecase(ref.watch(membershipRepositoryProvider));
});

final membershipProvider = FutureProvider<Membership?>((ref) {
  return ref.watch(getMembershipUsecaseProvider).call();
});

final membershipPlanProvider = FutureProvider.family<MembershipPlan?, String>((ref, planId) {
  return ref.watch(membershipRepositoryProvider).getPlan(planId);
});
