class MembershipPlan {
  final String id;
  final String name;
  final int durationDays;
  final double price;
  final String? description;
  final bool freezeAllowed;
  final int freezeLimitDays;
  final int? visitLimit;

  MembershipPlan({
    required this.id,
    required this.name,
    required this.durationDays,
    required this.price,
    this.description,
    required this.freezeAllowed,
    required this.freezeLimitDays,
    this.visitLimit,
  });
}
