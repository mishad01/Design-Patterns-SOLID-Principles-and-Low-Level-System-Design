import 'transportation_mode.dart';

class Walking extends TransportationMode {
  @override
  int calculateEta() {
    print('Calculating ETA walking');
    return 10; //Example Eta for walking
  }

  @override
  String getDirection() {
    return 'Directions for walking';
  }
}
