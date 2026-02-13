import 'package:shared_preferences/shared_preferences.dart';
import '../models/focus_session.dart';

class StorageService {
  static const String _historyKey = 'focus_history';
  static const String _streakKey = 'focus_streak';

  Future<void> saveSession(FocusSession session) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];
    history.add(session.toJson());
    await prefs.setStringList(_historyKey, history);

    if (session.isWin) {
      final int streak = await getStreak();
      await prefs.setInt(_streakKey, streak + 1);
    } else {
      await prefs.setInt(_streakKey, 0);
    }
  }

  Future<List<FocusSession>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];
    return history
        .map((s) => FocusSession.fromJson(s))
        .toList()
        .reversed
        .toList();
  }

  Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    await prefs.remove(_streakKey);
  }
}
