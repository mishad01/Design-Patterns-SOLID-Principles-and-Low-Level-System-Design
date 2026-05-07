import 'transport.dart';

class Car extends Transport {
  @override
  void deliver() {
    print('Delivering by car');
  }
}
