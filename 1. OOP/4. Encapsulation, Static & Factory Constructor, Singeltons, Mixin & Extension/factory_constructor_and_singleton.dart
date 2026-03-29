//Factory Constructor
/*
Unlike a normal constructor, a factory constructor in Dart does not necessarily
create a new instance of the class. 

The factory Keyword
Return Existing: Can return an instance from a cache.
Return Subclass: Can return an instance of a derived class (polymorphism).
Singleton: Essential for implementing the Singleton pattern

*/

class Database {
  // 1. Private static instance variable
  static final Database _instance = Database._internal();

  // 2. Private named constructor
  Database._internal();

  //3. Factory constructor returns the same static instance
  factory Database() {
    return _instance;
  }
}

class Database2 {
  //Database2();
  factory Database2() {
    return _instance;
  }

  static final Database2 _instance = Database2._internal();

  Database2._internal();
}

void main() {
  var db1 = Database();
  var db2 = Database();
  print("db1 and db2 are the same instance: ${identical(db1, db2)}");
}
