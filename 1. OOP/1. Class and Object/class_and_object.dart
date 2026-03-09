/*
Class:
A class is a blueprint or template for creating objects.
It defines the structure or properties (attributes) and behaviors (methods) that the objects created from the class will have.

Object:
An object is an instance of a class, which means it is a specific realization of
the class with its own unique set of values for the properties defined in the class.

*/

class Student {
  //Constructor
  // -> From Student template we will create a student object. And for creating that object we need to pass some data.
  // So for that we will use constructor. It basically helps us to construct the object.
  //Constuctor is a special method that is called when an object is created. It is used to initialize the properties of the object.
  Student({
    //Default constructor
    required this.name,
    required this.roll,
    required this.classNo,
    required this.emergencyContact,
    required this.bloodGroup,
  }) : visa = null;

  //this referes to the current instance of the class. It is used to access the properties and methods of the class.
  //Which means if I am indicating student 1 or student 2 then this will refer to that particular student.
  // So if I am indicating student 1 then this will refer to student 1 and if I am indicating student 2 then this will refer to student 2.

  Student.withVisa({
    //This one is named constructor
    required this.name,
    required this.roll,
    required this.classNo,
    required this.emergencyContact,
    required this.bloodGroup,
    required this.visa,
  });

  //Data
  final String name;
  final int roll;
  final String classNo;
  final String emergencyContact;
  final String bloodGroup;
  final String? visa;

  //Actions / Behaviors
  String getStudentInfo() {
    return "Name: $name, Roll: $roll, Class: $classNo, Emergency Contact: $emergencyContact, Blood Group: $bloodGroup, Visa: ${visa ?? 'Not Available'}";
  }

  String getStudentName() {
    return name;
  }
}

/*
So this class solve few procedual programming proble 
-> Data nad method are inside a scope even after in a same file and if we dont access using that scope we cant access it.
So we have grouped data and method 

-> Differnet method cant change the data, so it ensures data integrity and security.
*/

void main() {
  Student student1 = Student(
    name: "John Doe",
    roll: 1,
    classNo: "10A",
    emergencyContact: "1234567890",
    bloodGroup: "A+",
  );

  Student xavir = Student.withVisa(
    name: "Xavir",
    roll: 2,
    classNo: "10B",
    emergencyContact: "0987654321",
    bloodGroup: "B+",
    visa: "Student Visa",
  );

  /* Here Student() is object of class Student.
  // And Instance is in which memory location it is stored
  // Abid a student, Nabil is a student. But they are different objects as they have
   different name. And where in which classroom we will find them is also different.
    We can find one of them at class 6 and another one in class 8 , so here class 6 and 8 is refering different place and that kinda the instance.*/

  print(student1.getStudentInfo());
  print(xavir.getStudentInfo());
}
