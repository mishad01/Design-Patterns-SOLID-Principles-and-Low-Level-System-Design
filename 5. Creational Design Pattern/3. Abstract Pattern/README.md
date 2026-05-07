# Abstract Factory Pattern

## What is it?

Think of it like ordering a **meal combo at a fast food chain**.

When you walk into McDonald's and order a combo, you get a burger, fries, and a drink — all from McDonald's. You don't get a KFC burger with McDonald's fries and a Subway drink. The chain guarantees everything in your meal belongs together.

- The **fast food chain brand** = Abstract Factory (`RestaurantFactory` — declares what products can be created)
- **McDonald's / KFC** = Concrete Factory (`McDonaldsFactory`, `KFCFactory` — produces one consistent family)
- The **burger / fries / drink** = Abstract Products (`Burger`, `Fries`, `Drink` — the interfaces)
- **McBurger / KFCBurger** = Concrete Products (the actual implementations)

The Abstract Factory Pattern provides an interface for creating families of related objects without specifying their concrete classes — and guarantees the products are compatible with each other.

## Structure

- **Abstract Factory (interface):** Declares methods for creating each product in the family.
- **Concrete Factory:** Implements the factory interface to produce one consistent product family.
- **Abstract Product (interface):** Declares the contract for each type of product.
- **Concrete Product:** The actual implementation for a specific family.
- **Client:** Uses only the abstract factory and abstract product interfaces — never the concrete classes.

---

## The Problem

```dart
class McBurger {
  void prepare() => print('Preparing McBurger');
}

class McFries {
  void prepare() => print('Preparing McFries');
}

class KFCBurger {
  void prepare() => print('Preparing KFC Burger');
}

class KFCFries {
  void prepare() => print('Preparing KFC Fries');
}

class Customer {
  void orderMeal(String restaurant) {
    if (restaurant == 'mcdonalds') {
      McBurger().prepare();
      McFries().prepare();
    } else {
      KFCBurger().prepare();
      KFCFries().prepare();
      // what stops someone from doing McBurger() + KFCFries() by mistake?
    }
  }
}
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| No consistency guarantee | Nothing stops mixing `McBurger` with `KFCFries` — mismatched families compile fine |
| OCP violated | Adding Burger King requires opening and modifying `Customer`'s if-else chain |
| SRP violated | `Customer` owns the creation logic for every restaurant instead of delegating it |
| Scalability | Each new restaurant or product type multiplies the places that need updating |

> **OOP Problem (Encapsulation):** Object creation logic is scattered inside `Customer` instead of being owned by dedicated factory classes.
>
> **SOLID Problem (OCP):** Adding a new restaurant means opening and modifying `Customer` — it is not closed for modification.
>
> **SOLID Problem (SRP):** `Customer` is doing two jobs — ordering the meal AND deciding how to construct each restaurant's products.

---

## The Solution — Abstract Factory Pattern

We introduce a `RestaurantFactory` interface that declares how to create each product. Each restaurant gets its own concrete factory. `Customer` only ever talks to the interface — it never knows which restaurant is actually running.

| Role | In Our Example | What it does |
|---|---|---|
| **Abstract Factory** | `RestaurantFactory` | Declares `createBurger()`, `createFries()`, `createDrink()` |
| **Concrete Factory** | `McDonaldsFactory`, `KFCFactory` | Returns the right family of products |
| **Abstract Product** | `Burger`, `Fries`, `Drink` | Declares the product interface |
| **Concrete Product** | `McBurger`, `KFCBurger`, etc. | The actual restaurant-specific implementation |
| **Client** | `Customer` | Holds a `RestaurantFactory` — never touches concrete classes |

---

## Steps We Followed

### Step 1 — Create Abstract Product interfaces

```dart
abstract class Burger {
  void prepare();
}

abstract class Fries {
  void prepare();
}

abstract class Drink {
  void prepare();
}
```

> Every concrete product must fit one of these shapes. `Customer` only ever knows these interfaces — not `McBurger` or `KFCFries`.

---

### Step 2 — Create Concrete Products

```dart
// McDonald's family
class McBurger implements Burger {
  @override
  void prepare() => print('Preparing McBurger');
}

class McFries implements Fries {
  @override
  void prepare() => print('Preparing McFries');
}

