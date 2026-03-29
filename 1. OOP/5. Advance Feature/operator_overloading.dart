/*
By default, operators like == and methods like toString() have default behaviors
defined by the base Object class. Overloading allows us to define how these
operators work for our specific custom classes.

The toString() Method
- Default Behavior: Returns "Instance of 'ClassName'".

- Overriding: We override this to provide a meaningful string representation of
the object, which is crucial for debugging and logging.

The == Operator (Equality)
- Reference Equality (Default): Two variables are equal only if they point to the
exact same location in memory.

- Value Equality (Override): We override == to check if two distinct objects
contain the same data.

- The hashCode Rule: If you override == , you must also override hashCode . Equal
objects must have the same hash code.
 */

class Person {
  String name;
  int age;

  Person({this.name = "Unknown", this.age = 0});

  @override
  String toString() {
    return 'Person(name: $name, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    return other is Person && other.name == name && other.age == age;
  }
}

void main() {
  Person person1 = Person();
  Person person2 = Person();
  print(10);
  print(person1.toString());
  print(person1.hashCode);
  print(person2.hashCode);
}
