enum TransportationMode { CAR, WALKING, TRAIN, CYCLING }

class DirectionService {
  DirectionService(this._mode);
  TransportationMode _mode;

  void setMode(TransportationMode mode) {
    _mode = mode;
  }

  //Method to calculate ETA (Estimated Time of Arrival) based on the transportation mode

  int getEta() {
    switch (_mode) {
      case TransportationMode.CAR:
        print('Calculating ETA for car 30 minutes');
        return 30; // ETA in minutes for car
      case TransportationMode.WALKING:
        print('Calculating ETA for walking 60 minutes');
        return 60; // ETA in minutes for walking
      case TransportationMode.TRAIN:
        print('Calculating ETA for train 20 minutes');
        return 20; // ETA in minutes for train
      case TransportationMode.CYCLING:
        print('Calculating ETA for cycling 40 minutes');
        return 40; // ETA in minutes for cycling
    }
  }

  String getDirection() {
    switch (_mode) {
      case TransportationMode.CAR:
        return 'Directions for car : Take the highway and exit at Main Street';
      case TransportationMode.WALKING:
        return 'Directions for walking : Head north for 500 meters.';
      case TransportationMode.TRAIN:
        return 'Directions for train : Take the train from Platform 1.';
      case TransportationMode.CYCLING:
        return 'Directions for cycling : Follow the bike lane to the destination.';
    }
  }
}
