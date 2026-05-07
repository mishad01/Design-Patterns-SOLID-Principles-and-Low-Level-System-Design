# Abstract Factory Pattern

## What is it?

Think of it like ordering a **furniture suite from a brand**.

When you walk into IKEA and pick the "STOCKHOLM" collection, you get a matching sofa, chair, and table — all in the same style. You don't pick a sofa from one collection and a chair from another and hope they match. The collection is the factory: it guarantees that every product it creates belongs to the same family.

- The **IKEA brand** = Abstract Factory (`UIFactory` — declares what products can be created)
- The **STOCKHOLM collection** = Concrete Factory (`WindowsUIFactory`, `MacOSUIFactory` — produces one consistent family)
- The **sofa / chair / table** = Abstract Products (`Button`, `ScrollBar` — the interfaces)
- The **STOCKHOLM sofa** = Concrete Products (`WindowsButton`, `MacOSButton` — the actual implementations)

The Abstract Factory Pattern provides an interface for creating families of related objects without specifying their concrete classes — and guarantees the products are compatible with each other.

## Structure

- **Abstract Factory (interface):** Declares methods for creating each product in the family.
- **Concrete Factory:** Implements the factory interface to produce one consistent product family.
- **Abstract Product (interface):** Declares the contract for each type of product.
- **Concrete Product:** The actual platform-specific implementation.
- **Client:** Uses only the abstract factory and abstract product interfaces — never the concrete classes.

---

## The Problem

```dart
class WindowsButton {
  void render() => print('Rendering Windows button');
}

class WindowsScrollBar {
  void render() => print('Rendering Windows scrollbar');
}

class MacOSButton {
  void render() => print('Rendering Mac button');
}

class MacOSScrollBar {
  void render() => print('Rendering Mac scrollbar');
}

class Application {
  void renderUI(String platform) {
    if (platform == 'windows') {
      WindowsButton().render();
      WindowsScrollBar().render();
    } else {
      MacOSButton().render();
      MacOSScrollBar().render(); // what stops someone from mixing MacOS button with Windows scrollbar?
    }
  }
}
```

```
graph TD
    App["Application"]
    WB["Windows Button"]
    WS["Windows ScrollBar"]
    MB["MacOS Button"]
    MS["MacOS ScrollBar"]
    App -- directly creates --> WB
    App -- directly creates --> WS
    App -- directly creates --> MB
    App -- directly creates --> MS
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| No consistency guarantee | Nothing stops mixing `MacOSButton` with `WindowsScrollBar` — mismatched UI families compile fine |
| OCP violated | Adding a Linux platform requires modifying `Application`'s `if-else` chain |
| SRP violated | `Application` owns the creation logic for every platform instead of delegating |
| Scalability | Each new platform or product type multiplies the number of places that need updating |

> **OOP Problem (Encapsulation):** Object creation logic is scattered inside `Application` instead of being owned by dedicated factory classes.
>
> **SOLID Problem (OCP):** Adding a new platform means opening and modifying `Application` — it is not closed for modification.
>
> **SOLID Problem (SRP):** `Application` is doing two jobs — rendering the UI AND deciding how to construct each platform's components.

---

## The Solution — Abstract Factory Pattern

We introduce a `UIFactory` interface that declares how to create each product. Each platform gets its own concrete factory. `Application` only ever talks to the interface — it never knows which platform is actually running.

| Role | In Our Example | What it does |
|---|---|---|
| **Abstract Factory** | `UIFactory` | Declares `createButton()` and `createScrollBar()` |
| **Concrete Factory** | `WindowsUIFactory`, `MacOSUIFactory` | Returns the right family of products |
| **Abstract Product** | `Button`, `ScrollBar` | Declares the product interface |
| **Concrete Product** | `WindowsButton`, `MacOSButton`, etc. | The actual platform implementation |
| **Client** | `Application` | Holds a `UIFactory` — never touches concrete classes |

---

## Steps We Followed

### Step 1 — Create Abstract Product interfaces

```dart
abstract class Button {
  void render();
}

