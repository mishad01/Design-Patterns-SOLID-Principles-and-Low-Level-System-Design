enum TransportType { car, bike, bus }

abstract class Transport {
  void deliver();

  factory Transport.create(TransportType type) {
    switch (type) {
      case TransportType.car:
        return Car();
      case TransportType.bike:
        return Bike();
      case TransportType.bus:
        return Bus();
    }
  }
}

class Car implements Transport {
  @override
  void deliver() => print('Deliver by Car');
}

class Bike implements Transport {
  @override
  void deliver() => print('Deliver by Bike');
}

class Bus implements Transport {
  @override
  void deliver() => print('Deliver by Bus');
}

void main() {
  final vehicle = Transport.create(TransportType.bus);
  vehicle.deliver();
}
