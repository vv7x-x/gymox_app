import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/notification/get_notifications_usecase.dart';
import '../../domain/usecases/notification/mark_read_usecase.dart';
import 'auth_provider.dart';

final notificationDatasourceProvider = Provider<NotificationRemoteDatasource>((ref) {
  return NotificationRemoteDatasource(ref.watch(supabaseClientProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(ref.watch(notificationDatasourceProvider));
});

final getNotificationsUsecaseProvider = Provider<GetNotificationsUsecase>((ref) {
  return GetNotificationsUsecase(ref.watch(notificationRepositoryProvider));
});

final markReadUsecaseProvider = Provider<MarkReadUsecase>((ref) {
  return MarkReadUsecase(ref.watch(notificationRepositoryProvider));
});

final notificationsProvider = FutureProvider<List<AppNotification>>((ref) {
  return ref.watch(getNotificationsUsecaseProvider).call();
});

final unreadCountProvider = FutureProvider<int>((ref) async {
  final notifications = await ref.watch(notificationsProvider.future);
  return notifications.where((n) => !n.isRead).length;
});
