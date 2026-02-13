import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../utils/app_theme.dart';
import 'focus_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DurationScreen extends StatefulWidget {
  const DurationScreen({super.key});

  @override
  State<DurationScreen> createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  int _selectedDuration = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('SELECT DURATION'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'How long will you duel for?',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 60),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _DurationCard(
                    15,
                    0,
                    _selectedDuration == 15,
                    () => setState(() => _selectedDuration = 15),
                  ),
                  _DurationCard(
                    25,
                    1,
                    _selectedDuration == 25,
                    () => setState(() => _selectedDuration = 25),
                  ),
                  _DurationCard(
                    45,
                    2,
                    _selectedDuration == 45,
                    () => setState(() => _selectedDuration = 45),
                  ),
                  _DurationCard(
                    60,
                    3,
                    _selectedDuration == 60,
                    () => setState(() => _selectedDuration = 60),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppTheme.primaryGradient,
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.read<TimerProvider>().startSession(_selectedDuration);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const FocusScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'ENTER DUEL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ).animate().slideY(begin: 0.5, curve: Curves.easeOut),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DurationCard extends StatelessWidget {
  final int minutes;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _DurationCard(this.minutes, this.index, this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppTheme.accent : Colors.white10,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$minutes',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.white60,
              ),
            ),
            const Text(
              'MINUTES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white38,
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(delay: Duration(milliseconds: index * 100));
  }
}
