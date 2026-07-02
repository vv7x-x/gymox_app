import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/supabase_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/membership_model.dart';
import '../models/membership_plan_model.dart';

class MembershipRemoteDatasource {
  final SupabaseClient _client;

  MembershipRemoteDatasource(this._client);

  Future<MembershipModel?> getCurrentMembership() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return null;

      final profile = await _client
          .from(SupabaseTables.profiles)
          .select('member_id')
          .eq('id', userId)
          .maybeSingle();

      final memberId = profile?['member_id'] as String?;
      if (memberId == null) return null;

      final response = await _client
          .from(SupabaseTables.memberships)
          .select('*, plan:membership_plans(name)')
          .eq('member_id', memberId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;

      final membership = MembershipModel.fromJson(response);
      if (response['plan'] != null) {
        final planName = (response['plan'] as Map)['name'] as String?;
        return MembershipModel(
          id: membership.id,
          memberId: membership.memberId,
          planId: membership.planId,
          startDate: membership.startDate,
          endDate: membership.endDate,
          remainingDays: membership.remainingDays,
          status: membership.status,
          freezeStart: membership.freezeStart,
          freezeEnd: membership.freezeEnd,
          pricePaid: membership.pricePaid,
          planName: planName,
        );
      }
      return membership;
    } catch (e) {
      throw ServerException('Failed to load membership');
    }
  }

  Future<MembershipPlanModel?> getPlan(String planId) async {
    try {
      final response = await _client
          .from(SupabaseTables.membershipPlans)
          .select()
          .eq('id', planId)
          .maybeSingle();

      if (response == null) return null;
      return MembershipPlanModel.fromJson(response);
    } catch (e) {
      throw ServerException('Failed to load plan');
    }
  }
}
