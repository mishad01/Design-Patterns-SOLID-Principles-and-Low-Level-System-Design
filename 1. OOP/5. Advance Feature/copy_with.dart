/*
2. Copy Constructor Concept (copyWith)
Cloning Objects & Immutability
In modern Dart, instead of a traditional "copy constructor," we typically use a
copyWith instance method. This is essential for Immutable objects (where fields are
final ). Since you cannot change the fields of an existing object, you create a new
object based on the old one, changing only specific properties.

- Immutability: Fields are final and cannot be changed after the object is
created.
- The copyWith Pattern: A method that takes optional named parameters for
every field. If a parameter is provided, it uses the new value; otherwise, it falls
back to the existing value ( this.value ).


Why is this crucial for Flutter State Management?
In Flutter (and libraries like Bloc, Riverpod, or Redux), state is often immutable to
ensure performance and predictability.

1. Efficient Rebuilds: Flutter needs to know when to rebuild the UI. Comparing
memory addresses (Identity) is instant, while checking every field of a large
object (Deep Equality) is slow.

2. The Trigger: If you mutate an object in place ( user.age = 26 ), the object
reference remains the same. The framework looks at the old and new state,
sees the same memory reference, and assumes nothing changed, resulting in
the UI not updating.

3. The Solution: Using copyWith creates a completely new instance (new memory
reference). The framework sees oldState != newState and immediately knows to
trigger a rebuild.
 */

// class Person {
//   final int? age;
//   final String? name;

//   Person({this.age, this.name});
// }
class Person {
  final int? _age;
  final String? _name;

  Person({String? name, int? age}) : _name = name, _age = age;
  String get name => _name ?? "Unknown";
  int get age => _age ?? 0;
  //I want even If I give null to name and age, it should not be null.
  //It should give me previous value or default value.

  Person copyWith({String? newName, int? newAge}) {
    return Person(name: newName ?? this._name, age: newAge ?? this._age);
  }

  String greetings({String? name, int? age}) {
    return "Hello ${name ?? this.name}, you are ${age ?? this.age} years old.";
  }
}

void main() {
  Person person = Person(age: 25, name: "sakif");
  print(person.name);
  print(person.age);
  // person = Person(age: 21);
  // print(person.name);
  // print(person.age);
  //person.name = "sakif";
  //I want even If I give null to name and age, it should not be null.
  //It should give me previous value or default value.
  person = person.copyWith(newAge: 22);
  print(person.name);
  print(person.age);
}
