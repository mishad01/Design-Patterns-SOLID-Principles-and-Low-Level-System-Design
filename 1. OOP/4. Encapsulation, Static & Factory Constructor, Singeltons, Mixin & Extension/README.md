# Advanced OOP Concepts in Dart

This structured guide covers intermediate and advanced Object-Oriented Programming (OOP) concepts in Dart, helping you write more secure, memory-efficient, and reusable code.

## 1. Encapsulation

Encapsulation is the bundling of data (properties) and methods that operate on the data into a single unit (class). More importantly, it is the mechanism of **hiding the internal state** of an object and requiring all interaction to be performed through an object's methods (Getters and Setters).

### Why Encapsulate?
- **Control and Validation:** You can validate data before assigning it (e.g., ensuring a salary is not negative).
- **Data Hiding:** By using the `_` (underscore) prefix in Dart, variables become private to the library/file, preventing unauthorized access from outside.
- **Flexibility:** You can change the internal implementation without affecting the code that uses your class.

### Example:
```dart
class Employee {
  String _name;
  double _salary; // Private property

  Employee(this._name, this._salary);

  // Getter (Read Access)
  String get name => _name;

  // Setter (Write Access with Validation)
  set salary(double newSalary) {
    if (newSalary < 0) {
      print("Error: Salary cannot be negative.");
    } else {
      _salary = newSalary;
    }
  }
}
```

---

## 2. The `static` Keyword

Static members (variables and methods) belong to the **class itself** rather than to any specific instance (object) of that class.

### Core Concepts:
- **Class-Level vs. Instance-Level:** You access static members directly using the class name (`ClassName.variable`), without needing to create an object via `new`.
- **Memory Efficiency:** There is only one copy of a static variable in memory throughout the application lifecycle, shared by all instances.
- **Utility Methods:** Perfect for global helper functions that don't depend on individual object state (e.g., mathematical calculations).

### Example:
```dart
class Constants {
  static double pi = 3.14159; // Shared memory space
  
  static double calculateArea(double radius) {
    return pi * radius * radius;
  }
}
// Usage: Constants.calculateArea(5.0);
```

---

## 3. Factory Constructors & Singletons

### Factory Constructors
Unlike a normal constructor, which always creates a new instance of its class, a `factory` constructor can:
- **Return an existing instance** from a cache.
- **Return an instance of a subclass** (polymorphism).
- Be used to implement the **Singleton pattern**.

### The Singleton Pattern
The Singleton pattern ensures that a class has **only one instance** and provides a global point of access to it. This is widely used in Flutter for database connections, shared preferences, and network clients.

### Example:
```dart
class Database {
  // 1. Private static instance variable
  static final Database _instance = Database._internal();

  // 2. Private named constructor
  Database._internal();

  // 3. Factory constructor returning the same static instance
  factory Database() {
    return _instance;
  }
}

// Usage: Database() == Database() will be true.
```

---

## 4. Mixins (`with`)

Dart supports single inheritance. Mixins provide a way to reuse a class's code in multiple, unrelated class hierarchies without requiring a parent-child relationship (**Composition over Inheritance**).

### Key Rules:
- Created using the `mixin` keyword.
- Applied to a class using the `with` keyword.
- A class can use multiple mixins (`class A with Mixin1, Mixin2`).

### Example:
```dart
mixin Flyable {
  void fly() => print("Flying in the sky!");
}

class Animal { ... }

class Duck extends Animal with Flyable {
  // Duck inherits from Animal, but also gets fly() from the Flyable mixin
}
```

---

## 5. Extensions

Extensions allow you to add new functionality (methods, getters, setters) to **existing libraries or types** (like `String`, `int`, or even third-party classes) without modifying their original source code or creating subclasses.

### Why use Extensions?
- Keeps code clean and readable.
- Eliminates the need for verbose utility/helper classes (e.g., `StringUtils.capitalize(str)` becomes `str.capitalize()`).
- Safe to use with Nullable and Generic types.

### Example:
```dart
extension StringExtension on String {
  // Adds a convenient parser directly to all Strings
  int toInt() {
    return int.parse(this); 
  }
}

// Usage: "123".toInt();
```

## Summary
- **Encapsulation:** Protect data using `_private` properties and expose safe access via Getters/Setters.
- **Static:** State or behavior tied to the class blueprint, not the individual objects.
- **Factory/Singleton:** Control instance creation and ensure a single shared instance of a heavily-used resource.
- **Mixins (`with`):** Inject reusable behaviors across unrelated objects.
- **Extensions (`extension on`):** Upgrade existing native or external types with custom, clean helper methods.
