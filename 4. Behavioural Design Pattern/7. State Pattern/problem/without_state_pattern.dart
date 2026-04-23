import 'direction_service.dart';

void main() {
  DirectionService directionService = DirectionService(TransportationMode.CAR);
  directionService.setMode(TransportationMode.CYCLING);
  print(directionService.getDirection());
  print(directionService.getEta());
}


/*
Tight Coupling and Complex Conditional Logic:
● The DirectionService likely uses conditional statements (if-else or switch-case) based
on transportation mode enums to determine how to calculate ETA and provide directions.
● As the number of transportation modes increases, the conditional logic becomes more complex
and harder to maintain.
Violation of the Open/Closed Principle:
● Adding new transportation modes (e.g., Airplane, Boat) requires modifying the existing
DirectionService class, which goes against the Open/Closed Principle (classes should be
open for extension but closed for modification).

Code Duplication and Reduced Maintainability:
● Similar code blocks for different transportation modes may lead to code duplication, making the
system less maintainable and more error-prone.
Scalability Issues:
● As more features or transportation modes are added, the class becomes bulky, impacting scalability
and readability.
 */