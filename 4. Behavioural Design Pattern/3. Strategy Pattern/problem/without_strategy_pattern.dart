class PaymentService {
  void processPaymenr(String paymentMethod) {
    if (paymentMethod == 'CreditCard') {
      // Process credit card payment
      print('Processing credit card payment');
    } else if (paymentMethod == 'PayPal') {
      // Process PayPal payment
      print('Processing PayPal payment');
    } else if (paymentMethod == 'BankTransfer') {
      // Process bank transfer payment
      print('Processing bank transfer payment');
    } else {
      print('Invalid payment method');
    }
  }
}
//This violated open close principle because if we want to add new payment
// method we have to change this class and add new condition in this method.
// This is not good because we have to change existing code which can cause bugs
// and also it is not scalable because if we have 10 payment method we have to write 10 condition in this method.

void main() {
  PaymentService paymentService = PaymentService();
  paymentService.processPaymenr('CreditCard');
}


/*
Problems in Code
● The PaymentService class has multiple responsibilities (deciding the
payment type and processing it).
● Adding a new payment method requires modifying the PaymentService
class.
● The use of if-else conditions can make the code harder to maintain as more
payment types are added.
With the Strategy Pattern, the logic for each payment type is encapsulated in separate strategy
classes, and the PaymentService (context class) delegates the task of payment processing to one
of these strategies at runtime.
 */