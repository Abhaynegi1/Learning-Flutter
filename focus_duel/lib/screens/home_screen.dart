import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../utils/app_theme.dart';
import 'duration_screen.dart';
import 'history_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.background,
              AppTheme.background.withOpacity(0.8),
              AppTheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  'LOCK IN',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2),
                const SizedBox(height: 8),
                Text(
                  'Master Your Mind',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(delay: 400.ms),
                const Spacer(),
                _StreakCounter(),
                const Spacer(),
                _HomeButton(
                  title: 'START FOCUS',
                  gradient: AppTheme.primaryGradient,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DurationScreen()),
                  ),
                ).animate().fadeIn(delay: 800.ms).slideX(begin: -0.2),
                const SizedBox(height: 20),
                _HomeButton(
                  title: 'VIEW HISTORY',
                  color: AppTheme.surface,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  ),
                ).animate().fadeIn(delay: 1000.ms).slideX(begin: 0.2),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StreakCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streak = context.watch<TimerProvider>().currentStreak;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.fireplace, color: Colors.white, size: 40),
              Text(
                '$streak',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ).animate().scale(delay: 600.ms, curve: Curves.elasticOut),
        const SizedBox(height: 16),
        const Text(
          'CURRENT STREAK',
          style: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String title;
  final LinearGradient? gradient;
  final Color? color;
  final VoidCallback onTap;

  const _HomeButton({
    required this.title,
    this.gradient,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient,
          color: color,
          boxShadow: [
            if (gradient != null)
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
