import 'dart:async';
import 'package:flutter/material.dart';
import '../models/focus_session.dart';
import '../services/storage_service.dart';
import 'package:uuid/uuid.dart';

enum SessionStatus { idle, running, won, lost }

class TimerProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  Timer? _timer;
  int _secondsRemaining = 0;
  int _totalSeconds = 0;
  int _currentStreak = 0;
  SessionStatus _status = SessionStatus.idle;
  List<FocusSession> _history = [];

  int get secondsRemaining => _secondsRemaining;
  int get totalSeconds => _totalSeconds;
  int get currentStreak => _currentStreak;
  SessionStatus get status => _status;
  List<FocusSession> get history => _history;

  double get progress =>
      _totalSeconds > 0 ? _secondsRemaining / _totalSeconds : 0.0;

  String get timerString {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  TimerProvider() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    _currentStreak = await _storageService.getStreak();
    _history = await _storageService.getHistory();
    notifyListeners();
  }

  void startSession(int minutes) {
    _status = SessionStatus.running;
    _totalSeconds = minutes * 60;
    _secondsRemaining = _totalSeconds;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _onSessionComplete(true);
      }
    });
  }

  void forfeitSession() {
    if (_status == SessionStatus.running) {
      _onSessionComplete(false);
    }
  }

  Future<void> _onSessionComplete(bool isWin) async {
    _timer?.cancel();
    _status = isWin ? SessionStatus.won : SessionStatus.lost;

    final session = FocusSession(
      id: const Uuid().v4(),
      durationMinutes: _totalSeconds ~/ 60,
      dateTime: DateTime.now(),
      isWin: isWin,
    );

    await _storageService.saveSession(session);
    _currentStreak = await _storageService.getStreak();
    _history = await _storageService.getHistory();
    notifyListeners();
  }

  void reset() {
    _status = SessionStatus.idle;
    _secondsRemaining = 0;
    _totalSeconds = 0;
    notifyListeners();
  }
}
