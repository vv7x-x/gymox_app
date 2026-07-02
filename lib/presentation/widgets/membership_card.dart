import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/strings.dart';
import '../../domain/entities/membership.dart';

class MembershipCard extends StatelessWidget {
  final Membership membership;

  const MembershipCard({super.key, required this.membership});

  Color _statusColor() {
    switch (membership.status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'expired':
        return AppColors.error;
      case 'frozen':
        return AppColors.frozen;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final status = membership.status.toLowerCase();
    final daysLeft = membership.remainingDays ?? 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.card,
            AppColors.surfaceLight,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _statusColor().withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _statusColor().withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.card_membership, color: _statusColor(), size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.of('plan', context), style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        const SizedBox(height: 2),
                        Text(
                          membership.planName ?? '-',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: _statusColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _statusColor().withOpacity(0.3)),
                  ),
                  child: Text(
                    AppStrings.of(status, context),
                    style: TextStyle(color: _statusColor(), fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(height: 1, color: AppColors.divider.withOpacity(0.5)),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoTile(AppStrings.of('startDate', context), membership.startDate),
                Container(height: 30, width: 1, color: AppColors.divider.withOpacity(0.3)),
                _infoTile(AppStrings.of('endDate', context), membership.endDate),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _infoTile(AppStrings.of('remainingDays', context), '$daysLeft ${locale == 'ar' ? 'يوم' : 'days'}'),
                Container(height: 30, width: 1, color: AppColors.divider.withOpacity(0.3)),
                if (membership.pricePaid != null)
                  _infoTile(AppStrings.of('amount', context), '${membership.pricePaid!.toStringAsFixed(2)} ${AppStrings.of('sar', context)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
