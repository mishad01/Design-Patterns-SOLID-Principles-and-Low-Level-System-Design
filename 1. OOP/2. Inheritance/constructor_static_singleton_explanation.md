# Constructors, Static Members, and the Singleton Pattern in Dart

Based on the provided `constructor_static_singleton.dart` file, this guide explains the concepts of object instantiation, class-level vs. object-level properties, and how to implement the Singleton design pattern in Dart.

## 1. Object vs. Class Level Properties

In Object-Oriented Programming, data and behavior can exist at two levels: the **object level** (instance level) and the **class level**.

### Object-Level Properties
Object-level properties belong to a specific instance of a class. Changes to these properties only affect that specific instance.
- **Analogy from the code:** "I have two iPhones, one is mine and another one is my brother's. Which software we will be using is an object-level decision." (e.g., you might install different apps).
- In `OldStudent`, the `name` property is an object-level property because every individual `OldStudent` you create will have their own unique name.

### Class-Level Properties (`static`)
Class-level properties belong to the class itself, not to any individual instance. There is only one copy of this property, shared by all instances of the class.
- **Analogy from the code:** "A software update is a class-level update. Both iPhones will get the same update; it will be applied to all instances."
- You define a class-level property using the `static` keyword. For example: `static const String randomValue = "Hello";` inside `OldStudent`. 
- Since it is `static`, it "becomes the same for everyone." You access it using the class name itself (e.g., `OldStudent.randomValue`) rather than an object instance.

## 2. Default Object Creation
By default, creating an object with a standard constructor produces a **brand new instance** in memory every time it is called.
- In `OldStudent(this.name);`, calling `OldStudent("John")` creates a new object. Calling it again creates another separate object, even if you pass the exact same name.
- In the `main` method, `Student student1 = Student();` and `Student student2 = Student();` create two completely different instances in memory. They will not share the same memory location or `hashCode`.

## 3. The Singleton Pattern
The **Singleton Pattern** is a design pattern that restricts the instantiation of a class to exactly **one single instance**. Every time you request an object of that class, it returns that exact same instance instead of creating a new one.

The `Student2` class demonstrates how to properly implement a Singleton in Dart:

### Step A: Private Named Constructor
```dart
Student2._();
```
By creating a private named constructor (the `_` makes it private to the file), you prevent anyone from creating a new instance of `Student2` from outside using the default constructor.

### Step B: Static Instance Variable
```dart
static final Student2 _instance = Student2._();
```
You create a single, `static final` instance of the class internally using that private constructor. This is the one and only instance that will ever exist in memory.

### Step C: Factory Constructor
```dart
factory Student2() {
  return _instance;
}
```
A **`factory` constructor** is a special type of constructor in Dart that doesn't necessarily create a new instance of its class. Instead, it can return an existing instance. 
Here, the `factory Student2()` simply returns the pre-created `_instance`. Whenever a developer writes `Student2()`, they think they are creating a new object, but the factory intercepts this and hands them the exact same shared instance every time.

## 4. Hash Codes and Identity
At the bottom of the `main()` function, there is an experiment with integers and hash codes:
```dart
int a = 10;
int b = 10;
print(a.hashCode == b.hashCode); // true
```
Even though `a` and `b` are separate variables, Dart optimizes primitive immutable types like integers or compile-time strings. Since they hold the exact same value (`10`), they point to the same canonicalized memory instance under the hood, sharing the same `hashCode`. This is computationally different from custom objects (`Student1` vs `Student2`), which get distinct memory spaces unless specifically designed as a Singleton.
