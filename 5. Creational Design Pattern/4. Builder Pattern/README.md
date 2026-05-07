# Builder Pattern

## What is it?

Think of it like **ordering a custom burger at a restaurant**.

You don't hand the kitchen a finished burger — you call out each part: "I want a sesame bun, double beef patty, add cheese, no onions, extra sauce." The kitchen builds it step by step, in order, based on your choices. You get exactly what you want, and the kitchen never has to guess which toppings are optional.

- The **customer** = Client (decides what to order)
- The **order slip** = Builder (`HouseBuilder` — records each step of the construction)
- The **kitchen** = Director (calls the builder steps in the right order — optional but useful)
- The **finished burger** = Product (`House` — the final complex object)

The Builder Pattern separates the construction of a complex object from its representation, letting you produce different configurations of the same object using the same construction process.

## Structure

- **Builder (interface):** Declares the construction steps every concrete builder must implement.
- **Concrete Builder:** Implements the steps and provides a method to return the finished product.
- **Director (optional):** Defines the order in which to call the builder steps for a specific configuration.
- **Product:** The complex object being constructed.

---

## The Problem

```dart
class House {
  final String foundation;
  final int walls;
  final String roofType;
  final int floors;
  final bool hasGarage;
  final bool hasGarden;
  final bool hasSwimmingPool;

  House(
    this.foundation,
    this.walls,
    this.roofType,
    this.floors,
    this.hasGarage,
    this.hasGarden,
    this.hasSwimmingPool,
  );
}

// Hard to read — what does false, false, true mean?
House simpleHouse   = House('concrete', 4, 'flat',   1, false, false, false);
House luxuryHouse   = House('stone',    8, 'gabled',  3, true,  true,  true);
House gardenCottage = House('wood',     4, 'thatched',1, false, true,  false);
```

```
graph TD
    Client["Client"]
    House["House (7-param constructor)"]
    Client -- House(...,...,...,...,...,...,...) --> House
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| Constructor telescope | 7 positional parameters — easy to pass arguments in the wrong order |
| Optional parameters unclear | `false, false, true` in a call tells you nothing about what those values mean |
| Many configurations | Each config requires memorising the full parameter list every time |
| OCP violated | Adding an 8th option (e.g., `hasSolar`) forces every existing callsite to be updated |

> **OOP Problem (Readability):** The constructor call `House('concrete', 4, 'flat', 1, false, false, false)` is opaque — a reader cannot tell which booleans represent which features without counting parameters.
>
> **SOLID Problem (OCP):** Adding a new optional attribute requires modifying the constructor signature, breaking every existing callsite.
>
> **SOLID Problem (SRP):** The `House` class both defines what a house *is* and controls the entire validation and assembly process through one monolithic constructor.

---

## The Solution — Builder Pattern

We extract the construction process into a `HouseBuilder`. Each step sets exactly one property and returns the builder itself so steps can be chained. The final `build()` call assembles and returns the product.

| Role | In Our Example | What it does |
|---|---|---|
| **Product** | `House` | The complex object being assembled |
| **Builder** | `HouseBuilder` | Holds state for each step; returns `this` for chaining |
| **Director** (optional) | `HouseDirector` | Calls builder steps in a fixed order for common configurations |
| **Client** | `main()` | Uses the builder directly or via the director |

---

## Steps We Followed

### Step 1 — Define the Product

```dart
class House {
  final String foundation;
  final int walls;
  final String roofType;
  final int floors;
  final bool hasGarage;
  final bool hasGarden;
  final bool hasSwimmingPool;

  House._({
    required this.foundation,
    required this.walls,
    required this.roofType,
    required this.floors,
    required this.hasGarage,
    required this.hasGarden,
    required this.hasSwimmingPool,
  });
}
```

> The constructor is private (`._`). Only the builder can call it — no one else can create a half-built `House`.

---

### Step 2 — Create the Builder

```dart
class HouseBuilder {
  String _foundation = 'concrete';
  int _walls = 4;
  String _roofType = 'flat';
  int _floors = 1;
  bool _hasGarage = false;
  bool _hasGarden = false;
  bool _hasSwimmingPool = false;

  HouseBuilder setFoundation(String foundation) {
    _foundation = foundation;
    return this;
  }

