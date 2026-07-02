import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;

  const NotificationCard({super.key, required this.notification, this.onTap});

  IconData _typeIcon() {
    switch (notification.type) {
      case 'membership_expiry':
        return Icons.card_membership;
      case 'offer':
        return Icons.local_offer;
      case 'workout':
        return Icons.fitness_center;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (notification.isRead ? AppColors.surfaceLight : AppColors.primary).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_typeIcon(), color: notification.isRead ? AppColors.textSecondary : AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.title, style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                    )),
                    const SizedBox(height: 4),
                    Text(notification.message, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(notification.createdAt, style: const TextStyle(color: AppColors.textHint, fontSize: 11)),
                  ],
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
