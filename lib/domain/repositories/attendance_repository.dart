import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getAttendanceHistory();
  Future<({String? error})> checkIn();
}
