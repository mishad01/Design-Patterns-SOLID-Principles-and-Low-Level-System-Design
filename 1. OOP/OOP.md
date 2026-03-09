# Object-Oriented Programming (OOP) 

### <span style="color: #69F0AE">Short History of OOP Why Object-Oriented Programming (OOP) Was Introduce</span>


### What is Procedural Programming?

Procedural Programming is a programming style where a program is written as a **series of steps or procedures (functions)**.

The program runs **step by step**, and each function performs a specific task.


### Simple Example:

```dart
// Procedural approach
int age = 25;
String name = "John";

void printUserInfo() {
  print("Name: $name");
  print("Age: $age");
}

void increaseAge() {
  age = age + 1;
}

void main() {
  printUserInfo();
  increaseAge();
  printUserInfo();
}
```

In this approach:
- The main focus is on **procedures/functions**
- Data and functions are usually **separate**
- The program flow moves from **top to bottom**

Example languages:
- C
- Pascal
- Early versions of BASIC


## Problems with Procedural Programming

### 1. **Data is Everywhere (Hard to Track)**
- Variables can be changed by any function at any time
- Difficult to know which function modified your data
- Easy to accidentally modify important data

```dart
// Problem: age can be changed anywhere!
int age = 25;

void wrongFunction() {
  age = -5; // Oops! Now age is negative!
}
```

### 2. **Code is Hard to Reuse**
- Functions are not grouped with their related data
- To use similar functionality, you have to copy and paste code
- Leads to lots of duplicate code

```dart
// For a student user
int studentAge = 20;
void printStudent() { print(studentAge); }

// For a teacher user (similar but separate)
int teacherAge = 40;
void printTeacher() { print(teacherAge); }

// Same logic, but we have to repeat everything!
```

### 3. **Code Gets Messy and Hard to Manage**
- As your project grows, you have hundreds of functions
- Hard to understand which functions work together
- Hard to debug because one function can affect many others

### 4. **No Clear Organization**
- Everything is mixed in one place
- Hard to organize large projects
- Like keeping all your stuff in one big room instead of organized rooms

### 5. **Hard to Extend Features**
- Adding new functionality often requires changing existing code
- Risk of breaking things that already work
- Difficult to add similar variations (like different user types)

Because of these advantages, OOP became widely used in modern programming languages like:

- Java
- C++
- C#
- Python
- Dart


## Why OOP Was Introduced to Fix These Problems

**Object-Oriented Programming (OOP)** packages data and functions together into organized units called **classes** and **objects**.

### How OOP Fixes These Issues:

#### 1. **Data Protection** 
- Data is locked inside objects
- Only specific functions can modify it
- Prevents accidental changes

```dart
// OOP approach
class User {
  int _age = 25; // Private - can't be changed directly!
  String name = "John";
  
  void setAge(int newAge) {
    if (newAge > 0) { // Validation!
      _age = newAge;
    }
  }
}
```

#### 2. **Code Reusability** 
- Create one class, use it for many objects
- No copy-pasting needed
- Shared methods and properties

```dart
// One class, many users
class User {
  int age;
  String name;
  
  void printInfo() { print("$name is $age"); }
}

void main() {
  User student = User(20, "Ali");
  User teacher = User(40, "Fatima");
  
  student.printInfo();
  teacher.printInfo();
}
```

#### 3. **Better Organization** 
- Related data and functions grouped together
- Clear structure and relationships
- Easy to understand what belongs together

#### 4. **Inheritance** 
- Create specialized versions without duplicating code
- Share common features between similar classes
- Easy to extend without breaking existing code

```dart
class User {
  String name;
}

// Student inherits from User - gets name for free!
class Student extends User {
  int studentID;
}
```

#### 5. **Scalability** 
- Easy to add new features
- Easy to create new types of objects
- Code stays organized even in large projects
