abstract class PaymentStrategy {
  void processPayment();
}

//Concreate strategy: Credit card
class CreditCardPayments extends PaymentStrategy {
  @override
  void processPayment() {
    print('Making payment via credit card');
  }
}

//Concreate strategy: Credit card
class DebitCardPayments extends PaymentStrategy {
  @override
  void processPayment() {
    print('Making payment via debit card');
  }
}

class PaymentService {
  late PaymentStrategy strategy;
  void setPayementStrategy(PaymentStrategy strategy) {
    this.strategy = strategy;
  }

  void pay() {
    strategy.processPayment();
    //Polymorphism //This is a example of polymorphic behavior, because we dont
    //know which method its gonna call
  }
}

void main() {
  PaymentService paymentService = PaymentService();
  paymentService.setPayementStrategy(CreditCardPayments());
  paymentService.pay();
}
