class DisplayDevice {
  void showTemp(double temp) {
    print('Current temparature : $temp + C');
  }
}

class WeatherStation {
  double temparature = 0;

  // ISSUE 1: TIGHT COUPLING
  // WeatherStation is strictly tied to "DisplayDevice".
  // It only knows about this specific class, not any other devices.
  DisplayDevice? displayDevice;

  // Right now i have single device but there can be mutiple display device.
  // ISSUE 2: VERY HARD TO ADD NEW DEVICES
  // If we want to add a "TVDevice", we must change this whole class.
  // We would need to add new variables and update this constructor.
  WeatherStation(DisplayDevice device) {
    this.displayDevice = device;
  }

  void setTemparature(double temparature) {
    this.temparature = temparature;
  }

  void notifyDevice() {
    // ISSUE 3: NOT SCALABLE (DOES NOT GROW WELL)
    // If we add 10 new devices, we have to write 10 new lines here.
    // Example: tvDevice?.showTemp(temparature);
    displayDevice?.showTemp(temparature);
  }
}

class WithoutObserverPattern {}

void main() {
  DisplayDevice mobileDevice = DisplayDevice();
  WeatherStation station = WeatherStation(mobileDevice);
  //print(station.displayDevice);
  station.setTemparature(10);
  station.setTemparature(20);
  station.notifyDevice();
}
