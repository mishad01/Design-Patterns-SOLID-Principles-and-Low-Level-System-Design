import '../Good Code/payment_processor.dart';
import 'credit_card.dart';
import 'payement_method.dart';
import 'upi.dart';

void main() {
  PaymentProcessor processor = PaymentProcessor();
  PaymentMethod creditCard = CreditCard();
  processor.processPayement(creditCard, 10);

  PaymentMethod upi = Upi();
  processor.processPayement(upi, 20);
}
