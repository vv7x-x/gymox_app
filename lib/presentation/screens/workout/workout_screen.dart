import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/strings.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/workout_card.dart';
import '../../widgets/loading_widget.dart';

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(workoutsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.of('workout', context))),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(workoutsProvider.future),
        color: AppColors.primary,
        child: workoutsAsync.when(
          data: (workouts) {
            if (workouts.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(Icons.fitness_center, size: 56, color: AppColors.textHint),
                          ),
                          const SizedBox(height: 20),
                          Text(AppStrings.of('noData', context), style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: workouts.length,
              itemBuilder: (context, index) => WorkoutCard(workout: workouts[index]),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error', style: const TextStyle(color: AppColors.error))),
        ),
      ),
    );
  }
}
