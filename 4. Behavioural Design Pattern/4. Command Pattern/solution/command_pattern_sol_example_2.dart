// Command Pattern - Single File (Clean + Explained)

// 1. Command Interface
abstract class Command {
  void execute();
  // ✅ All actions are now abstracted behind this interface
}

// 2. Receiver (Actual business logic — unchanged)
class Light {
  void turnOn() {
    print("Light is ON");
  }

  void turnOff() {
    print("Light is OFF");
  }
}

// 3. Concrete Commands (wrap actions into objects)

class TurnOnLightCommand implements Command {
  final Light light;

  TurnOnLightCommand(this.light);

  @override
  void execute() {
    light.turnOn();
    // ✅ Delegates work to receiver
  }
}

class TurnOffLightCommand implements Command {
  final Light light;

  TurnOffLightCommand(this.light);

  @override
  void execute() {
    light.turnOff();
  }
}

// 4. Invoker (NO longer depends on Light)

class RemoteControl {
  Command? command;
  // ✅ Can hold ANY command (not just Light-related)

  void setCommand(Command command) {
    this.command = command;
  }

  void pressButton() {
    command?.execute();
    // ✅ Generic execution (decoupled)
  }
}

// 5. Client (wires everything together)

void main() {
  final light = Light();

  // Wrap actions into command objects
  final turnOn = TurnOnLightCommand(light);
  final turnOff = TurnOffLightCommand(light);

  final remote = RemoteControl();

  print("---- Using Command Pattern ----");

  remote.setCommand(turnOn);
  remote.pressButton();
  // Light is ON

  remote.setCommand(turnOff);
  remote.pressButton();
  // Light is OFF
}
