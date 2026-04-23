import 'transportation_mode.dart';

class Cycling extends TransportationMode {
  @override
  int calculateEta() {
    print('Calculating ETA Cycling');
    return 5;
  }

  @override
  String getDirection() {
    return 'Directions for Cycling';
  }
}
