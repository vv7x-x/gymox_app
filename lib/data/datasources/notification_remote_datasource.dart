import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/supabase_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/notification_model.dart';

class NotificationRemoteDatasource {
  final SupabaseClient _client;

  NotificationRemoteDatasource(this._client);

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _client
          .from(SupabaseTables.notifications)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List).map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to load notifications');
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _client
          .from(SupabaseTables.notifications)
          .update({'is_read': true})
          .eq('id', notificationId);
    } catch (e) {
      throw ServerException('Failed to mark notification as read');
    }
  }

  Stream<NotificationModel> getRealtimeNotifications() {
    final userId = _client.auth.currentUser?.id ?? '';
    return _client
        .channel('notifications')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: SupabaseTables.notifications,
          filter: PostgresChangeFilter(type: PostgresChangeFilterType.eq, column: 'user_id', value: userId),
          callback: (payload) {},
        )
        .subscribe()
        .stream
        .where((event) => event.event == RealtimeListenEvent.postgresChanges)
        .map((event) {
          final data = (event.payload as Map<String, dynamic>)['new'] as Map<String, dynamic>;
          return NotificationModel.fromJson(data);
        });
  }
}
