class Invoice {
  double amount;
  Invoice(this.amount);

  void generateInvoice() {
    print('Invoice generated with amount: \$${amount.toStringAsFixed(2)}');
  }
}
