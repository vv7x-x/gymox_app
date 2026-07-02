import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/reset_password_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/membership/membership_screen.dart';
import '../../presentation/screens/attendance/attendance_screen.dart';
import '../../presentation/screens/workout/workout_screen.dart';
import '../../presentation/screens/payment/payment_screen.dart';
import '../../presentation/screens/notification/notification_screen.dart';
import '../../presentation/screens/shell/app_shell.dart';
import 'route_names.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(path: RouteNames.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: RouteNames.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: RouteNames.register, builder: (_, __) => const RegisterScreen()),
      GoRoute(path: RouteNames.resetPassword, builder: (_, __) => const ResetPasswordScreen()),
      ShellRoute(
        builder: (_, __, child) => AppShell(child: child),
        routes: [
          GoRoute(path: RouteNames.home, builder: (_, __) => const HomeScreen()),
          GoRoute(path: RouteNames.profile, builder: (_, __) => const ProfileScreen()),
          GoRoute(path: RouteNames.membership, builder: (_, __) => const MembershipScreen()),
          GoRoute(path: RouteNames.attendance, builder: (_, __) => const AttendanceScreen()),
          GoRoute(path: RouteNames.workout, builder: (_, __) => const WorkoutScreen()),
          GoRoute(path: RouteNames.payment, builder: (_, __) => const PaymentScreen()),
          GoRoute(path: RouteNames.notifications, builder: (_, __) => const NotificationScreen()),
        ],
      ),
      GoRoute(path: RouteNames.editProfile, builder: (_, __) => const EditProfileScreen()),
    ],
  );
}
