import '../../entities/workout.dart';
import '../../repositories/workout_repository.dart';

class GetWorkoutsUsecase {
  final WorkoutRepository _repository;
  GetWorkoutsUsecase(this._repository);
  Future<List<Workout>> call() => _repository.getWorkouts();
}
