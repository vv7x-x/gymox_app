import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/supabase_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/payment_model.dart';

class PaymentRemoteDatasource {
  final SupabaseClient _client;

  PaymentRemoteDatasource(this._client);

  Future<List<PaymentModel>> getPayments() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return [];

      final profile = await _client
          .from(SupabaseTables.profiles)
          .select('member_id')
          .eq('id', userId)
          .maybeSingle();

      final memberId = profile?['member_id'] as String?;
      if (memberId == null) return [];

      final response = await _client
          .from(SupabaseTables.payments)
          .select()
          .eq('member_id', memberId)
          .order('payment_date', ascending: false);

      return (response as List).map((e) => PaymentModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to load payments');
    }
  }
}
