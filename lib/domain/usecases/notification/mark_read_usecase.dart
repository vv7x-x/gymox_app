import '../../repositories/notification_repository.dart';

class MarkReadUsecase {
  final NotificationRepository _repository;
  MarkReadUsecase(this._repository);
  Future<void> call(String notificationId) => _repository.markAsRead(notificationId);
}
