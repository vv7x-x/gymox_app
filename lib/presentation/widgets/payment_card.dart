import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/strings.dart';
import '../../domain/entities/payment.dart';

class PaymentCard extends StatelessWidget {
  final Payment payment;

  const PaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.payment, color: AppColors.success),
        ),
        title: Text('${payment.amount} SAR', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(payment.paymentDate, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            Text('${AppStrings.of('method', context)}: ${payment.paymentMethod}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        trailing: Text(payment.receiptNumber, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
      ),
    );
  }
}
