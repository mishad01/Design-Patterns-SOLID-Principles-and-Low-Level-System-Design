# Advanced Class Features in Dart

This structured guide covers advanced class capabilities in Dart, which are essential for building robust, scalable, and immutable applications—especially when working with Flutter state management.

## 1. Operator Overloading (`operator_overloading.dart`)

By default, objects inherit standard behaviors for operators like `==` and methods like `toString()` from the base `Object` class. Overloading allows you to define exactly how these behave for your custom classes.

### Important Overrides:

*   **`toString()` Method:**
    *   *Default:* Prints something unhelpful like `Instance of 'Person'`.
    *   *Override:* Return a readable string representing the object's data. Crucial for debugging/logging.
*   **`==` Operator (Equality):**
    *   *Default (Reference Equality):* Two objects are equal *only* if they share the exact same spot in memory.
    *   *Override (Value Equality):* Make it so two different objects are considered equal if they hold the *exact same data*.
*   **`hashCode`:**
    *   *Rule:* If you override `==`, you **must** also override `hashCode`. Objects that are equal must return the same hash code!

### Example:
```dart
class Person {
  String name;
  int age;

  Person({this.name = "Unknown", this.age = 0});

  @override
  String toString() {
    return 'Person(name: $name, age: $age)'; // Better debug output
  }

  @override
  bool operator ==(Object other) {
    // Check type and deeply compare values
    return other is Person && other.name == name && other.age == age;
  }
  
  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
```

## 2. The `copyWith` Pattern & Immutability (`copy_with.dart`)

In modern Dart and Flutter, we often use **Immutable** objects (where fields are `final`). Instead of mutating an object directly (which can lead to untraceable bugs), we use a `copyWith` method to create a *new* instance with some selectively modified fields, while copying the rest.

### Why is this crucial for State Management?
In frameworks like Bloc, Riverpod, or Redux:
1.  **Efficient Rebuilds:** The framework compares object memory addresses (Identity) rather than checking every single field, which is extremely fast.
2.  **The Trigger:** If you mutate an object in place (`person.age = 22`), the memory reference stays the same. The framework thinks nothing changed and the UI won't update.
3.  **The Solution:** Using `copyWith` creates a completely new instance (new memory reference). The system sees `oldState != newState` and triggers a UI rebuild!

### Example:
```dart
class Person {
  final String? name;
  final int? age;

  Person({this.name, this.age});

  // copyWith takes optional parameters. 
  // If provided, use the new value. If null, fallback to the current instance's value.
  Person copyWith({String? newName, int? newAge}) {
    return Person(
      name: newName ?? this.name,
      age: newAge ?? this.age,
    );
  }
}
```

---

## 3. Composition (`composition.dart`)

Composition is a design principle where a class is composed of objects of other classes as member variables. It establishes a **"has-a"** relationship rather than an **"is-a"** relationship (Inheritance).

### Composition vs. Inheritance
*   **Inheritance (Is-A):** A `Car` *is a* `Vehicle`. Great for strict hierarchies.
*   **Composition (Has-A):** A `Car` *has an* `Engine`. Great for building complex objects from smaller, reusable, and interchangeable components.

### Why prefer Composition?
*   **Flexibility:** You can easily swap components at runtime (e.g., swapping a gas engine for an electric engine).
*   **Loose Coupling:** Changes in a nested component don't ripple through an entire inheritance chain, avoiding rigid and fragile code structures.

### Example:
```dart
class Engine {
  final String type;
  Engine(this.type);
}

class Car {
  final String model;
  final Engine engine; // Composition: Car "has an" Engine
  
  Car({required this.model, required this.engine});
}
```

---


## Summary
- **Composition:** Build complex classes by combining simpler, reusable component classes ("Has-A").
- **`copyWith` (Immutability):** Create new instances rather than mutating old ones; an essential strategy for reliable UI updates.
- **Operator Overloading:** Teach Dart how to gracefully convert your custom objects to text (`toString()`) and how to properly compare their values (`==` / `hashCode`).
