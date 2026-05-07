# Creational Design Patterns

*(Reference: Prateek Narang)*

## What are Creational Patterns?

Imagine you are opening a new franchise of a popular restaurant. You don't want every location to figure out how to set up the kitchen, hire staff, or source ingredients from scratch — you want a **standardized process** that works the same way every time.

In software development, **Creational Design Patterns** solve the same problem for objects. Instead of scattering `new ClassName()` calls all over your code, they give you a **centralized, flexible, and reusable way to create objects**.

- Who decides which type of object to create?
- What if the exact type is only known at runtime?
- What if creating an object is expensive and we want to reuse it?

Creational patterns answer all of these questions.

### Key Benefits:
1. **Flexibility:** Decouple your code from the specific classes it needs to instantiate, so you can swap implementations without touching the rest of the system.
2. **Control:** Give you fine-grained control over *how*, *when*, and *how many times* an object is created.
3. **Reusability:** Centralize object creation logic so it can be shared and maintained in one place.

## Common Uses
- **Controlling instantiation:** Ensuring only one instance of a class exists (e.g., a database connection pool).
- **Hiding complexity:** Letting a factory decide which subclass to return based on runtime conditions.
- **Building complex objects step by step:** Constructing an object that requires many configuration steps in a clean, readable way.

## Agenda: Patterns to Cover
We will explore the following specific Creational Patterns. (Think of them as different strategies for manufacturing objects):

1. **Singleton Pattern** (Like a country having only one President at a time)
2. **Factory Pattern** (Like a vehicle factory that produces Cars, Bikes, or Trucks based on your order)
3. **Abstract Factory Pattern** (Like a furniture brand that produces matching sets — sofa, chair, and table — in a consistent style)
4. **Builder Pattern** (Like customizing a burger step by step — bun, patty, toppings, sauce)
5. **Prototype Pattern** (Like using a template document and duplicating it instead of starting from scratch)