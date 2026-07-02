import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/workout_remote_datasource.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/usecases/workout/get_workouts_usecase.dart';
import 'auth_provider.dart';

final workoutDatasourceProvider = Provider<WorkoutRemoteDatasource>((ref) {
  return WorkoutRemoteDatasource(ref.watch(supabaseClientProvider));
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl(ref.watch(workoutDatasourceProvider));
});

final getWorkoutsUsecaseProvider = Provider<GetWorkoutsUsecase>((ref) {
  return GetWorkoutsUsecase(ref.watch(workoutRepositoryProvider));
});

final workoutsProvider = FutureProvider<List<Workout>>((ref) {
  return ref.watch(getWorkoutsUsecaseProvider).call();
});
