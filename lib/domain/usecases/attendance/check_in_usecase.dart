import '../../repositories/attendance_repository.dart';

class CheckInUsecase {
  final AttendanceRepository _repository;
  CheckInUsecase(this._repository);
  Future<({String? error})> call() => _repository.checkIn();
}
