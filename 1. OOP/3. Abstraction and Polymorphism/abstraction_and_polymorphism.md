# Abstraction & Polymorphism in Dart

Two of the four pillars of Object-Oriented Programming (OOP). Together they allow you to **hide complexity** and **write flexible, extensible code**.

---

## 1. Abstraction

Abstraction means **hiding internal implementation details** and exposing only the essential features of an object. It lets you define *what* something does without saying *how* it does it.

### Why Abstraction?
- Reduces complexity for the caller.
- Forces a contract — any class that builds on an abstract type must fulfil the required behaviour.
- Makes it easy to swap implementations without touching calling code.

---

### 1a. Abstract Classes

An abstract class is declared with the `abstract` keyword. It **cannot be instantiated** directly; it can only be subclassed.

An abstract class can contain:
| Method Type | Has Body? | Description |
|---|---|---|
| **Concrete Method** | ✅ Yes | Shared, reusable logic for all subclasses |
| **Abstract Method** | ❌ No | A contract — subclasses *must* override it |

```dart
// abstract.dart
abstract class Parent {
  // Concrete method — has a body (Partial / Shared Implementation)
  void regularMethod() {
    print('XYZ');
  }

  // Abstract method — no body (forces child to implement)
  String testAbstract();
}

class Child extends Parent {
  @override
  String testAbstract() {
    return "Implemented in Child";
  }
}

void main() {
  // ❌ Cannot instantiate an abstract class
  // Parent parent = Parent(); // ERROR

  // ✅ Must use a concrete subclass
  Child c = Child();
  c.regularMethod();   // XYZ (inherited concrete method)
  c.testAbstract();    // Implemented in Child
}
```

> **Key Rule:** Any non-abstract subclass of an abstract class **must** override all abstract methods; otherwise, Dart throws a compile-time error.

---

### 1b. Interfaces in Dart

Dart has **no dedicated `interface` keyword**. Instead, *every class implicitly defines an interface*. When a class uses `implements`, it must override **every public field and method** of the implemented class/interface.

```dart
// interface.dart
class Parent {
  int age = 20;
  String name = "John";

  void testInterface() {
    print("XYZ");
  }
}

// 'child' must re-implement all public fields and methods of Parent
class child implements Parent {
  @override
  int get age => 2;       // fields become getters

  @override
  String name = "Jane";

  @override
  void testInterface() {
    print("child implementation");
  }
}
```

> **Important:** When using `implements`, you do **not** inherit the *implementation* — only the *shape* (contract). You must write every method body yourself.

#### `abstract interface class` — Formal Interface

Dart 3 introduced the `abstract interface class` modifier combination. This is a clean way to declare a pure contract (no concrete methods):

```dart
// abstract.dart
abstract interface class ITest {
  int age;
  String name;
  String testAbstract();
}

class child2 implements ITest {
  @override
  int age;

  @override
  String name;

  child2(this.age, this.name);

  @override
  String testAbstract() => "child2 implementation";
}
```

---

### `extends` vs `implements` — Quick Comparison

| Feature | `extends` (Inheritance) | `implements` (Interface) |
|---|---|---|
| **Inherits implementation** | ✅ Yes | ❌ No (must re-implement) |
| **Inherits fields as-is** | ✅ Yes | ❌ Must override |
| **Multiple allowed** | ❌ Only one parent | ✅ Multiple interfaces |
| **Use case** | Reuse & extend behaviour | Define & enforce a contract |

```dart
// A class can extend ONE class and implement MULTIPLE interfaces
class MyClass extends SomeBase implements InterfaceA, InterfaceB {
  // must override everything from InterfaceA and InterfaceB
}
```

---

### 1c. Mixins — Reusable Behaviour Without Inheritance

Mixins allow you to share code across unrelated class hierarchies using the `with` keyword.

```dart
mixin Flyable {
  void fly() => print("Flying!");
}

mixin Swimmable {
  void swim() => print("Swimming!");
}

class Duck extends Animal with Flyable, Swimmable {}

void main() {
  Duck d = Duck();
  d.fly();    // Flying!
  d.swim();   // Swimming!
}
```

> Mixins solve the **multiple-behaviour** problem without the ambiguity of multiple inheritance.

---

## 2. Polymorphism

Polymorphism (Greek: "many forms") allows **objects of different classes to be treated as objects of a common supertype**. The correct method is selected based on the *actual* object at runtime or at compile time.

```dart
// polymorphism.dart
class Animal {}
class Dog extends Animal {}
class Cat extends Animal {}

Animal myDog = Dog(); // A Dog IS-AN Animal
Animal myCat = Cat(); // A Cat IS-AN Animal

List<Animal> animals = [Dog(), Cat()]; // treat both uniformly
```

---

### 2a. Compile-time Polymorphism (Static Binding)

The method to call is resolved **at compile time**.

In most OOP languages this is achieved via **method overloading** (same name, different parameter lists). **Dart does NOT support traditional method overloading.**

**The Dart way:** Use **optional** and **named parameters** to achieve the same flexibility.

