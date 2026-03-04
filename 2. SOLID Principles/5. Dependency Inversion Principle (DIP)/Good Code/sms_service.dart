import 'notification_channel.dart';

class SmsService extends NotificationChannel {
  @override
  void sendMessage(String msg) {
    print('Sending SMS: $msg');
  }
}