abstract class ScrollBar {
  void render();
}
```

> Every concrete product must fit one of these shapes. `Application` only ever knows these interfaces — not the Windows or Mac versions.

---

### Step 2 — Create Concrete Products

```dart
class WindowsButton implements Button {
  @override
  void render() => print('Rendering Windows button');
}

class WindowsScrollBar implements ScrollBar {
  @override
  void render() => print('Rendering Windows scrollbar');
}

class MacOSButton implements Button {
  @override
  void render() => print('Rendering Mac button');
}

class MacOSScrollBar implements ScrollBar {
  @override
  void render() => print('Rendering Mac scrollbar');
}
```

> Each class owns exactly one platform's behaviour for one product type.

---

### Step 3 — Create the Abstract Factory interface

```dart
abstract class UIFactory {
  Button createButton();
  ScrollBar createScrollBar();
}
```

> This is the contract. Any concrete factory must produce a `Button` and a `ScrollBar` — but the caller never knows which concrete type it gets back.

---

### Step 4 — Create Concrete Factories

```dart
class WindowsUIFactory implements UIFactory {
  @override
  Button createButton() => WindowsButton();

  @override
  ScrollBar createScrollBar() => WindowsScrollBar();
}

class MacOSUIFactory implements UIFactory {
  @override
  Button createButton() => MacOSButton();

  @override
  ScrollBar createScrollBar() => MacOSScrollBar();
}
```

> Each factory guarantees that the products it creates belong to the same family. Mixing is impossible — `MacOSUIFactory` can only produce Mac products.

---

### Step 5 — Update the Client to depend on the interface

```dart
class Application {
  final UIFactory _factory;

  Application(this._factory);

  void renderUI() {
    _factory.createButton().render();
    _factory.createScrollBar().render();
  }
}
```

> `Application` no longer knows about Windows or Mac. It only calls `createButton()` and `createScrollBar()` — whatever the factory returns is guaranteed to be compatible.

---

### Step 6 — Wire it together

```dart
void main() {
  final UIFactory factory = WindowsUIFactory(); // swap to MacOSUIFactory() — nothing else changes
  final app = Application(factory);
  app.renderUI();
}
```

Want to switch platforms? Change one line. `Application` is untouched.

---

## Before vs After

| | Without Pattern | With Abstract Factory |
|---|---|---|
| Consistency guarantee | None — any component can be mixed with any other | Enforced — a factory only produces its own family |
| Adding a new platform | Modify `Application`'s if-else chain | Add one new factory class |
| Client knows about | Windows, Mac, Linux concrete classes | Only `UIFactory`, `Button`, `ScrollBar` |
| OCP compliance | Violated — must open `Application` | Respected — extend by adding a new factory |
| SRP compliance | `Application` handles creation logic | Each factory owns its own creation logic |

---

## Key Insight

The Abstract Factory Pattern solves two problems at once: it decouples the client from concrete classes, and it enforces product family consistency. The client never decides which concrete class to instantiate — the factory does. And because you can only get products from one factory at a time, you can never accidentally mix a Windows button with a Mac scrollbar.

This is the difference between a client that asks "which platform am I on?" at every step and one that simply says "give me a button" — and trusts the factory to return the right one.

---

## Real-World Examples

- **Cross-platform UI frameworks** — Flutter, Qt, and wxWidgets use abstract factories to produce platform-native widgets (buttons, text fields, dialogs) that match the OS.
- **Database drivers** — A `DatabaseFactory` produces matching `Connection`, `Command`, and `Reader` objects for a specific database (MySQL, PostgreSQL, SQLite).
- **Theme engines** — A `ThemeFactory` produces a consistent set of colours, fonts, and shapes for light or dark mode.
- **Cloud provider SDKs** — An `InfrastructureFactory` creates matching compute, storage, and networking objects for AWS, GCP, or Azure.

---

## When to Use Abstract Factory

| Need | Example |
|---|---|
| Products must be used together consistently | UI components that must match one platform's style |
| The system should be independent of how products are created | `Application` should not know it's running on Windows |
| You want to enforce family constraints at compile time | Prevent mixing Mac and Windows components |
| Switching product families should require minimal code change | Swap `WindowsUIFactory` to `MacOSUIFactory` in one place |
