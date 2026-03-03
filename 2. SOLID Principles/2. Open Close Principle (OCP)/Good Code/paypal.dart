import 'payement_method.dart';

class Paypal extends PaymentMethod {
  @override
  void pay(double amount) {
    // business logic
    print('Making payment via PayPal: \$${amount.toStringAsFixed(2)}');
  }
}
