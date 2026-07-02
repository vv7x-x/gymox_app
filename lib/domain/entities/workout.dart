class Workout {
  final String id;
  final String name;
  final String? notes;
  final List<WorkoutExercise> exercises;

  Workout({
    required this.id,
    required this.name,
    this.notes,
    required this.exercises,
  });
}