```dart
// polymorphism.dart
class Printer {
  void printData(String data, {bool isBold = false, String? prefix}) {
    String output = data;
    if (prefix != null) output = "$prefix $output";
    if (isBold) output = "**$output**";
    print(output);
  }
}

void main() {
  var p = Printer();
  p.printData("Hello");                      // Form 1 → Hello
  p.printData("Hello", isBold: true);        // Form 2 → **Hello**
  p.printData("Hello", prefix: ">>>");       // Form 3 → >>> Hello
}
```

> This is Dart's idiomatic substitute for method overloading.

---

### 2b. Runtime Polymorphism (Dynamic Binding)

The method to call is resolved **at runtime**, based on the *actual* type of the object (not the declared type of the variable).

This is achieved via **Method Overriding** — a subclass provides its own implementation of a method declared in a parent class.

```dart
// polymorphism.dart
abstract class Shape {
  void draw(); // abstract — no implementation
}

class Circle extends Shape {
  @override
  void draw() => print("Drawing Circle");
}

class Square extends Shape {
  @override
  void draw() => print("Drawing Square");
}

void renderShapes(List<Shape> shapes) {
  for (var shape in shapes) {
    // At runtime, Dart checks the actual type and calls the right draw()
    shape.draw();
  }
}

void main() {
  renderShapes([Circle(), Square()]);
  // Output:
  // Drawing Circle
  // Drawing Square
}
```

**How it works:**
1. `renderShapes` accepts `List<Shape>` — it only knows about `Shape`.
2. At runtime, each element is checked: is it a `Circle`? Is it a `Square`?
3. The correct overridden `draw()` is called — this is **dynamic dispatch**.

---

### `@override` and Annotations Explained

```dart
// From polymorphism.dart comments
@override
void draw() => print("Drawing Circle");
```

| Concept | Explanation |
|---|---|
| `@override` | An **annotation** telling the Dart analyser this method intentionally replaces the parent's method |
| `@` symbol | Prefix for all annotations in Dart |
| Annotation | Metadata about code — doesn't change runtime behaviour but guides the compiler/analyser |

> In Flutter, `@override` is used constantly — every custom Widget overrides the `build()` method.

---

### Compile-time vs Runtime Polymorphism — Summary

| | Compile-time | Runtime |
|---|---|---|
| **Also called** | Static binding | Dynamic binding |
| **Resolved** | At compile time | At runtime |
| **Mechanism** | Named/optional parameters (Dart's way) | Method overriding (`@override`) |
| **Requires** | Single class with flexible params | Inheritance or `implements` |
| **Example** | `printData("Hi", isBold: true)` | `shape.draw()` on a list of shapes |

---

## 3. Abstract Class vs Interface vs Mixin — When to Use Which

| | Abstract Class | Interface (`implements`) | Mixin (`with`) |
|---|---|---|---|
| **Purpose** | Partial blueprint with shared logic | Pure contract / shape | Reusable behaviour across hierarchies |
| **Can have concrete methods** | ✅ Yes | ❌ No (unless default) | ✅ Yes |
| **Can be instantiated** | ❌ No | ❌ No | ❌ No |
| **Multiple allowed** | ❌ One only (`extends`) | ✅ Yes | ✅ Yes |
| **Inherit implementation** | ✅ Yes | ❌ No | ✅ Yes |
| **Use when** | Sharing default behaviour + enforcing contract | Enforcing a contract on unrelated classes | Adding capabilities to multiple class trees |

---

## 4. Real-World Example — Putting It All Together

```dart
abstract class Vehicle {
  String brand;
  Vehicle(this.brand);

  // Concrete method — shared
  void startEngine() => print("$brand engine started");

  // Abstract method — each vehicle implements differently
  void fuelType();
}

mixin Electric {
  void charge() => print("Charging battery...");
}

class Tesla extends Vehicle with Electric {
  Tesla() : super("Tesla");

  @override
  void fuelType() => print("Tesla runs on electricity");
}

class Toyota extends Vehicle {
  Toyota() : super("Toyota");

  @override
  void fuelType() => print("Toyota runs on petrol");
}

void main() {
  List<Vehicle> fleet = [Tesla(), Toyota()];

  for (var v in fleet) {
    v.startEngine(); // Runtime polymorphism
    v.fuelType();    // Runtime polymorphism
  }

  Tesla t = Tesla();
  t.charge(); // Mixin method
}
```

---

## Summary

- **Abstraction** hides implementation complexity behind a contract.
- Use **`abstract class`** when you want to share some logic AND enforce a contract.
- Use **`implements`** (interface) when you only want to enforce a contract without sharing logic.
- Use **`mixin`** (`with`) when you want to share behaviour across unrelated class hierarchies.
- **Polymorphism** lets different types be used interchangeably through a common supertype.
- **Compile-time polymorphism** in Dart = named/optional parameters (no overloading).
- **Runtime polymorphism** = method overriding (`@override`) + dynamic dispatch.
- `@override` is an annotation — metadata that guides the Dart analyser, not the runtime.
