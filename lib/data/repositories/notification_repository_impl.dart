import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource _datasource;

  NotificationRepositoryImpl(this._datasource);

  @override
  Future<List<AppNotification>> getNotifications() async {
    final models = await _datasource.getNotifications();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> markAsRead(String notificationId) => _datasource.markAsRead(notificationId);

  @override
  Stream<AppNotification> getRealtimeNotifications() {
    return _datasource.getRealtimeNotifications().map((m) => m.toEntity());
  }
}
