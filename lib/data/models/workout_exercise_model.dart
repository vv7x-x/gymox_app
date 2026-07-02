import '../../domain/entities/workout_exercise.dart';

class WorkoutExerciseModel {
  final String id;
  final String workoutId;
  final String exerciseName;
  final int sets;
  final int reps;
  final String? notes;

  WorkoutExerciseModel({
    required this.id,
    required this.workoutId,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    this.notes,
  });

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseModel(
      id: json['id'] as String,
      workoutId: json['workout_id'] as String? ?? '',
      exerciseName: json['exercise_name'] as String? ?? '',
      sets: json['sets'] as int? ?? 0,
      reps: json['reps'] as int? ?? 0,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workout_id': workoutId,
      'exercise_name': exerciseName,
      'sets': sets,
      'reps': reps,
      if (notes != null) 'notes': notes,
    };
  }

  WorkoutExercise toEntity() {
    return WorkoutExercise(
      id: id,
      workoutId: workoutId,
      exerciseName: exerciseName,
      sets: sets,
      reps: reps,
      notes: notes,
    );
  }
}
