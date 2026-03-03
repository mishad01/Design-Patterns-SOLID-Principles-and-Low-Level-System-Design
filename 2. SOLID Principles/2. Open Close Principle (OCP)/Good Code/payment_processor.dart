import 'payement_method.dart';

class PaymentProcessor {
  void processPayement(PaymentMethod paymentMethod, double amount) {
    paymentMethod.pay(amount);
  }
}
