# Class and Object in Dart

Based on the provided `class_and_object.dart` file, this guide breaks down the core Object-Oriented Programming (OOP) concepts demonstrated in the code.

## 1. Class
A **Class** is essentially a blueprint or template. It defines the structure, properties (the data it will hold), and behaviors (what it can do) for any object created from it.
- In the code, `Student` is a class that groups information and behaviors related to a student.
- By wrapping data and methods in a class, it solves problems found in procedural programming: it keeps everything in a specific scope, organizes related code, and improves data integrity by preventing arbitrary external modifications.

## 2. Object and Instance
An **Object** is a specific realization or instance of a class. When you create an object, you are building a concrete entity out of the class "blueprint" with its own unique values.
- **Instance vs. Object**: An object refers to the concept being created (e.g., a student). An instance refers to the physical memory location where that object's data is stored.
- **Analogy**: Just like "Nabil" and "Abid" are both students, they are different objects with distinct names and might be in different classrooms (instances/memory locations).

## 3. Constructors
A **Constructor** is a special method invoked when an object is created. Its main purpose is to initialize the class fields with the correct data. The code demonstrates two types of constructors in Dart:
- **Default Constructor**: `Student(...)` initializes the core properties. It uses an initializer list (`: visa = null`) to explicitly set the `visa` property to null for students who don't have one initially.
- **Named Constructor**: `Student.withVisa(...)` is an alternative way to create an object when you specifically want or need to provide visa information. Named constructors are very useful in Dart since a class can only have one unnamed/default constructor.

## 4. The `this` Keyword
The `this` keyword refers to the current instance of the class. 
- When we use `this.name`, we are explicitly telling Dart: "Use the `name` property of *this particular object* we are creating or working with."
- If we are operating on `student1`, `this` refers to `student1`. If we are operating on `xavir`, `this` refers to `xavir`.

## 5. Properties (Data)
The properties are variables defined inside the class representing its attributes.
- The `Student` class has properties like `name`, `roll`, `classNo`, `emergencyContact`, `bloodGroup`, and `visa`.
- The `final` keyword is used, meaning once these properties are initialized via the constructor, they cannot be changed. This is a good practice for data safety and immutability.
- The `visa` property is a nullable string (`String?`), meaning it can either hold a string value or be inherently `null`.

## 6. Methods (Behaviors / Actions)
Methods are functions defined inside a class that operate on the object's data.
- **`getStudentInfo()`**: Returns a formatted string containing all the properties of the given student. It handles the nullable `visa` property gracefully by providing a fallback (`Not Available`) using the `??` operator if it is null.
- **`getStudentName()`**: A simple method that specifically returns the name of the student.

## 7. Execution (`main` method)
The `main()` function is the entry point of the Dart program. Here, objects are actually brought to life:
- `student1` is instantiated using the default constructor.
- `xavir` is instantiated using the named constructor `Student.withVisa`.
- Finally, the behaviors are verified by printing their outputs (`print(student1.getStudentInfo())` and `print(xavir.getStudentInfo())`).

---
**Summary:**
This file serves as a fundamental introduction to OOP in Dart, demonstrating how compiling data (properties) and actions (methods) into a unified unit (a class) makes code more organized, secure, and easier to reason about when creating multiple distinct entities (objects).
