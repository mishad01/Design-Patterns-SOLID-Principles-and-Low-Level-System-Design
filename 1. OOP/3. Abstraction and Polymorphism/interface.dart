//Dart dosent have an interface keyword, we must override every public field
//and method

//When we use implements , we must override every public field and method
//A class can implement multiple interface

class Parent {
  int age = 20;
  String name = "John";

  void testInterface() {
    print("XYZ");
  }
}

class child implements Parent {
  @override
  int age;

  @override
  String name;

  @override
  void testInterface() {
    // TODO: implement testInterface
  }
}
