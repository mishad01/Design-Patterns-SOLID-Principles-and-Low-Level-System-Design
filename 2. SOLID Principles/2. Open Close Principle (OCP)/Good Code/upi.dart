import 'payement_method.dart';

class Upi extends PaymentMethod {
  @override
  void pay(double amount) {
    // business logic
    print('Making payment via UPI: \$${amount.toStringAsFixed(2)}');
  }
}
