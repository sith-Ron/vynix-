import 'package:home_widget/home_widget.dart';

/// Bridges Flutter state to native home-screen / lock-screen widgets.
///
/// Data keys must match those read by VynixDashboardWidget.swift (iOS)
/// and VynixWidgetProvider.kt (Android).
class HomeWidgetService {
  HomeWidgetService._();

  static final HomeWidgetService instance = HomeWidgetService._();

  static const String _appGroupId = 'group.com.example.vynix';
  static const String _iOSWidgetName = 'VynixDashboardWidget';
  static const String _androidWidgetProvider = 'VynixWidgetProvider';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    HomeWidget.setAppGroupId(_appGroupId);
    _initialized = true;
  }

  /// Push current dashboard stats to the native widget and trigger a refresh.
  Future<void> updateDashboard({
    required int pendingTasks,
    required int todayEvents,
    required int focusMinutes,
    String? nextTaskTitle,
  }) async {
    await initialize();

    await Future.wait([
      HomeWidget.saveWidgetData<int>('pending_tasks', pendingTasks),
      HomeWidget.saveWidgetData<int>('today_events', todayEvents),
      HomeWidget.saveWidgetData<int>('focus_minutes', focusMinutes),
      HomeWidget.saveWidgetData<String>('next_task_title', nextTaskTitle ?? ''),
    ]);

    // Trigger native widget refresh on both platforms.
    await HomeWidget.updateWidget(
      iOSName: _iOSWidgetName,
      androidName: _androidWidgetProvider,
    );
  }
}
