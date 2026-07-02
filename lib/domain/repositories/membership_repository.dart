import '../entities/membership.dart';
import '../entities/membership_plan.dart';

abstract class MembershipRepository {
  Future<Membership?> getCurrentMembership();
  Future<MembershipPlan?> getPlan(String planId);
}
