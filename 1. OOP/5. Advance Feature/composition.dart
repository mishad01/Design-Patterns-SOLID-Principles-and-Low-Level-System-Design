/*
Composition is the design principle where a class contains objects of other
classes as member variables.

In shortuct -> Inside a class there is another class object.
It is a "has-a" relationship. For example, a Car has an Engine.

 Composition vs. Inheritance
Inheritance (Is-A): Car is a Vehicle . Good for hierarchy.
Composition (Has-A): Car has an Engine . Good for building complex objects
from smaller, reusable components.
Why prefer Composition?
Flexibility: You can easily swap components (e.g., change the Engine type
inside a Car ) at runtime.
Loose Coupling: Changes in the component class don't ripple through a
hierarchy as strictly as inheritance.
 */

import 'operator_overloading.dart';

class Nationality {
  final String country;
  Nationality(this.country);
}

class Person {
  final String name;
  final int age;
  final Nationality nationality;
  Person({required this.name, required this.age, required this.nationality});
}

class Engine {
  final String type;
  Engine(this.type);
}

class Car {
  final String model;
  final Engine engine;
  Car({required this.model, required this.engine});
}
