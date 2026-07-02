import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/strings.dart';
import '../../domain/entities/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: const Icon(Icons.fitness_center, color: AppColors.primary),
        title: Text(workout.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        subtitle: workout.notes != null ? Text(workout.notes!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)) : null,
        children: workout.exercises.map((exercise) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(child: Text(exercise.exerciseName, style: const TextStyle(color: AppColors.textPrimary))),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${exercise.sets}x ${AppStrings.of('sets', context)}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${exercise.reps}x ${AppStrings.of('reps', context)}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
