Factory Design Pattern
Motivation
Consider an example of a transportation service app where users can
request different types of transport vehicles (e.g., Car, Bike, Bus). You
might initially create separate classes for each type, and create instances
like this:
But as the system evolves, managing object creation directly like this can
become complex, especially when adding new types of vehicles.
Code
Problems:
1. 2. The client code (i.e., TransportService) is tightly coupled to concrete
classes (Car, Bike, Bus).
Adding new transport types requires modifying client code.
Factory Design Pattern
The Factory Pattern helps centralize the creation logic and delegates the
responsibility of creating objects to factory classes, which decide the specific
class to instantiate. This allows the code to adhere to the Open/Closed
Principle by letting new types of vehicles be added without modifying the
existing code.
Factory Design Pattern
1. 2. 3. Factory Class: The TransportFactory class contains the logic to
create different types of transport based on the input string. This abstracts
the creation logic and makes it easier to add or change transport types.
Decoupling: The TransportService class (client) no longer needs to
know the details of how Car, Bike, or Bus are created. It simply calls the
factory method.
Flexibility: Adding a new transport type (e.g., Truck) only requires
modifying the factory, not the client code.
Factory Design Benefits
Benefits of Factory Pattern:
1. 2. 3. Loose Coupling: The client is decoupled from the specifics of object
creation.
Single Responsibility Principle: The factory class handles the
responsibility of object creation.
Open/Closed Principle: We can easily add new transport types without
changing the client code, making the system open to extension and closed
to modification.
Real World Use Cases
● GUI Frameworks: When the type of button or widget to be created is
determined at runtime based on the platform (e.g., Windows, macOS, Linux).
● Database Connectivity: When choosing different types of databases (e.g.,
SQL, NoSQL) based on configuration.
● Document Conversion Tools: Where the type of file (e.g., PDF, Word, HTML)
to be created depends on user input or settings.
The Factory Design Pattern is a fundamental tool to reduce coupling and centralize
object creation logic, especially in systems that need to support multiple types of
objects.