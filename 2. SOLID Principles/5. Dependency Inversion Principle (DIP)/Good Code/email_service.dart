import 'notification_channel.dart';

class EmailService extends NotificationChannel {
  @override
  void sendMessage(String msg) {
    print('Sending email: $msg');
  }
}
