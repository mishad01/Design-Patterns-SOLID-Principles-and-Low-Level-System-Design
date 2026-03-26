//Abstract class have two type of methods
// Which Have body and partial Implementation -> Concrete Method
// Other is which dosent have any body -> Abstract Method
abstract class Parent {
  //Implementation
  void regularMethod() {
    print('XYZ');
  }

  //No implementation
  String testAbstract();
}

class Child extends Parent {
  @override
  String testAbstract() {
    // TODO: implement testAbstract
    throw UnimplementedError();
  }
}

abstract interface class test {
  int age;
  String name;
  String testAbstract();
}

class child2 implements test {
  @override
  int age;

  @override
  String name;

  @override
  String testAbstract() {
    // TODO: implement testAbstract
    throw UnimplementedError();
  }
}

void main() {
  Parent parent = Parent(); //We cant create object ob an abstract class
}
