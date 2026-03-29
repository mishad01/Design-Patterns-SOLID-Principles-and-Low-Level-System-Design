/*
   3. Code Reuse: Mixins
   Composition over Inheritance
  Mixins allow you to reuse a class's code in multiple class hierarchies without
  requiring a parent-child relationship.
*/

mixin class Flyable {
  void fly() {
    print('Animal flies');
  }
}

class Animal {
  void makeSound() {
    print('Animal make a sound');
  }
}

class Duck extends Animal with Flyable {
  @override
  void makeSound() {
    print("Quack Quack");
  }
}

class Ant extends Animal {
  @override
  void makeSound() {
    print("Quack Quack");
  }
}

void main() {
  Ant ant = Ant();
  ant.makeSound();

  Duck duck = Duck();
  duck.fly();
}
