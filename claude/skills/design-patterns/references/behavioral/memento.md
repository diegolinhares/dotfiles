# Memento

Save a snapshot of an object's state so you can restore it later, without exposing its internals.

## The problem you feel

You need undo/redo in a text editor. Or you need to compare "before" and "after" states of a record. Or you need rollback beyond what the database gives you. But the object's internals are private, and you don't want external code poking around its fields to capture state.

## How it works

The object itself creates a snapshot — an opaque, immutable package of its own state. A separate "caretaker" stores the history of snapshots. To undo, pop the last snapshot and tell the object to restore from it. Like saving a video game — the save file captures the complete state at a moment in time. You can restore without knowing how the game engine works internally. The game creates and reads its own saves; external code just stores them.

## You need this when

- Undo/redo requirements
- Comparing "before" and "after" states of an object
- Audit trail or versioning requirements
- Transaction rollback beyond database-level rollbacks

## The trap

- Serializing objects containing non-serializable resources like open connections or file handles.
- Storing too many snapshots without cleanup, leading to memory leaks.
- Exposing memento internals to the caretaker. The memento should be opaque.
