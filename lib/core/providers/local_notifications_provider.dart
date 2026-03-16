import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/shared/services/notifications/local_notifications_service.dart';

part 'local_notifications_provider.g.dart';

@riverpod
LocalNotificationsService localNotificationsService(Ref ref) {
  return LocalNotificationsService.instance;
}
