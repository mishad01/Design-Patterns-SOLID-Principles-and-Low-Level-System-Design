import 'notification_channel.dart';

class NotificationService {
  final NotificationChannel notificationChannel;

  NotificationService({required this.notificationChannel});

  void notify(String msg) {
    notificationChannel.sendMessage(msg);
  }
}
