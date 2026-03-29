// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  String name;
  Person({required this.name});

  String get getName {
    return name;
  }

  set setName(String name) {
    this.name = name;
  }
}

class Employee {
  String _name;
  double _salary;
  // Constructor
  Employee(this._name, this._salary);
  // --- GETTERS (Read Access) ---
  // Getter for name
  String get name => _name;
  // Getter for formatted salary
  String get salaryInfo => "Salary: \$${_salary.toStringAsFixed(2)}";
  // --- SETTERS (Write Access with Validation) ---

  // Setter for salary
  set salary(double newSalary) {
    if (newSalary < 0) {
      print("Error: Salary cannot be negative.");
    } else {
      _salary = newSalary;
      print("Salary updated to $_salary");
    }
  }
}

void main() {
  var emp = Employee("Alice", 50000);
  // Accessing via Getter
  print(emp.salaryInfo); // Output: Salary: $50000.00
  // Accessing via Setter (Valid)
  emp.salary = 55000; // Output: Salary updated to 55000.0
  // Accessing via Setter (Invalid)
  emp.salary = -100; // Output: Error: Salary cannot be negative.
  // NOTE: emp._salary would result in a compile error if accessed
  // from a different file, enforcing encapsulation.
}
