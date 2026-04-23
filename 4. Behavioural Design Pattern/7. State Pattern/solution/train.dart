import 'transportation_mode.dart';

class Train extends TransportationMode {
  @override
  int calculateEta() {
    print('Calculating ETA train');
    return 10; //Example Eta for walking
  }

  @override
  String getDirection() {
    return 'Directions for train';
  }
}
