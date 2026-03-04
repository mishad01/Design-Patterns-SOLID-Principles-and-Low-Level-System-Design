import '../Good Code/notification_service.dart';
import 'email_service.dart';
import 'sms_service.dart';

void main() {
  NotificationService emailNotification = NotificationService(
    notificationChannel: EmailService(),
  );
  emailNotification.notify("Your order has been shipped");

  NotificationService smsNotification = NotificationService(
    notificationChannel: SmsService(),
  );

  smsNotification.notify("OTP 1234");
}
/*
Why this follows the Dependency Inversion Principle (DIP):

1. HIGH-LEVEL DEPENDS ON ABSTRACTION, NOT LOW-LEVEL:
   - NotificationService (high-level) depends on NotificationChannel interface (abstraction)
   - EmailService and SmsService (low-level) also implement NotificationChannel (abstraction)
   - Both high-level and low-level modules depend on abstraction - NOT on each other

2. LOOSE COUPLING THROUGH INTERFACES:
   - NotificationService doesn't know or care about specific implementations
   - It only knows about the NotificationChannel contract (notify method)
   - Easy to swap implementations: EmailService, SmsService, or any new service (Slack, Push, etc.)

3. EASY TO EXTEND WITHOUT MODIFICATION:
   - Want to add PushNotificationService? Just implement NotificationChannel interface
   - No changes needed to NotificationService or main.dart
   - Follows Open/Closed Principle - open for extension, closed for modification

4. EASY TO TEST:
   - Can create mock NotificationChannel implementations for unit testing
   - No need to depend on real EmailService or SmsService
   - Tests are fast, isolated, and reliable

5. DEPENDENCY INJECTION:
   - NotificationService receives its dependencies (NotificationChannel) through constructor
   - Dependencies are injected from outside, not created internally
   - Makes the code flexible and testable

6. SINGLE RESPONSIBILITY:
   - NotificationService only handles notification logic
   - Each concrete service (EmailService, SmsService) only handles its specific communication

BENEFITS:
✓ Decoupled from concrete implementations
✓ Easy to add new notification types
✓ Easy to test with mock implementations
✓ Changes in low-level modules don't affect high-level modules
✓ Follows Open/Closed Principle and Single Responsibility Principle
✓ Professional, maintainable, and scalable code architecture
*/