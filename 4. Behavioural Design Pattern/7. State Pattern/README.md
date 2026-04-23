# State Pattern

## What is it?

Think of it like a **smartphone switching to Low Power Mode**.

The phone is the same device, but its behaviour changes depending on its current state — in Low Power Mode it dims the screen, disables background sync, and limits notifications. In Normal Mode it runs everything at full capacity. The phone does not use a giant `if-else` inside every feature to check the mode; instead, the mode itself knows how to behave.

- The **smartphone** = Context (`DirectionService` — delegates work to whatever mode is active)
- The **mode** = State (`TransportationMode` — encapsulates behaviour for that state)
- **Low Power / Normal Mode** = Concrete States (`Car`, `Walking`, `Train`, `Cycling`)

The State Pattern allows an object to alter its behaviour when its internal state changes, as if the object changed its class.

## Structure

- **State (interface):** Declares the behaviour methods every concrete state must implement.
- **Concrete State:** Implements behaviour for a specific state.
- **Context:** Holds a reference to the current state and delegates method calls to it.

---

## The Problem

```dart
enum TransportationMode { CAR, WALKING, TRAIN, CYCLING }

class DirectionService {
  TransportationMode _mode;

  int getEta() {
    switch (_mode) {
      case TransportationMode.CAR:     return 30;
      case TransportationMode.WALKING: return 60;
      case TransportationMode.TRAIN:   return 20;
      case TransportationMode.CYCLING: return 40;
    }
  }

  String getDirection() {
    switch (_mode) {
      case TransportationMode.CAR:     return 'Take the highway...';
      case TransportationMode.WALKING: return 'Head north...';
      case TransportationMode.TRAIN:   return 'Take Platform 1...';
      case TransportationMode.CYCLING: return 'Follow the bike lane...';
    }
  }
}
```

```
graph TD
    C["Client"]
    DS["Direction Service"]
    TM["Transportation Mode (Enum)"]
    C -- calls getEta / getDirection --> DS
    DS -- switch-case on --> TM
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| Repeated switch-case blocks | Every method (`getEta`, `getDirection`, future methods) must repeat the same conditional logic |
| OCP violated | Adding `AIRPLANE` mode requires opening and modifying `DirectionService` |
| SRP violated | `DirectionService` handles routing logic for every possible mode instead of delegating |
| Scalability | Each new mode multiplies the number of places that need to be updated |

> **OOP Problem (Encapsulation):** Each mode's behaviour is scattered across multiple `switch` blocks inside `DirectionService` instead of being owned by the mode itself.
>
> **SOLID Problem (OCP):** Adding a new transportation mode means modifying the existing class — it is not closed for modification.
>
> **SOLID Problem (SRP):** `DirectionService` is doing too much — it owns the routing logic for every mode rather than delegating.

---

## The Solution — State Pattern

We extract each mode's behaviour into its own class. `DirectionService` holds a reference to the current `TransportationMode` and simply delegates method calls to it. Switching modes is just swapping the reference.

| Role | In Our Example | What it does |
|---|---|---|
| **State** (interface) | `TransportationMode` | Declares `calculateEta()` and `getDirection()` |
| **Concrete State** | `Car`, `Walking`, `Train`, `Cycling` | Implements behaviour for that specific mode |
| **Context** | `DirectionService` | Holds current mode, delegates to it |
| **Client** | `main()` | Creates context, switches state via `setTransportationMood()` |

---

## Steps We Followed

### Step 1 — Create the State interface

```dart
abstract class TransportationMode {
  int calculateEta();
  String getDirection();
}
```

> Every concrete mode must implement these two methods. `DirectionService` only ever talks to this interface — never to a concrete class directly.

---

### Step 2 — Create Concrete States

```dart
class Car extends TransportationMode {
  @override
  int calculateEta() => 10;

  @override
  String getDirection() => 'Directions for car';
}

class Cycling extends TransportationMode {
  @override
  int calculateEta() => 5;

  @override
  String getDirection() => 'Directions for Cycling';
}

class Walking extends TransportationMode {
  @override
  int calculateEta() => 10;

  @override
  String getDirection() => 'Directions for walking';
}

class Train extends TransportationMode {
  @override
  int calculateEta() => 10;

  @override
  String getDirection() => 'Directions for train';
}
```

> Each class owns exactly its own behaviour. Adding a new mode like `Airplane` means creating one new class — nothing else changes.

---

### Step 3 — Update the Context to delegate

```dart
class DirectionService {
  TransportationMode transportationMode;

  DirectionService({required this.transportationMode});

  void setTransportationMood(TransportationMode mode) {
    transportationMode = mode;
  }

  int getEta() => transportationMode.calculateEta();

  String getDirection() => transportationMode.getDirection();
}
```

> No more `switch` statements. `DirectionService` simply delegates to whatever state is currently set. The context is now closed for modification — adding a new mode does not touch this file.

---

### Step 4 — Use the Context in the client

```dart
DirectionService service = DirectionService(transportationMode: Car());
service.setTransportationMood(Cycling());

print('Eta: ${service.getEta()}');
print('Direction: ${service.getDirection()}');
```

> The client constructs the context with an initial state and can switch states at runtime. The context's API never changes.

---

## Before vs After

| | Without Pattern | With State Pattern |
|---|---|---|
| Adding a new mode | Modify `switch` blocks in every method | Add one new class, touch nothing else |
| Each mode's behaviour lives | Scattered across `DirectionService` | Encapsulated in its own class |
| OCP compliance | Violated — class must be modified | Respected — open for extension only |
| SRP compliance | Violated — class owns all mode logic | Respected — each class has one job |
| Readability | Switch blocks grow with every mode | Each mode is self-contained and easy to read |

---

## Key Insight

The State Pattern moves `if/switch` logic out of the context and into self-contained state classes. The context stops asking "what state am I in?" and starts delegating "handle this for me". The result is that adding new states never requires touching existing code — you only add.

This is the difference between a context that *contains* all the behaviour and one that *delegates* to the behaviour that is currently active.

---

## Real-World Examples

- **Media players** — Playing, Paused, Stopped states each handle `play()`, `pause()`, `stop()` differently without a giant switch in the player class.
- **Traffic lights** — Red, Yellow, Green each know what comes next and how long to wait.
- **Order lifecycle** — New, Processing, Shipped, Delivered, Cancelled each have their own rules for what transitions are allowed.
- **ATM machines** — No Card, Has Card, Has PIN, Out of Cash — each state decides what actions are valid.
- **Vending machines** — Idle, Item Selected, Payment Received — each state handles button presses differently.

---

## When to Use State

| Need | Example |
|---|---|
| Object behaviour changes with internal state | Transportation mode, media player, ATM |
| Large conditionals based on state | Multiple switch blocks that grow with every new state |
| State transitions need to be explicit | Order lifecycle, traffic light sequencing |
| Each state should be independently testable | Test `Car.calculateEta()` without touching `DirectionService` |