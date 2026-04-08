# Strategy Pattern

## What is it?

Think of it like a **GPS navigation app**.

You type in your destination. Then you pick *how* you want to travel — by car, by bike, or on foot. The app gives you different routes based on what you pick. You can switch anytime. The destination doesn't change — only the *strategy* to get there does.

- The **navigation app** = Context (it holds the strategy)
- The **route algorithm** = Strategy (car, bike, walk)

The Strategy Pattern lets you swap out the *how* of doing something — without touching the rest of the code.

---

## The Problem

Look at the code in `problem/without_strategy_pattern.dart`.

We have a `PaymentService` that handles payments. To support different payment methods, it uses a big if-else block:

```dart
void processPayment(String paymentMethod) {
  if (paymentMethod == 'CreditCard') {
    print('Processing credit card payment');
  } else if (paymentMethod == 'PayPal') {
    print('Processing PayPal payment');
  } else if (paymentMethod == 'BankTransfer') {
    print('Processing bank transfer payment');
  }
}
```

**What goes wrong?**

| Problem | Why it hurts |
|---|---|
| Want to add `Crypto` payment? | You must open `PaymentService` and add another `else if` |
| 10 payment methods? | 10 conditions inside one class — hard to read and maintain |
| Want to test one payment type? | You can't — it is all tangled inside one method |

> **OOP Problem (Encapsulation):** Each payment logic is crammed inside one method. None of the payment types are proper objects — they are just string checks.
>
> **SOLID Problem (OCP):** Every time you add a new payment method, you open and edit `PaymentService`. It should be *closed* for modification but *open* for extension.
>
> **SOLID Problem (SRP):** `PaymentService` has two jobs — deciding *which* payment method to use, and also *doing* the payment. These should be separate.

---

## The Solution — Strategy Pattern

Look at the code in `solution/strategy_pattern.dart`.

The fix is to pull each payment method out into its own class. All of them follow the same interface. `PaymentService` just holds one strategy and calls it — it never cares about the details.

| Class | Role | Simple way to think of it |
|---|---|---|
| `PaymentStrategy` | The abstract interface | A contract: every strategy must have `processPayment()` |
| `CreditCardPayments` | A concrete strategy | One specific way to pay |
| `DebitCardPayments` | Another concrete strategy | Another specific way to pay |
| `PaymentService` | The context | Holds a strategy and calls it when needed |

---

## Steps We Followed

### Step 1 — Create the Strategy interface

We defined `PaymentStrategy`. It is just a contract that says: any class that wants to be a payment strategy must have a `processPayment()` method.

```dart
abstract class PaymentStrategy {
  void processPayment();
}
```

> Think of it as a job description. Anyone who fits the description can be hired.

---

### Step 2 — Create concrete strategies

Each payment method becomes its own class. They each implement `PaymentStrategy`.

```dart
class CreditCardPayments extends PaymentStrategy {
  @override
  void processPayment() {
    print('Making payment via credit card');
  }
}

class DebitCardPayments extends PaymentStrategy {
  @override
  void processPayment() {
    print('Making payment via debit card');
  }
}
```

> Each class does one thing only. Adding `CryptoPayments` later? Just create a new class — nothing else changes.

---

### Step 3 — Update the Context (PaymentService)

`PaymentService` no longer knows *how* to pay. It just holds a strategy and delegates to it.

```dart
class PaymentService {
  late PaymentStrategy strategy;

  void setPaymentStrategy(PaymentStrategy strategy) {
    this.strategy = strategy;  // swap strategy at any time
  }

  void pay() {
    strategy.processPayment();  // delegate — no if-else, no details
  }
}
```

> `PaymentService` is now like a cashier. You hand them the payment card. They don't care if it is credit, debit, or crypto — they just process whatever you give them.

---

### Step 4 — Wire it together

