/*
   Extensions in Dart
   -------------------
   Extensions allow you to add new functionality (methods, getters, setters, operators)
   to existing types (even types you don't own, like SDK types or third-party classes)
   without subclassing them or modifying their original code.
*/

// 1. Extending a built-in type (String) with methods
extension StringEdcxgdfgdfgdfgxtension on String {
  // Adding a method to convert String to int
  int toInt() {
    // 'this' refers to the string instance calling the method
    return int.parse(this);
  }

  // Adding a method to capitalize the first letter
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

// 2. Extending with Getters and Setters
// You can also add getters and setters via extensions!
extension IntExtension on int {
  // A getter to check if an integer is an even number
  bool get isEvenNumber => this % 2 == 0;

  // A getter to represent the current number as a currency string
  String get toPrice => "\$${toStringAsFixed(2)}";
}

// 3. Extending Collections (Generics)
extension ListExtension<T> on List<T> {
  // A safe way to get an element at an index (returns null if out of bounds)
  T? getSafe(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  // Method to print all items easily
  void printAll() {
    for (var item in this) {
      print("- $item");
    }
  }
}

// 4. Extending Custom Classes
class User {
  String username;
  User(this.username);
}

// If we want to add a sayHello method without modifying the User class directly:
extension UserExtension on User {
  void sayHello() {
    print("Welcome, $username!");
  }
}

void main() {
  print("--- 1. String Extensions ---");
  String numberStr = '123456';
  print(numberStr.toInt());
  //print("String '$numberStr' to int: ${numberStr.toInt()}");

  String name = "sakif";
  print(name.capitalizeFirstLetter());
  print("Capitalized Name: ${name.capitalizeFirstLetter()}");

  print("\n--- 2. Integer Extensions (Getters) ---");
  int price = 500;
  print("Formatted Price: ${price.toPrice}");
  print("Is $price even? ${price.isEvenNumber}");

  print("\n--- 3. List/Generic Extensions ---");
  List<String> fruits = ["Apple", "Banana", "Mango"];
  fruits.printAll();

  print("Safe access index 1: ${fruits.getSafe(1)}"); // Banana
  print("Safe access index 5: ${fruits.getSafe(5)}"); // null (No error thrown!)

  print("\n--- 4. Custom Class Extensions ---");
  User myUser = User("Sakif");
  myUser.sayHello(); // Output: Welcome, Sakif!
}
