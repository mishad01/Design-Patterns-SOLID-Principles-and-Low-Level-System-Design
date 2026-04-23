import '../solution/direction_service.dart';
import 'car.dart';
import 'cycling.dart';

void main() {
  //Here the direction service is the context.
  DirectionService service = DirectionService(transportationMode: Car());
  service.setTransportationMood(Cycling());

  print('Eta: ${service.getEta()}');
  print('Direction: ${service.getDirection()}');
}

/*
State Pattern: Structure
Structure:
● Context: Holds a reference to the current state.
● State: Interface for state-specific behavior.
● Concrete State: Specific implementations of the State interface that
represent a particular state of the context object. */