```dart
PaymentService paymentService = PaymentService();

// Use credit card
paymentService.setPaymentStrategy(CreditCardPayments());
paymentService.pay();  // Making payment via credit card

// Switch to debit card
paymentService.setPaymentStrategy(DebitCardPayments());
paymentService.pay();  // Making payment via debit card
```

You can **swap the strategy at runtime** — no if-else, no reopening `PaymentService`.

---

## How Polymorphism Works Here

When you call `strategy.processPayment()`, Dart does not know at compile time which class will run. It figures it out at runtime based on what you put into `strategy`.

```
strategy = CreditCardPayments()  →  calls CreditCardPayments.processPayment()
strategy = DebitCardPayments()   →  calls DebitCardPayments.processPayment()
```

This is **runtime polymorphism** — the same call behaves differently depending on the object behind it.

---

## Before vs After

| | Without Pattern | With Strategy Pattern |
|---|---|---|
| Add a new payment method | Open `PaymentService`, add `else if` | Create a new class, done |
| `PaymentService` knows about | All payment details | Only the `PaymentStrategy` interface |
| Testing one payment type | Hard — all tangled together | Easy — each class is independent |
| Switching payment at runtime | You'd pass a string and hope it matches | Just call `setPaymentStrategy()` |

---

## Key Roles in This Pattern

| Role | In this example | What it does |
|---|---|---|
| **Strategy (interface)** | `PaymentStrategy` | Defines the method every strategy must implement |
| **Concrete Strategy** | `CreditCardPayments`, `DebitCardPayments` | The actual implementation of the behavior |
| **Context** | `PaymentService` | Holds a strategy, delegates the work to it |
| **setStrategy()** | `setPaymentStrategy(strategy)` | Allows swapping the behavior at runtime |

---

## Real-World Examples

- **Payment Gateways** — Credit card, PayPal, Apple Pay. Each is a strategy. The checkout just calls `pay()`.
- **Sorting Algorithms** — A list can be sorted by bubble sort, merge sort, or quick sort. The list doesn't care which one — you just plug in the strategy.
- **Compression Tools** — ZIP, RAR, GZIP are all strategies for compressing a file. The app lets you pick one.
- **Navigation Apps** — Driving, cycling, walking routes are strategies. The map just renders whatever route the strategy produces.
- **Text Formatting** — Plain text, HTML, Markdown are strategies for formatting the same content. (See the task in `task/task.md`.)
- **Login Methods** — Username/password, Google login, Face ID are all authentication strategies.

---

## Diagram

```
         ┌──────────────────┐
         │  PaymentService  │   Context
         │  (context)       │
         │                  │
         │  strategy ───────┼──────────────────────────┐
         │  pay()           │                          │
         └──────────────────┘                          ▼
                                            ┌─────────────────────┐
                                            │   PaymentStrategy   │  <<abstract>>
                                            │   processPayment()  │
                                            └─────────────────────┘
                                                      ▲
                                        ┌─────────────┴──────────────┐
                               ┌────────────────┐          ┌──────────────────┐
                               │ CreditCard     │          │  DebitCard       │
                               │ Payments       │          │  Payments        │
                               │processPayment()│          │ processPayment() │
                               └────────────────┘          └──────────────────┘
```

---

## Summary

The Strategy Pattern solves one specific problem: **what if a class needs to do the same job in multiple different ways, and you want to be able to swap those ways freely?**

The answer: pull each *way* into its own class. Give them all the same interface. The context class just holds one of them and calls it — no if-else, no knowing the details.

This keeps your code **open to new behaviors** without touching existing code, and makes each behavior **testable and replaceable** on its own.

---

## When to Use Strategy

| Need | Example |
|---|---|
| Multiple ways to do the same thing | Payment methods, sorting algorithms |
| Switch behavior at runtime | User picks how to pay, how to sort |
| Avoid long if-else or switch blocks | `if creditCard ... else if paypal ...` |
| Add new behaviors without changing existing code | New payment method, new compression type |
| Test each behavior in isolation | Unit-test `CreditCardPayments` alone |
