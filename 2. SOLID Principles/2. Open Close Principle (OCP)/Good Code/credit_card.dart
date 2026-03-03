import 'payement_method.dart';

class CreditCard extends PaymentMethod {
  @override
  void pay(double amount) {
    // business logic
    print('Making payment via Credit Card: \$${amount.toStringAsFixed(2)}');
  }
}
