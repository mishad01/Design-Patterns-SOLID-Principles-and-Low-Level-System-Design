# Behavioral Design Patterns

*(Reference: Prateek Narang)*

## What are Behavioral Patterns?

Imagine you are managing a busy restaurant. You have a head chef, sous-chefs, waiters, and a host. For the restaurant to run smoothly, everyone needs to know exactly **how to communicate** and **who is responsible for what**. 
- If a customer places an order, how does the waiter tell the chef? 
- If a dish is ready, how does the chef let the waiter know?

In software development, **Behavioral Design Patterns** are the rules for how different objects (like the restaurant staff) talk to each other, interact, and pass information.

While some patterns focus on *creating* objects or *structuring* them, Behavioral Patterns focus entirely on **communication, workflow, and responsibility**.

### Key Benefits:
1. **Clear Communication (Control Flow):** They simplify complex situations by defining clear, easy-to-follow paths for how objects should send messages to each other.
2. **Teamwork (Loose Coupling):** They help objects work together smoothly without being too strictly tied to one another. This gives your code flexibility.
3. **Managing State:** They provide smart solutions for tracking what an object is currently doing and how it should behave.

## Common Uses
- **Coordinating Interactions:** Setting up a clear way for multiple objects to work together without creating confusing, tangled code.
- **Managing State Transitions:** Handling how an object changes its behavior based on its current situation efficiently.

## Agenda: Patterns to Cover
We will explore the following specific Behavioral Patterns. (Think of them as different communication strategies):

1. **Observer Pattern** (Like subscribing to a YouTube channel to get notified)
2. **Strategy Pattern** (Like choosing different routes or vehicles to get to work)
3. **Command Pattern** (Like writing an order on a slip and handing it to the kitchen)
4. **Template Method Pattern** (Like following a standard recipe but changing a few ingredients)
5. **Iterator Pattern** (Like safely swiping through a playlist of songs)
6. **State Pattern** (Like a smartphone changing behavior when it goes into "Low Power Mode")
7. **Mediator Pattern** (Like an air traffic controller directing planes so they don't crash)
8. **Memento Pattern** (Like saving your game progress so you can undo mistakes)