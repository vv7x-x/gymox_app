import '../../domain/entities/workout.dart';
import 'workout_exercise_model.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String? notes;
  final List<WorkoutExerciseModel> exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    this.notes,
    required this.exercises,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      notes: json['notes'] as String?,
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => WorkoutExerciseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (notes != null) 'notes': notes,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }

  Workout toEntity() {
    return Workout(
      id: id,
      name: name,
      notes: notes,
      exercises: exercises.map((e) => e.toEntity()).toList(),
    );
  }
}
