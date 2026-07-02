import '../../entities/attendance.dart';
import '../../repositories/attendance_repository.dart';

class GetAttendanceUsecase {
  final AttendanceRepository _repository;
  GetAttendanceUsecase(this._repository);
  Future<List<Attendance>> call() => _repository.getAttendanceHistory();
}
