import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../utils/app_theme.dart';
import 'result_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // User left the app - Fail the session
      final provider = context.read<TimerProvider>();
      if (provider.status == SessionStatus.running) {
        provider.forfeitSession();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimerProvider>();

    // Listen for completion and navigate to result
    if (provider.status == SessionStatus.won ||
        provider.status == SessionStatus.lost) {
      Future.microtask(() {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ResultScreen()),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'FOCUS SESSION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white60,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.error.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppTheme.error,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'DON\'T LEAVE',
                          style: TextStyle(
                            color: AppTheme.error,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(),
              const Spacer(),
              CircularPercentIndicator(
                radius: 140.0,
                lineWidth: 12.0,
                percent: provider.progress,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.timerString,
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    const Text(
                      'REMAINING',
                      style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: AppTheme.surface,
                linearGradient: AppTheme.primaryGradient,
                animation: true,
                animateFromLastPercent: true,
                arcType: ArcType.FULL,
                arcBackgroundColor: Colors.transparent,
              ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
              const Spacer(),
              Text(
                    _getMotivationalText(provider.progress),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                  .animate(key: ValueKey(provider.progress > 0.5))
                  .fadeIn()
                  .slideY(begin: 0.1),
              const Spacer(),
              TextButton(
                onPressed: () => _showGiveUpDialog(context),
                child: const Text(
                  'I GIVE UP',
                  style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  String _getMotivationalText(double progress) {
    if (progress > 0.8) return "You've got this. Stay focused.";
    if (progress > 0.5) return "HALFWAY THERE! Don't look away.";
    if (progress > 0.2) return "The finish line is close!";
    return "Finish strong. Every second counts.";
  }

  void _showGiveUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('FORFEIT DUEL?'),
        content: const Text(
          'You will lose your streak and the session will be marked as a loss.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('STAY IN'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<TimerProvider>().forfeitSession();
            },
            child: const Text(
              'GIVE UP',
              style: TextStyle(color: AppTheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
