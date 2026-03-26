class Animal {}

class Dog extends Animal {}

class Cat extends Animal {}

class Printer {
  // Dart style "Overloading"
  void printData(String data, {bool isBold = false, String? prefix}) {
    String output = data;
    if (prefix != null) output = "$prefix $output";
    if (isBold) output = "**$output**";

    print(output);
  }
}

abstract class Shape {
  void draw();
}

class Circle extends Shape {
  /**
   1. What @override means in Dart ? 
    Just like in Java, @override is an annotation. It tells the Dart analyzer that the method you are defining is intended to replace a method with the same name in a parent class (superclass).
    In Dart, overriding is extremely common because of Flutter. Every time you create a widget, you override the build method.

  2. What does the @ mean?
    In Dart, the @ symbol is the prefix used for Annotations.
    Annotations are a way to add metadata to your code.
    They don't change what the code does directly, but they provide extra information to the compiler, the analyzer, or even code-generation tools.

  3. In the simplest terms, metadata is data about data.
    It is the behind-the-scenes information that describes, explains, or locates other data to make it easier to retrieve, use,
    or manage. You encounter metadata every single day, even if you don't realize it.
  **/
  @override
  void draw() => print("Drawing Circle");
}

class Square extends Shape {
  @override
  void draw() => print("Drawing Square");
}

void renderShapes(List<Shape> shapes) {
  for (var shape in shapes) {
    // Runtime Polymorphism:
    // The runtime checks if 'shape' is actually a Circle or Square
    // and calls the correct draw() method.
    shape.draw();
  }
}

void main() {
  //Polymorphism allows object of different classes to be treated as objects of a common supper class
  Animal myDog = Dog();
  Animal myCat = Cat();

  List<Animal> animal = [Dog(), Cat()];

  // A. Compile-time Polymorphism (Static Binding)
  // In many languages, this is achieved via Method Overloading (same method name,
  // different parameters).

  // Crucial Note: Dart does not support traditional Method Overloading.
  // The Dart Way: Dart achieves compile-time flexibility through Optional and
  // Named parameters.

  var p = Printer();
  p.printData("Hello"); // Form 1
  p.printData("Hello", isBold: true); // Form 2
  p.printData("Hello", prefix: ">>>"); // Form 3

  //   B. Runtime Polymorphism (Dynamic Binding)
  // This is achieved via Method Overriding. The runtime environment determines
  // which method to call based on the actual object type, not the variable type.

  // Requires: Inheritance ( extends ) or Implementation ( implements ).

  // Mechanism: The parent reference holds a child object.

  // Use Case: Handling a collection of different objects uniformly.
}
