import 'bike.dart';
import 'bus.dart';
import 'car.dart';
import 'transport.dart';

class TransportFactory {
  static Transport createTransport(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return Car();
      case 'bike':
        return Bike();
      case 'bus':
        return Bus();
      default:
        throw Exception();
    }
  }
}
