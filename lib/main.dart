import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/app.dart';
import 'package:vynix/shared/services/notifications/local_notifications_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationsService.instance.initialize();
  runApp(const ProviderScope(child: VynixApp()));
}
