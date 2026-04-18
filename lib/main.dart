import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/app.dart';
import 'package:vynix/shared/services/home_widget/home_widget_service.dart';
import 'package:vynix/shared/services/notifications/local_notifications_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    LocalNotificationsService.instance.initialize(),
    HomeWidgetService.instance.initialize(),
  ]);
  runApp(const ProviderScope(child: VynixApp()));
}
