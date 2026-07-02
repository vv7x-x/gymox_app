import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/supabase_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/attendance_model.dart';

class AttendanceRemoteDatasource {
  final SupabaseClient _client;

  AttendanceRemoteDatasource(this._client);

  Future<List<AttendanceModel>> getAttendanceHistory() async {
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
          .from(SupabaseTables.attendance)
          .select()
          .eq('member_id', memberId)
          .order('date', ascending: false);

      return (response as List).map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to load attendance');
    }
  }

  Future<({String? error})> checkIn() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return (error: 'Not authenticated');

      final profile = await _client
          .from(SupabaseTables.profiles)
          .select('member_id')
          .eq('id', userId)
          .maybeSingle();

      final memberId = profile?['member_id'] as String?;
      if (memberId == null) return (error: 'Member profile not found');

      final now = DateTime.now();
      final today = now.toIso8601String().substring(0, 10);

      final existingToday = await _client
          .from(SupabaseTables.attendance)
          .select()
          .eq('member_id', memberId)
          .eq('date', today)
          .maybeSingle();

      if (existingToday != null) return (error: 'Already checked in today');

      await _client.from(SupabaseTables.attendance).insert({
        'member_id': memberId,
        'check_in_time': now.toIso8601String(),
        'date': today,
      });

      return (error: null);
    } catch (e) {
      return (error: 'Failed to check in');
    }
  }
}
