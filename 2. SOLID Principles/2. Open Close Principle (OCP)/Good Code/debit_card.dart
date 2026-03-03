import 'payement_method.dart';

class DebitCard extends PaymentMethod {
  @override
  void pay(double amount) {
    // business logic
    print('Making payment via Debit Card: \$${amount.toStringAsFixed(2)}');
  }
}
