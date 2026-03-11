# Inheritance in Dart

Inheritance is a fundamental concept in Object-Oriented Programming (OOP) that allows a class to inherit properties and methods from another class. This establishes an **"is a"** relationship between the classes.

## Basic Concepts

- **Parent/Base/Super Class**: The class whose properties and methods are inherited (e.g., `Animal`).
- **Child/Derived/Sub Class**: The class that inherits from another class (e.g., `Dog`, `Cat`).
- **`extends` Keyword**: Used to create a child class that inherits from a parent class (e.g., `class Dog extends Animal`).

### Example:
```dart
class Animal {
  int age = 0;
  void eat() {
    print("Animal is eating");
  }
}

class Dog extends Animal {
  void bark() {
    print("Dog is barking");
  }
}
```
In this example, `Dog` "is an" `Animal`. The `Dog` class inherits the `age` property and the `eat()` method from the `Animal` class, and adds its own unique method `bark()`.

## The `super` Keyword

The `super` keyword is used to refer to the immediate parent class. It is commonly used to access parent class properties, methods, or constructors.

## Method Overriding (`@override`)

A child class can provide a specific implementation of a method that is already provided by its parent class. This is called method overriding.
- Use the `@override` annotation to explicitly indicate that a method is overriding a parent's method (good practice).
- You can use the `super` keyword to call the parent's implementation inside the overridden method.

```dart
class Dog extends Animal {
  // Overriding the eat method from Animal
  @override
  void eat() {
    super.eat(); // Calls Animal's eat() method first
    print("Dog is eating"); // Then executes Dog's specific behavior
  }
}
```

## Types of Inheritance in Dart

Dart supports some types of inheritance directly through the `extends` keyword, while others are handled differently to avoid common OOP pitfalls like the "Diamond Problem".

### 1. Single Inheritance (Supported)
A child class inherits from a single parent class.
```dart
class A {
  void methodA() { print("Method A"); }
}

class Dog extends Animal { ... } // Dog inherits only from Animal
```

### 2. Multilevel Inheritance (Supported)
A class inherits from a child class, forming a chain of inheritance.
```dart
class B {
  void methodB() { print("Method B"); }
}

class C extends B {
  void methodC() { print("Method C"); }
}
// C inherits from B, and if B inherited from A, C would also inherit A's members.
```

### 3. Hierarchical Inheritance (Supported)
Multiple child classes inherit from a single parent class.
```dart
class A { ... }
class X extends A { ... }
class Y extends A { ... }
// Both X and Y inherit from A. (e.g., Dog and Cat both inherit from Animal)
```

### 4. Multiple Inheritance (Not Supported Directly)
Multiple inheritance is when a class inherits from more than one parent class. **Dart does NOT support traditional multiple inheritance** using the `extends` keyword. This is to avoid the **"Diamond Problem"**, which creates ambiguity when two parent classes have methods with the same name.

**How Dart Solves This:**
Dart provides alternative ways to achieve similar functionality without the drawbacks:
- **Interfaces (`implements`)**: A class can implement multiple interfaces. When a class implements an interface, it must provide the implementation for all methods defined in that interface.
  ```dart
  class Z extends X implements Y { ... }
  // Z inherits from X, and must implement the structure of Y.
  ```
- **Mixins (`with`)**: Mixins are a way to reuse a class's code in multiple class hierarchies without using traditional inheritance.

### 5. Hybrid Inheritance (Not Supported Directly)
Hybrid inheritance is a combination of two or more types of inheritance. Since it essentially involves multiple inheritance, it is **not supported directly** via `extends`.

**How Dart Solves This:**
Dart achieves hybrid structures by combining inheritance (`extends`), mixins (`with`), and interfaces (`implements`).
```dart
mixin MyMixin {
  void mixinMethod() {
    print("Mixin Method");
  }
}

// HybridClass uses inheritance (extends X), a mixin (with MyMixin), and an interface (implements B)
class HybridClass extends X with MyMixin implements B {
  @override
  void methodB() {
    print("Implemented method from interface B");
  }
}
```

## Summary
- **Inheritance** promotes code reusability by establishing an "is-a" relationship.
- Use **`extends`** for single, multilevel, and hierarchical inheritance.
- Use **`super`** to access parent class members.
- Use **`@override`** to modify inherited method behavior.
- Use **`implements`** (interfaces) and **`with`** (mixins) to safely handle scenarios that would require multiple or hybrid inheritance in other languages.
