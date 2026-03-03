class PaymentProcessor {
  void processPayment(String paymentMethod, double amount) {
    if (paymentMethod == 'CreditCard') {
      // business logic
      print('Making payment via Credit Card: \$${amount.toStringAsFixed(2)}');
    } else if (paymentMethod == 'Debit Card') {
      // business logic
      print('Making payment via Debit Card: \$${amount.toStringAsFixed(2)}');
    } else if (paymentMethod == 'Paypal') {
      // business logic
      print('Making payment via PayPal: \$${amount.toStringAsFixed(2)}');
    } else {
      throw ArgumentError('Unsupported payment method: $paymentMethod');
    }
  }
}

/*
Problems:
 -  Violates Open/Closed Principle: If we want to add a new payment method, we need to modify the existing processPayment method,
    which can introduce bugs and requires retesting of existing functionality.
 - It means that if we have some existing code and we want to add new functionality that should be done by excdending this code but not by modifiying this code.
 - So in a ideal situation we dont want to disurb this piece of code code which is already tested and making modification can add potential bugs in the existing code.
  - This code is not closed for modification, it is open for modification but not for extension.
  */
