//Observer interface
abstract class Observer {
  void update(double temp);
}

//Subject interface
abstract class Subject {
  void attach(Observer obs);
  void detach(Observer obs);
  void notifyObservers();
}

//Weather Station
class WeatherStation implements Subject { 
  double _temperature = 0;
  final List<Observer> _observerList = [];

  void setTemperature(double temperature) {
    _temperature = temperature;
    notifyObservers();
  }

  @override
  void attach(Observer obs) {
    _observerList.add(obs);
  }

  @override
  void detach(Observer obs) {
    _observerList.remove(obs);
  }

  @override
  void notifyObservers() {
    for (final obs in _observerList) {
      obs.update(_temperature); //Run Time Polymorphism
    }
  }
}

class DisplayDevice implements Observer {
  final String name;

  DisplayDevice(this.name);

  @override
  void update(double temp) {
    print('Temperature on $name device is $temp');
  }
}

class MobileDevice implements Observer {
  @override
  void update(double temp) {
    print('Temperature on Mobile is $temp');
  }
}

void main() {
  //Create a publisher
  WeatherStation weatherStation = WeatherStation();

  //Create subscribers
  DisplayDevice device = DisplayDevice("SamsungLCD"); //Observers
  MobileDevice mobileDevice = MobileDevice();

  //Attach
  weatherStation.attach(device);
  weatherStation.attach(mobileDevice);

  //Set Temp
  weatherStation.setTemperature(25);

  //Detach
  weatherStation.detach(mobileDevice);

  weatherStation.setTemperature(26);
}

/*
- weatherStation.attach(device) adds DisplayDevice to _observerList.

- weatherStation.attach(mobileDevice) adds MobileDevice to the same _observerList.

- When you call weatherStation.setTemperature(25), it sets _temperature and immediately calls notifyObservers().

- notifyObservers() loops through every observer in the list and calls obs.update(_temperature).

- So DisplayDevice.update(25) prints: Temperature on SamsungLCD device is 25.0

- And MobileDevice.update(25) prints: Temperature on Mobile is 25.0

So it prints for both because both are currently attached subscribers.
After detach(mobileDevice), only DisplayDevice remains, so next update prints once.


*/
