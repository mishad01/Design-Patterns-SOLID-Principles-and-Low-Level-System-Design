class Animal {
  // And also if there is not contructor, there is a default constructor that is created by the compiler.
  //And also it is called 0 argument constructor because it does not take any parameters.
  int age = 0;
  void eat() {
    print("Animal is eating");
  }
}

// class Dog extends Animal {
//   void bark() {
//     print("Dog is barking");
//   }
// }
//Is a rule. when we create a class that inherits from another class, it is called "is a" relationship.
// In this case, Dog "is a" Animal, because it inherits properties and behaviors from the Animal class.

//Super indicates parent class. It is used to refer to the parent class and access its properties and methods.
// In this example, we can use super to call the eat() method from the Animal class if we want to override it in the Dog class.

class Dog extends Animal {
  void bark() {
    print("Dog is barking");
  }

  @override
  void eat() {
    super.eat(); // Call the eat method from the Animal class
    print("Dog is eating"); // Additional behavior for Dog
  }

  String test() {
    return "This is a test method in Dog class";
  }
}

class Cat extends Animal {
  void meow() {
    print("Cat is meowing");
  }
}

//Single Inheritance: (Supported in Dart)
class A {
  void methodA() {
    print("Method A");
  }
}

class B {
  void methodB() {
    print("Method B");
  }
}

//Multilevel Inheritance: (Supported in Dart)
class C extends B {
  void methodC() {
    print("Method C");
  }
}

//Hierarchical Inheritance: (Supported in Dart)
class X extends A {}

class Y extends A {}

//Multiple Inheritance: (Not supported in Dart using `extends`)
// Dart does not support traditional multiple inheritance (extending multiple classes) to avoid the "Diamond Problem"
// (ambiguity when two parent classes have the same method).
// How Dart solves this:
// 1. Interfaces (`implements`): A class can implement multiple interfaces, forcing the child class to provide the implementation.
// 2. Mixins (`with`): A way to reuse code across multiple class hierarchies without using inheritance.
class Z extends X
    implements Y {} // Y acts as an interface here, not as a parent class.

//Hybrid Inheritance: (Not supported directly)
// A combination of more than one type of inheritance. Since it involves multiple inheritance, it's not supported via `extends`.
// How Dart solves this: By combining `extends`, `with` (mixins), and `implements` (interfaces).
mixin MyMixin {
  void mixinMethod() {
    print("Mixin Method");
  }
}

class HybridClass extends X with MyMixin implements B {
  @override
  void methodB() {
    print("Implemented method from interface B");
  }
}

void main() {
  Dog dog = Dog();
  dog.age = 3; // Inherited property from Animal
  print("Dog's age: ${dog.age}");
  // dog.eat(); // Inherited method from Animal
  // dog.bark(); // Dog's own method

  //dog.test();
  //print("Dog's name: ${dog.test()}");
}
