//Static members belong to the class itself rather than to any specific object instance.
/* Core Concepts
   Class-Level vs. Instance-Level: You do not need to create an object (using
   new ) to access static members.

   Memory Efficiency: There is only one copy of a static variable in memory,
   shared by all instances of that class.

   Utility Methods: Perfect for helper functions that don't need to access the
   state of a specific object (e.g., Math.sqrt() ).
   
   Access: Accessed using the class name directly: ClassName.variable .*/
class Constants {
  // Shared by all instances

  static double pi = 3.14159;
  static double calculateArea(double r) {
    return pi * r * r;
  }
}

void main() {
  print("Constants.pi: ${Constants.pi}");
  print("Area with radius 5: ${Constants.calculateArea(5)}");
}
