import 'transport.dart';
import 'transport_factory.dart';

void main() {
  Transport vehicle = TransportFactory.createTransport('Bus');
  vehicle.deliver();
}
