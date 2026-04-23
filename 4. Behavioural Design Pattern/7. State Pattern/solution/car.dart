import 'transportation_mode.dart';

class Car extends TransportationMode {
  @override
  int calculateEta() {
    print('Calculating ETA Car');
    return 10; //Example Eta for walking
  }

  @override
  String getDirection() {
    return 'Directions for car';
  }
}
