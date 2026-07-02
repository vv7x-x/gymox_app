import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/attendance_remote_datasource.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../domain/usecases/attendance/get_attendance_usecase.dart';
import '../../domain/usecases/attendance/check_in_usecase.dart';
import 'auth_provider.dart';

final attendanceDatasourceProvider = Provider<AttendanceRemoteDatasource>((ref) {
  return AttendanceRemoteDatasource(ref.watch(supabaseClientProvider));
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepositoryImpl(ref.watch(attendanceDatasourceProvider));
});

final getAttendanceUsecaseProvider = Provider<GetAttendanceUsecase>((ref) {
  return GetAttendanceUsecase(ref.watch(attendanceRepositoryProvider));
});

final checkInUsecaseProvider = Provider<CheckInUsecase>((ref) {
  return CheckInUsecase(ref.watch(attendanceRepositoryProvider));
});

final attendanceHistoryProvider = FutureProvider<List<Attendance>>((ref) {
  return ref.watch(getAttendanceUsecaseProvider).call();
});

final checkInStateProvider = StateProvider<bool>((ref) => false);
