import 'transportation_mode.dart';

class DirectionService {
  TransportationMode transportationMode;

  DirectionService({required this.transportationMode});

  void setTransportationMood(TransportationMode mode) {
    this.transportationMode = mode;
  }

  //Delegating the work current state's concrete class
  int getEta() {
    return transportationMode.calculateEta();
  }

  String getDirection() {
    return transportationMode.getDirection();
  }
}
