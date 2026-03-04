import 'email_service.dart';
import 'sms_service.dart';

class NotificationService {
  final EmailService emailService;
  final SmsService smsService;

  NotificationService({required this.emailService, required this.smsService});

  void notifyByEmail(String msg) {
    emailService.sendEmail(msg);
  }

  void notifyBySms(String msg) {
    smsService.sendSms(msg);
  }
}
/*
Why this violates the Dependency Inversion Principle (DIP):

1. HIGH-LEVEL MODULE DEPENDS ON LOW-LEVEL MODULES:
   - NotificationService (high-level) directly depends on EmailService and SmsService (low-level concrete implementations)
   - DIP states: High-level modules should NOT depend on low-level modules
   - Both should depend on abstractions (interfaces/abstract classes)

2. TIGHTLY COUPLED TO CONCRETE IMPLEMENTATIONS:
   - NotificationService is hardcoded to specific implementations (EmailService, SmsService)
   - If we want to add a new notification type (e.g., PushNotification, Slack), we must modify NotificationService
   - This violates the Open/Closed Principle and is hard to maintain

3. NO ABSTRACTION LAYER:
   - There's no interface or abstract class defining the "notification contract"
   - Each notification service has its own method name (sendEmail, sendSms)
   - No common interface to work with different notification types polymorphically

4. DIFFICULT TO TEST:
   - Hard to mock or stub EmailService and SmsService for unit testing
   - Tests must depend on the actual implementations
   - Makes testing slow and brittle

5. VIOLATES DEPENDENCY INVERSION PRINCIPLE DIRECTLY:
   - Both high-level (NotificationService) and low-level (EmailService, SmsService) modules
     should depend on abstractions (NotificationChannel interface)
   - Currently, high-level depends directly on low-level concrete classes
   - This is the exact opposite of what DIP recommends

SOLUTION: 
- Create an interface/abstract class: NotificationChannel
- Make EmailService and SmsService implement NotificationChannel
- Make NotificationService depend on NotificationChannel (abstraction) instead of concrete classes
- Now both high-level and low-level modules depend on an abstraction
*/