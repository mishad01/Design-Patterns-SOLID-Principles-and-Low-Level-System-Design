// Receiver: the actual device
class Light {
  void turnOn() {
    print("Light is ON");
  }

  void turnOff() {
    print("Light is OFF");
  }
}

// Invoker: supposed to just trigger actions
class RemoteControl {
  late Light light;
  // ❌ Problem: RemoteControl is tightly coupled to Light
  // It directly depends on a specific class instead of abstraction

  void pressOnButton() {
    light.turnOn();
    // ❌ Problem: Direct method call
    // Remote must know WHAT to call and HOW it works
  }

  void pressOffButton() {
    light.turnOff();
    // ❌ Same issue: hardcoded behavior
  }
}

void main() {
  final light = Light();
  final remote = RemoteControl();

  remote.light = light;
  // ❌ Problem: We must manually inject a specific device
  // Remote cannot work generically with other devices

  remote.pressOnButton();
  // ❌ Problem: This only works for Light
  // Cannot reuse for Fan, AC, etc.

  remote.pressOffButton();
}