class McCola implements Drink {
  @override
  void prepare() => print('Pouring McCola');
}

// KFC family
class KFCBurger implements Burger {
  @override
  void prepare() => print('Preparing KFC Burger');
}

class KFCFries implements Fries {
  @override
  void prepare() => print('Preparing KFC Fries');
}

class KFCPepsi implements Drink {
  @override
  void prepare() => print('Pouring KFC Pepsi');
}
```

> Each class owns exactly one restaurant's behaviour for one product type.

---

### Step 3 — Create the Abstract Factory interface

```dart
abstract class RestaurantFactory {
  Burger createBurger();
  Fries createFries();
  Drink createDrink();
}
```

> This is the contract. Any concrete factory must be able to produce a `Burger`, `Fries`, and `Drink` — but the caller never knows which concrete type it gets back.

---

### Step 4 — Create Concrete Factories

```dart
class McDonaldsFactory implements RestaurantFactory {
  @override
  Burger createBurger() => McBurger();

  @override
  Fries createFries() => McFries();

  @override
  Drink createDrink() => McCola();
}

class KFCFactory implements RestaurantFactory {
  @override
  Burger createBurger() => KFCBurger();

  @override
  Fries createFries() => KFCFries();

  @override
  Drink createDrink() => KFCPepsi();
}
```

> Each factory guarantees that the products it creates belong to the same family. Mixing is impossible — `KFCFactory` can only produce KFC products.

---

### Step 5 — Update the Client to depend on the interface

```dart
class Customer {
  final RestaurantFactory factory;

  Customer(this.factory);

  void orderMeal() {
    factory.createBurger().prepare();
    factory.createFries().prepare();
    factory.createDrink().prepare();
  }
}
```

> `Customer` no longer knows about McDonald's or KFC. It only calls `createBurger()`, `createFries()`, and `createDrink()` — whatever the factory returns is guaranteed to be from the same family.

---

### Step 6 — Wire it together

```dart
void main() {
  final customer = Customer(McDonaldsFactory()); // swap to KFCFactory() — nothing else changes
  customer.orderMeal();
}
```

Want to add Burger King? Create `BurgerKingBurger`, `BurgerKingFries`, `BurgerKingDrink`, and a `BurgerKingFactory`. `Customer` is completely untouched.

---

## Before vs After

| | Without Pattern | With Abstract Factory |
|---|---|---|
| Consistency guarantee | None — any product can be mixed with any other | Enforced — a factory only produces its own family |
| Adding a new restaurant | Modify `Customer`'s if-else chain | Add one new factory class |
| Client knows about | `McBurger`, `KFCFries`, concrete classes | Only `RestaurantFactory`, `Burger`, `Fries`, `Drink` |
| OCP compliance | Violated — must open `Customer` | Respected — extend by adding a new factory |
| SRP compliance | `Customer` handles creation logic | Each factory owns its own creation logic |

---

## Key Insight

The Abstract Factory solves two problems at once: it decouples the client from concrete classes, and it enforces product family consistency. The customer never decides which concrete class to instantiate — the factory does. And because you can only get products from one factory at a time, you can never accidentally mix a McDonald's burger with KFC fries.

This is the difference between a customer who checks "which restaurant am I in?" at every step and one who simply says "give me a burger" — and trusts the factory to return the right one.

---

## Real-World Examples

- **Cross-platform UI frameworks** — Flutter and Qt use abstract factories to produce platform-native widgets (buttons, dialogs) that match the OS.
- **Database drivers** — A `DatabaseFactory` produces matching `Connection`, `Command`, and `Reader` objects for a specific database (MySQL, PostgreSQL, SQLite).
- **Theme engines** — A `ThemeFactory` produces a consistent set of colours, fonts, and shapes for light or dark mode.
- **Cloud provider SDKs** — An `InfrastructureFactory` creates matching compute, storage, and networking objects for AWS, GCP, or Azure.

---

## When to Use Abstract Factory

| Need | Example |
|---|---|
| Products must be used together consistently | Meal items that must all come from the same restaurant |
| The system should be independent of how products are created | `Customer` should not need to know it's at McDonald's |
| You want to enforce family constraints at compile time | Prevent mixing McDonald's and KFC products |
| Switching product families should require minimal code change | Swap `McDonaldsFactory` to `KFCFactory` in one place |
