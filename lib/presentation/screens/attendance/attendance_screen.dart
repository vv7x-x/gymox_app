import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/strings.dart';
import '../../providers/attendance_provider.dart';
import '../../widgets/attendance_card.dart';
import '../../widgets/loading_widget.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(attendanceHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.of('attendance', context))),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(attendanceHistoryProvider.future),
        color: AppColors.primary,
        child: historyAsync.when(
          data: (history) {
            final totalVisits = history.length;
            final lastCheckIn = history.isNotEmpty ? history.first.checkInTime.substring(0, 10) : '-';

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary.withOpacity(0.2), AppColors.card],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statItem(AppStrings.of('totalVisits', context), '$totalVisits', Icons.calendar_today),
                        Container(height: 40, width: 1, color: AppColors.divider),
                        _statItem(AppStrings.of('lastCheckIn', context), lastCheckIn, Icons.history),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final result = await ref.read(checkInUsecaseProvider).call();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(result.error ?? AppStrings.of('checkInSuccess', context)),
                              backgroundColor: result.error != null ? AppColors.error : AppColors.success,
                              behavior: SnackBarBehavior.floating,
                            ));
                            if (result.error == null) {
                              ref.invalidate(attendanceHistoryProvider);
                            }
                          }
                        },
                        icon: const Icon(Icons.qr_code_scanner, size: 22),
                        label: Text(AppStrings.of('checkIn', context), style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                if (history.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.history, size: 56, color: AppColors.textHint),
                          const SizedBox(height: 16),
                          Text(AppStrings.of('noData', context), style: const TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => AttendanceCard(attendance: history[index]),
                      childCount: history.length,
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error', style: const TextStyle(color: AppColors.error))),
        ),
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
