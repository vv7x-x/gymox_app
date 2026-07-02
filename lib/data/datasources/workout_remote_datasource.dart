import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/supabase_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/workout_model.dart';

class WorkoutRemoteDatasource {
  final SupabaseClient _client;

  WorkoutRemoteDatasource(this._client);

  Future<List<WorkoutModel>> getWorkouts() async {
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
          .from(SupabaseTables.workouts)
          .select('*, exercises:workout_exercises(*)')
          .eq('member_id', memberId)
          .order('created_at', ascending: false);

      return (response as List).map((e) => WorkoutModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to load workouts');
    }
  }
}
