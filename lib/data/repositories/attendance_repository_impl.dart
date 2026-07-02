import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDatasource _datasource;

  AttendanceRepositoryImpl(this._datasource);

  @override
  Future<List<Attendance>> getAttendanceHistory() async {
    final models = await _datasource.getAttendanceHistory();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<({String? error})> checkIn() => _datasource.checkIn();
}
