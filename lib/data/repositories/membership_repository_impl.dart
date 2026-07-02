import '../../domain/entities/membership.dart';
import '../../domain/entities/membership_plan.dart';
import '../../domain/repositories/membership_repository.dart';
import '../datasources/membership_remote_datasource.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipRemoteDatasource _datasource;

  MembershipRepositoryImpl(this._datasource);

  @override
  Future<Membership?> getCurrentMembership() async {
    final model = await _datasource.getCurrentMembership();
    return model?.toEntity();
  }

  @override
  Future<MembershipPlan?> getPlan(String planId) async {
    final model = await _datasource.getPlan(planId);
    return model?.toEntity();
  }
}
