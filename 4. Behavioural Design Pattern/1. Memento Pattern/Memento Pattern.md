# The Memento Pattern

## The Problem
Imagine you are typing a long document in a Text Editor (like MS Word or Google Docs). You make a mistake and want to hit **Undo**. 
To make "Undo" work, the Text Editor needs to remember exactly what your document looked like 5 minutes ago. 

But here is the catch: We don't want the Text Editor to share all its private, inner secrets (like how it formats text or manages memory) with the rest of the program just to save its state. If we expose too much, we break a core rule of programming called **Encapsulation** (keeping private data private).

*How do we save and restore a snapshot of an object without exposing its private details?*

## The Solution: Memento Pattern
The **Memento Pattern** is like a **Save File** in a video game, or a **Time Capsule**.

It takes a snapshot (a *memento*) of the object's current state and saves it securely. Later, if you need to go back in time, you just hand the snapshot back to the object, and it restores its exact condition from that moment.

### How it works cleanly (The 3 Roles):
1. **The Originator (The Object):** The object (like your Text Editor code) that you want to save. It creates the snapshot, and it's the only one that knows how to read the snapshot to restore itself.
2. **The Memento (The Time Capsule):** A secure box that holds the snapshot data. No one else is allowed to peek inside this box except the Originator.
3. **The Caretaker (The History Manager):** The object that holds on to all the Time Capsules (like an Undo list). It knows *when* to save and *when* to undo, but it is not allowed to open the capsule and look inside.

### Summary:
The Memento pattern lets you take a snapshot of an object's state so you can restore it later, while keeping everything safely locked away so no other parts of your code can mess with it.