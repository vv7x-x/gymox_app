class WorkoutExercise {
  final String id;
  final String workoutId;
  final String exerciseName;
  final int sets;
  final int reps;
  final String? notes;

  WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    this.notes,
  });
}
