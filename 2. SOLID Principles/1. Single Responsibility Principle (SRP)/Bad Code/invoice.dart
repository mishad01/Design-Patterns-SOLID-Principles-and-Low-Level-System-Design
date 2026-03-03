class Invoice {
  double amount;
  Invoice(this.amount);

  void generateInvoice() {
    print('Invoice generated with amount: \$${amount.toStringAsFixed(2)}');
  }

  void SaveToDatabase() {
    print('Invoice saved to database.');
  }

  void sendEmail() {
    print('Invoice sent via email.');
  }
}
/* 
Problems:
Invoice Generation - generateInvoice() handles formatting and printing the invoice
Database Persistence - SaveToDatabase() handles saving to database
Email Notification - sendEmail() handles sending emails

Why it's bad:
Multiple reasons to change: The class would need to be modified if we change how invoices are generated, how data is persisted, or how emails are sent.
Also if you want to add a new feature like notification, we'd have to modify the Invoice class, which violates the Open/Closed Principle as well.

Hard to test: We'd need to mock database and email operations just to test invoice generation
Low reusability: We can't reuse the invoice generation logic without the database/email baggage
Tight coupling: The Invoice class is tightly coupled to database and email implementations
 */