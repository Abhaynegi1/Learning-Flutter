import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../utils/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimerProvider>();
    final isWin = provider.status == SessionStatus.won;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isWin
                ? [AppTheme.success.withOpacity(0.2), AppTheme.background]
                : [AppTheme.error.withOpacity(0.2), AppTheme.background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                      isWin ? Icons.emoji_events : Icons.heart_broken,
                      size: 100,
                      color: isWin ? AppTheme.success : AppTheme.error,
                    )
                    .animate()
                    .scale(duration: 800.ms, curve: Curves.elasticOut)
                    .shimmer(delay: 800.ms),
                const SizedBox(height: 24),
                Text(
                  isWin ? 'DUEL WON' : 'DUEL LOST',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: isWin ? AppTheme.success : AppTheme.error,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                const SizedBox(height: 16),
                Text(
                  isWin
                      ? 'Incredible focus! You stayed in the zone.'
                      : 'You left the arena too soon. Focus is a muscle—keep training!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 60),
                _ResultCard(
                  label: 'STREAK',
                  value: '${provider.currentStreak}',
                  icon: Icons.fireplace,
                  color: Colors.orange,
                ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2),
                const SizedBox(height: 16),
                _ResultCard(
                  label: 'DURATION',
                  value: '${provider.totalSeconds ~/ 60} MIN',
                  icon: Icons.timer,
                  color: AppTheme.accent,
                ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.2),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.reset();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isWin
                          ? AppTheme.success
                          : AppTheme.primary,
                    ),
                    child: const Text(
                      'BACK TO HOME',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ResultCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white54,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
