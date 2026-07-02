import '../../entities/membership.dart';
import '../../repositories/membership_repository.dart';

class GetMembershipUsecase {
  final MembershipRepository _repository;
  GetMembershipUsecase(this._repository);
  Future<Membership?> call() => _repository.getCurrentMembership();
}
