# Factory Pattern

## What is it?

Think of it like calling a **taxi dispatch center**.

When you need a ride, you call the center and say "I need a car to the airport." You don't go to the garage yourself, pick a car, and drive it out. The dispatcher takes your request and hands you the right vehicle. You don't know — or care — which specific car it is, as long as it gets you there.

- The **dispatcher** = Factory (decides what to create)
- The **"I need a car"** = the type identifier (a string or enum passed to the factory)
- The **car / bike / bus** = Concrete Products (the actual objects returned)
- The **caller** = Client (only talks to the dispatcher — never the garage directly)

The Factory Pattern centralizes object creation. The client says *what* it wants, and the factory decides *which class* to instantiate.

## Structure

- **Factory:** A class (or method) that owns the creation logic — receives a type identifier and returns the right object.
- **Product Interface:** The common contract all created objects implement (`Transport`).
- **Concrete Products:** The actual classes the factory can return (`Car`, `Bike`, `Bus`).
- **Client:** Calls the factory and works with the interface — never with concrete classes directly.

---

## The Problem

```dart
abstract class Transport {
  void deliver();
}

class Car extends Transport {
  @override
  void deliver() => print('Delivering by car');
}

class Bike extends Transport {
  @override
  void deliver() => print('Delivering by bike');
}

class Bus extends Transport {
  @override
  void deliver() => print('Delivering by bus');
}

void main() {
  Transport bike = Bike(); // client directly instantiates concrete classes
  Transport car = Car();
  Transport bus = Bus();
}
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| Client is coupled to concrete classes | `main()` must import and know about `Car`, `Bike`, and `Bus` directly |
| OCP violated | Adding a `Truck` type requires modifying every client that creates transports |
| SRP violated | The client is doing two jobs — using the transport AND deciding which class to instantiate |
| No central creation logic | If creation needs special setup, it must be duplicated everywhere |

> **OOP Problem (Coupling):** The client directly instantiates concrete classes. Any change — a rename, a new constructor parameter, a new subtype — ripples into every caller.
>
> **SOLID Problem (OCP):** Adding a `Truck` type requires finding and changing every place that constructs transports.
>
> **SOLID Problem (SRP):** The client is responsible for both *using* the transport and *knowing how to construct* each type.

---

## The Solution — Factory Pattern

We introduce a `TransportFactory` class that owns all creation logic. The client calls `TransportFactory.createTransport()` with a type string and gets back a `Transport` — it never touches `Car`, `Bike`, or `Bus` directly.

| Role | In Our Example | What it does |
|---|---|---|
| **Factory** | `TransportFactory` | Owns creation logic — receives a string, returns the right `Transport` |
| **Product Interface** | `Transport` | The contract every concrete transport implements |
| **Concrete Products** | `Car`, `Bike`, `Bus` | Each owns exactly one vehicle's delivery behaviour |
| **Client** | `main()` | Only calls `TransportFactory.createTransport()` — never touches concrete classes |

---

## Steps We Followed

### Step 1 — Define the Product interface

```dart
abstract class Transport {
  void deliver();
}
```

> Every concrete transport must fit this shape. The client only ever knows this interface — not `Car`, `Bike`, or `Bus`.

---

### Step 2 — Create Concrete Products

```dart
class Car extends Transport {
  @override
  void deliver() => print('Delivering by car');
}

class Bike extends Transport {
  @override
  void deliver() => print('Delivering by bike');
}

class Bus extends Transport {
  @override
  void deliver() => print('Delivering by bus');
}
```

> Each class owns exactly one vehicle's behaviour. Adding a new type means adding a new class — nothing else changes.

---

### Step 3 — Create the Factory

```dart
class TransportFactory {
  static Transport createTransport(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return Car();
      case 'bike':
        return Bike();
      case 'bus':
        return Bus();
      default:
        throw Exception('Unknown transport type: $type');
    }
  }
}
```

> This is the single point of truth for object creation. Adding a `Truck` only requires a new class and one new `case` here — no client code changes.

---

### Step 4 — Update the Client

```dart
void main() {
  Transport vehicle = TransportFactory.createTransport('Bus');
  vehicle.deliver(); // Delivering by bus
}
```

> `main()` no longer imports `Car`, `Bike`, or `Bus`. It only knows `Transport` and `TransportFactory`. Swap the string — get a different vehicle. Nothing else changes.

---

## Dart-Specific: Factory Constructor Approach

Dart lets you put the factory directly on the abstract class using a `factory` constructor and an `enum`. This is idiomatic in Flutter codebases.

```dart
enum TransportType { car, bike, bus }

abstract class Transport {
  void deliver();

  factory Transport.create(TransportType type) {
    switch (type) {
      case TransportType.car:
        return Car();
      case TransportType.bike:
        return Bike();
      case TransportType.bus:
        return Bus();
    }
  }
}

class Car implements Transport {
  @override
  void deliver() => print('Deliver by Car');
}

class Bike implements Transport {
  @override
  void deliver() => print('Deliver by Bike');
}

class Bus implements Transport {
  @override
  void deliver() => print('Deliver by Bus');
}

void main() {
  final vehicle = Transport.create(TransportType.bus);
  vehicle.deliver(); // Deliver by Bus
}
```

> Using an `enum` instead of a raw string makes invalid types a compile-time error rather than a runtime exception. The `switch` is exhaustive — the compiler forces you to handle every case.

---

## Before vs After

| | Without Pattern | With Factory Pattern |
|---|---|---|
| Adding a new transport type | Modify every client that creates transports | Add one new class + one new `case` in the factory |
| Client knows about | `Car`, `Bike`, `Bus` concrete classes | Only `Transport` interface + `TransportFactory` |
| Object creation logic | Scattered across every caller | Centralized in one place |
| OCP compliance | Violated — must open every client | Respected — extend by adding, not modifying clients |
| SRP compliance | Client handles both creation and use | Factory owns creation; client owns use |

---

## Key Insight

The factory is a single point of truth for object creation. The client doesn't need to know which class it gets back — just that it implements `Transport`. This is what makes it easy to add new types, swap implementations, or inject setup logic without touching any caller.

The pattern answers one question cleanly: *"Who is responsible for deciding which class to instantiate?"* Without a factory, every caller answers that question independently. With a factory, it's answered once.

---

## Real-World Examples

- **Notification services** — `NotificationFactory.create('email' | 'sms' | 'push')` returns the right notifier. Adding Slack = one new class.
- **Payment gateways** — `PaymentFactory.create('stripe' | 'paypal')` returns the right processor without the checkout flow importing either.
- **Logger factories** — `LoggerFactory.create('file' | 'console' | 'remote')` centralizes log sink creation.
- **Database connections** — A factory creates the right connection type based on config (MySQL, PostgreSQL, SQLite).

---

## When to Use Factory

| Need | Example |
|---|---|
| The exact class to create is determined at runtime | Transport type comes from user input or config |
| You want to decouple clients from concrete classes | Checkout flow should not import `StripePayment` directly |
| Object creation logic is complex or might change | Constructor args, validation, or setup might evolve |
| You want a single place to register new types | Adding `Truck` only touches the factory |