  HouseBuilder setWalls(int walls) {
    _walls = walls;
    return this;
  }

  HouseBuilder setRoofType(String roofType) {
    _roofType = roofType;
    return this;
  }

  HouseBuilder setFloors(int floors) {
    _floors = floors;
    return this;
  }

  HouseBuilder addGarage() {
    _hasGarage = true;
    return this;
  }

  HouseBuilder addGarden() {
    _hasGarden = true;
    return this;
  }

  HouseBuilder addSwimmingPool() {
    _hasSwimmingPool = true;
    return this;
  }

  House build() {
    return House._(
      foundation: _foundation,
      walls: _walls,
      roofType: _roofType,
      floors: _floors,
      hasGarage: _hasGarage,
      hasGarden: _hasGarden,
      hasSwimmingPool: _hasSwimmingPool,
    );
  }
}
```

> Every step is named, returns `this` for chaining, and has a sensible default. Adding a new optional feature means adding one method — no existing callsites break.

---

### Step 3 — Use the Builder directly (client)

```dart
House simpleHouse = HouseBuilder()
    .setFoundation('concrete')
    .build();

House luxuryHouse = HouseBuilder()
    .setFoundation('stone')
    .setWalls(8)
    .setRoofType('gabled')
    .setFloors(3)
    .addGarage()
    .addGarden()
    .addSwimmingPool()
    .build();
```

> Each call is self-documenting. `addGarage()` is unambiguous; `false` in a positional list is not.

---

### Step 4 — Add a Director for common configurations (optional)

```dart
class HouseDirector {
  static House buildSimpleHouse() {
    return HouseBuilder()
        .setFoundation('concrete')
        .setRoofType('flat')
        .build();
  }

  static House buildLuxuryHouse() {
    return HouseBuilder()
        .setFoundation('stone')
        .setWalls(8)
        .setRoofType('gabled')
        .setFloors(3)
        .addGarage()
        .addGarden()
        .addSwimmingPool()
        .build();
  }
}
```

> The Director captures reusable recipes. You can still use the builder directly for one-off configurations.

---

## Before vs After

| | Without Pattern | With Builder Pattern |
|---|---|---|
| Readability | `House('concrete', 4, 'flat', 1, false, false, false)` — opaque | `HouseBuilder().setFoundation('concrete').build()` — self-documenting |
| Adding a new option | Change the constructor + every callsite | Add one method to the builder; existing callsites unchanged |
| Optional fields | All positional — must pass a value for every field | Only call the steps you need; everything else defaults |
| Partial construction | Constructor either fully succeeds or fails | Builder holds state across steps; build() validates at the end |
| Named configurations | Copy-paste the long constructor call | Director encapsulates named recipes |

---

## Key Insight

The Builder Pattern solves the "telescoping constructor" problem — where constructors accumulate more and more parameters until they become unreadable and error-prone. By replacing the constructor with a chain of named methods, each configuration choice becomes explicit. The product is only assembled at the final `build()` call, which means the builder can validate the complete state before handing anything back.

This is the difference between a constructor that demands all answers upfront and a builder that lets you describe what you want, one clear step at a time.

---

## Real-World Examples

- **Query builders** — `QueryBuilder().select('*').from('users').where('active = true').limit(10).build()` instead of a SQL string assembled with raw concatenation.
- **HTTP request builders** — `HttpRequest().url('...').header('Auth', token).body(payload).post()`.
- **UI widget builders** — Flutter's `ThemeData` and `ButtonStyle` use builder-style constructors with named parameters for the same reason.
- **Email/notification builders** — `EmailBuilder().to('...').subject('...').body('...').addAttachment(file).send()`.
- **Test data factories** — Build complex test objects step by step, overriding only the fields relevant to each test.

---

## When to Use Builder

| Need | Example |
|---|---|
| Constructor has too many parameters | 5+ parameters, especially optional ones |
| Multiple valid configurations of the same object | Simple house, luxury house, cottage |
| Construction must happen in a specific order | Foundation → walls → roof — each step depends on the previous |
| You want self-documenting construction code | `addGarage()` is clearer than passing `true` as the 5th argument |
| The product should only be valid after all required steps complete | `build()` validates before returning |
