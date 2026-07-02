import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/workout_remote_datasource.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDatasource _datasource;

  WorkoutRepositoryImpl(this._datasource);

  @override
  Future<List<Workout>> getWorkouts() async {
    final models = await _datasource.getWorkouts();
    return models.map((m) => m.toEntity()).toList();
  }
}
