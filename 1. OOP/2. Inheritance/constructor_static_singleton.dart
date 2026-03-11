class Student {}

class Student2 {
  //Singleton
  Student2._(); //Priveate named constructor
  static final Student2 _instance = Student2._();
  //One class have two tyoes of property
  //One is in object level and another one is in class level
  //If anything happend in class level, then its true for all instance

  //I have two iphone one is mine and another one is my brothers. now which software will
  // we be using that is object level decison
  //Now in both iphones software update is class level update. both of the iphone
  //will get the same update, in it will be apply to all instance

  //if we use static then it goes in class level and it becomes same for everyone

  factory Student2() {
    return _instance;
  }
}

class OldStudent {
  OldStudent(this.name); //Default behavior - creates a anew instance everytime
  //if we use static then it goes in class level and it becomes same for everyone
  final String name;
  static const String randomValue = "Hello";
}

void main() {
  Student student1 = Student();
  Student student2 = Student();

  OldStudent oldStuendt = OldStudent('name');
  OldStudent oldStudent2 = OldStudent("name2");
  print(oldStudent2.name);
  print(
    oldStudent2.randomValue,
  ); //we get errror here because random is on class level
  //WE CANT ACCESS THE RANDOM BY CREATING OBJECT BECASE ITS IN CLASS level

  print(OldStudent.randomValue); //But we can access using this

  // print(student1.hashCode == student2.hashCode);

  int a = 10;
  int b = 10;
  print(a.hashCode == b.hashCode);
  print(a.hashCode);
  print(b.hashCode);
}
