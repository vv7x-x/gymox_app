import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/strings.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/membership_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/membership_card.dart';
import '../../widgets/loading_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final membershipAsync = ref.watch(membershipProvider);
    final unreadAsync = ref.watch(unreadCountProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, ref, profileAsync, unreadAsync),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    membershipAsync.when(
                      data: (membership) {
                        if (membership == null) {
                          return _buildEmptyMembership(context);
                        }
                        return MembershipCard(membership: membership);
                      },
                      loading: () => _buildShimmerCard(),
                      error: (_, __) => _buildEmptyMembership(context),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      AppStrings.of('quickActions', context),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    _buildQuickActions(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, AsyncValue profileAsync, AsyncValue<int> unreadAsync) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark, AppColors.surface],
          stops: const [0.0, 0.4, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: profileAsync.when(
                  data: (profile) => Text(
                    '${AppStrings.of('welcome', context)}\n${profile?.fullName ?? 'Member'}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3),
                  ),
                  loading: () => const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingWidget(height: 14, width: 100),
                      SizedBox(height: 8),
                      LoadingWidget(height: 20, width: 160),
                    ],
                  ),
                  error: (_, __) => Text(
                    '${AppStrings.of('welcome', context)}\nMember',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3),
                  ),
                ),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                        onPressed: () => context.push(RouteNames.notifications),
                      ),
                      unreadAsync.when(
                        data: (count) => count > 0
                            ? Positioned(right: 8, top: 8, child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(color: AppColors.warning, shape: BoxShape.circle),
                                child: Text('$count', style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                              ))
                            : const SizedBox(),
                        loading: () => const SizedBox(),
                        error: (_, __) => const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => context.push(RouteNames.profile),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white24,
                      backgroundImage: profileAsync.asData?.value?.photoUrl != null
                          ? NetworkImage(profileAsync.asData!.value!.photoUrl!)
                          : null,
                      child: profileAsync.asData?.value?.photoUrl == null
                          ? const Icon(Icons.person, color: Colors.white70)
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMembership(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.textHint.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.card_membership, size: 36, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            Text(AppStrings.of('noMembership', context), style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(child: CircularProgressIndicator(strokeWidth: 3)),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _ActionData(icon: Icons.qr_code_scanner, label: AppStrings.of('checkIn', context), route: RouteNames.attendance, color: AppColors.primary),
      _ActionData(icon: Icons.fitness_center, label: AppStrings.of('workout', context), route: RouteNames.workout, color: AppColors.success),
      _ActionData(icon: Icons.receipt_long, label: AppStrings.of('payments', context), route: RouteNames.payment, color: AppColors.warning),
      _ActionData(icon: Icons.card_membership, label: AppStrings.of('membership', context), route: RouteNames.membership, color: AppColors.frozen),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider.withOpacity(0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push(action.route),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: action.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(action.icon, color: action.color, size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(action.label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionData {
  final IconData icon;
  final String label;
  final String route;
  final Color color;
  _ActionData({required this.icon, required this.label, required this.route, required this.color});
}
