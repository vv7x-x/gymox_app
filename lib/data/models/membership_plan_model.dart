import '../../domain/entities/membership_plan.dart';

class MembershipPlanModel {
  final String id;
  final String name;
  final int durationDays;
  final double price;
  final String? description;
  final bool freezeAllowed;
  final int freezeLimitDays;
  final int? visitLimit;

  MembershipPlanModel({
    required this.id,
    required this.name,
    required this.durationDays,
    required this.price,
    this.description,
    required this.freezeAllowed,
    required this.freezeLimitDays,
    this.visitLimit,
  });

  factory MembershipPlanModel.fromJson(Map<String, dynamic> json) {
    return MembershipPlanModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      durationDays: json['duration_days'] as int? ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
      freezeAllowed: json['freeze_allowed'] as bool? ?? true,
      freezeLimitDays: json['freeze_limit_days'] as int? ?? 30,
      visitLimit: json['visit_limit'] as int?,
    );
  }

  MembershipPlan toEntity() {
    return MembershipPlan(
      id: id,
      name: name,
      durationDays: durationDays,
      price: price,
      description: description,
      freezeAllowed: freezeAllowed,
      freezeLimitDays: freezeLimitDays,
      visitLimit: visitLimit,
    );
  }
}
