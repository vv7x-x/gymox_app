import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/strings.dart';
import '../../providers/membership_provider.dart';
import '../../widgets/membership_card.dart';
import '../../widgets/loading_widget.dart';

class MembershipScreen extends ConsumerWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipAsync = ref.watch(membershipProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.of('membership', context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(membershipProvider.future),
        color: AppColors.primary,
        child: membershipAsync.when(
          data: (membership) {
            if (membership == null) {
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
                              color: AppColors.textHint.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(Icons.card_membership, size: 56, color: AppColors.textHint),
                          ),
                          const SizedBox(height: 20),
                          Text(AppStrings.of('noMembership', context), style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                MembershipCard(membership: membership),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(AppStrings.of('status', context), style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        decoration: BoxDecoration(
                          color: (membership.status == 'active'
                                  ? AppColors.success
                                  : membership.status == 'frozen'
                                      ? AppColors.frozen
                                      : AppColors.error)
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: (membership.status == 'active'
                                    ? AppColors.success
                                    : membership.status == 'frozen'
                                        ? AppColors.frozen
                                        : AppColors.error)
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          AppStrings.of(membership.status.toLowerCase(), context),
                          style: TextStyle(
                            color: membership.status == 'active'
                                ? AppColors.success
                                : membership.status == 'frozen'
                                    ? AppColors.frozen
                                    : AppColors.error,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (membership.remainingDays != null) ...[
                        const SizedBox(height: 20),
                        Text(
                          '${membership.remainingDays} ${AppStrings.of('remainingDays', context)}',
                          style: const TextStyle(color: AppColors.textPrimary, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ],
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
}
